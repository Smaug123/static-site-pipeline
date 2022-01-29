{
  description = "Static site builder for patrickstevens.co.uk";

  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      let texlive = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-medium mdframed etoolbox zref needspace tikz-cd;
      }; in
      rec {
        packages = flake-utils.lib.flattenTree {
          gitAndTools = pkgs.gitAndTools;
        };
        defaultPackage =

          let createShellScript = name: contents: pkgs.stdenv.mkDerivation {
            pname = name;
            version = "0.1.0";
            src = contents;

            buildInputs = [
              pkgs.shellcheck
            ];

            phases = [ "configurePhase" "buildPhase" "installPhase" ];

            configurePhase = ''
              ${pkgs.shellcheck}/bin/shellcheck "${contents}"
            '';

            buildPhase = ''
              cp "${contents}" run.sh
              patchShebangs run.sh
              sed -i 's_"/bin/sh"_"${pkgs.bash}/bin/sh"_' run.sh
            '';

            installPhase = ''
              mkdir -p $out
              mv run.sh $out/run.sh
            '';
          }; in

          let buildLatex = createShellScript "latex" ./docker/latex/build.sh; in
          let buildPictures = createShellScript "pictures" ./docker/pictures/build.sh; in
          let buildHugo = createShellScript "hugo" ./docker/hugo/build.sh; in

          let pdfs = pkgs.stdenv.mkDerivation {
            pname = "patrickstevens.co.uk-latex";
            version = "0.1.2";
            src = ./pdfs;
            buildInputs = [
              texlive
              buildLatex
            ];

            buildPhase = ''
              ${pkgs.bash}/bin/sh ${buildLatex}/run.sh .
            '';

            installPhase = ''
              mkdir -p $out
              cp ./* $out
            '';
          }; in

          let images = pkgs.stdenv.mkDerivation {
            pname = "patrickstevens.co.uk-images";
            version = "0.1.0";
            src = ./images;
            buildInputs = [
              pkgs.imagemagick
              buildPictures
            ];

            buildPhase = ''
              ${pkgs.bash}/bin/sh ${buildPictures}/run.sh .
            '';

            installPhase = ''
              mkdir -p $out
              mv ./* $out
            '';
          }; in

          pkgs.stdenv.mkDerivation {
            pname = "patrickstevens.co.uk";
            version = "0.1.0";

            src = ./hugo;

            buildInputs = [
              pkgs.hugo
              buildHugo
              images
              pdfs
            ];

            buildPhase = ''
              echo "Linking PDFs."
              while read -r texfile
              do
                  DIR=$(dirname "$texfile")
                  TEXFILE_BASE=$(basename "$texfile")
                  PDFFILE=$(basename "$texfile" .tex).pdf
                  mkdir -p "$DIR"
                  cp "${pdfs}/$TEXFILE_BASE" "$texfile"
                  cp "${pdfs}/$PDFFILE" "$DIR/"
              done < "${pdfs}/pdf-targets.txt"

              echo "Linking thumbnails."
              while read -r d
              do
                  DIR=$(dirname "$d")
                  mkdir -p "$DIR" || exit 1
                  DESIRED_LOCATION=$(basename "$d")
                  cp -r "${images}/$DESIRED_LOCATION" "$d"
              done < "${images}/image-targets.txt"

              echo "Building site."
              /bin/sh ${buildHugo}/run.sh . ./output
            '';

            installPhase = ''
              mv output $out
            '';
          };
      });
}

