{
  description = "Static site builder for patrickstevens.co.uk";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    anki-compiler.url = "github:Smaug123/anki-dotnet";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    anki-compiler,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in let
      texlive = pkgs.texlive.combine {
        inherit (pkgs.texlive) scheme-medium mdframed etoolbox zref needspace tikz-cd;
      };
    in rec {
      packages = flake-utils.lib.flattenTree {
        gitAndTools = pkgs.gitAndTools;
      };
      defaultPackage = let
        createShellScript = name: contents:
          pkgs.stdenv.mkDerivation {
            __contentAddressed = true;
            pname = name;
            version = "0.1.0";
            src = contents;

            buildInputs = [
              pkgs.shellcheck
            ];

            phases = ["configurePhase" "buildPhase" "installPhase"];

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
          };
      in let
        buildLatex = createShellScript "latex" ./docker/latex/build.sh;
        buildPictures = createShellScript "pictures" ./docker/pictures/build.sh;
        buildHugo = createShellScript "hugo" ./docker/hugo/build.sh;
        buildAnki = createShellScript "anki" ./build/anki.sh;
        buildEverything = createShellScript "all" ./build/all.sh;
      in let
        katex = pkgs.stdenv.mkDerivation {
          pname = "katex";
          version = "0.1.0";
          src = pkgs.fetchFromGitHub {
            owner = "KaTeX";
            repo = "KateX";
            rev = "4f1d9166749ca4bd669381b84b45589f1500a476";
            sha256 = "sha256-hDHo7JQAo+fGxQvY5OtXlfh+e6PjlVIQPTyCa3Fjg0Y=";
          };

          buildInputs = [pkgs.nodejs pkgs.yarn];

          buildPhase = ''
            export HOME=$(mktemp -d)
            yarn --immutable
            yarn build
            find . -type f -name "katex.min.*"
          '';

          installPhase = ''
            mkdir -p "$out/fonts"
            cp ./fonts/* "$out/fonts"
            cp -r ./dist "$out/dist"
          '';
        };
      in let
        pdfs = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk-latex";
          version = "0.1.2";
          src = pkgs.fetchFromGitHub {
            owner = "Smaug123";
            repo = "static-site-pdfs";
            rev = "d8cf76c2f1f669e177cff5217f9ebbf763070d71";
            sha256 = "sha256-BH8EoVP4jtqisjIuayDKxXrvjzyNrJJP/OJf6rH0zgE=";
          };
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
        };
      in let
        images = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
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
            ls -la .
            mkdir -p $out
            mv ./* $out
          '';
        };
      in let
        extraContent = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk-extraContent";
          version = "0.1.0";
          src = ./extra-content;
          buildInputs = [];
          installPhase = ''
            mkdir -p $out
            cp -r ./. $out
          '';
        };
      in let
        ankiDecks = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk-anki";
          version = "0.2.0";
          src = pkgs.fetchFromGitHub {
            owner = "Smaug123";
            repo = "anki-decks";
            rev = "589a52858d5dca419ad8866946b7418f30b36eff";
            sha256 = "sha256-tc3Twev82WVFbHbEgLVwgcQnPaEYGAUHqw8lpj1Kuqk=";
          };
          buildInputs = [];
          installPhase = ''
            pwd
            ${./build/anki.sh} . "${anki-compiler.packages.${system}.default}/bin/AnkiStatic" "$out"
          '';
        };
      in
        pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk";
          version = "0.1.0";

          src = pkgs.fetchFromGitHub {
            owner = "Smaug123";
            repo = "static-site-content";
            rev = "67c4f084fc3425e86c1f98e3b0e5fa1b8049296d";
            sha256 = "sha256-fOhvSnah74ZLYV130HOYnVduw5qpK32GikDdC6u/4gA=";
          };

          buildInputs = [
            pkgs.hugo
            buildHugo
            images
            pdfs
            ankiDecks
            katex
            extraContent
            pkgs.html-tidy
          ];

          buildPhase = ''
            ${./build/all.sh} "${pdfs}" "${images}" "${ankiDecks}" "${buildHugo}" "${katex}" "${extraContent}"
          '';

          checkPhase = ''
            echo "Linting HTML."
            ${pkgs.html-tidy}/bin/tidy
          '';

          installPhase = ''
            mv output $out
          '';
        };
    });
}
