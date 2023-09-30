{
  description = "Static site builder for patrickstevens.co.uk";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    scripts.url = "github:Smaug123/flake-shell-script";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    extra-content = {
      url = "path:/Users/patrick/Desktop/website/extra-site-content";
      flake = false;
    };
    katex-source = {
      url = "github:KaTeX/KaTeX/4f1d9166749ca4bd669381b84b45589f1500a476";
      flake = false;
    };
    images = {
      url = "path:/Users/patrick/Desktop/website/static-site-images";
      inputs.flake-utils.follows = "flake-utils";
    };
    pdfs = {
      url = "github:Smaug123/static-site-pdfs";
      inputs.flake-utils.follows = "flake-utils";
    };
    anki-decks = {
      url = "github:Smaug123/anki-decks";
      inputs.flake-utils.follows = "flake-utils";
    };
    content-source = {
      url = "github:Smaug123/static-site-content";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    katex-source,
    images,
    pdfs,
    anki-decks,
    content-source,
    extra-content,
    scripts,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      packages = flake-utils.lib.flattenTree {
        gitAndTools = pkgs.gitAndTools;
      };
      defaultPackage =
      let
        buildHugo = scripts.lib.createShellScript pkgs "hugo" ./docker/hugo/build.sh;
      in let
        katex = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "katex";
          version = "0.1.0";
          src = katex-source;

          buildInputs = [pkgs.nodejs pkgs.yarn];

          buildPhase = ''
            export HOME=$(mktemp -d)
            yarn --immutable
            yarn build
          '';

          installPhase = ''
            mkdir -p "$out/fonts"
            cp ./fonts/* "$out/fonts"
            cp -r ./dist "$out/dist"
          '';
        };
      in let
        extraContent = pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk-extraContent";
          version = "0.1.0";
          src = extra-content;
          buildInputs = [];
          installPhase = ''
            mkdir -p $out
            cp -r ./. $out
          '';
        };
      in
        pkgs.stdenv.mkDerivation {
          __contentAddressed = true;
          pname = "patrickstevens.co.uk";
          version = "0.1.0";

          src = content-source;

          buildInputs = [
            pkgs.hugo
            pkgs.html-tidy
          ];

          buildPhase = ''
            ${scripts.lib.createShellScript pkgs "all" ./build/all.sh}/run.sh "${pdfs.packages.${system}.default}" "${images}" "${anki-decks.packages.${system}.default}" "${buildHugo}" "${katex}" "${extraContent}"
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
