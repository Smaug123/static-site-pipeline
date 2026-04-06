{
  description = "Static site builder for patrickstevens.co.uk";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    scripts.url = "github:Smaug123/flake-shell-script";
    nixpkgs.url = "github:NixOS/nixpkgs";
    extra-content = {
      url = "path:/Users/patrick/Desktop/website/extra-site-content";
      flake = false;
    };
    katex = {
      url = "github:Smaug123/KaTeX/nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    images = {
      url = "git+file:/Users/patrick/Desktop/website/static-site-images";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    pdfs = {
      url = "github:Smaug123/static-site-pdfs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    anki-decks = {
      url = "github:Smaug123/anki-decks";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    katex,
    images,
    pdfs,
    anki-decks,
    extra-content,
    scripts,
  }: let
    mkKatexParts = {
      pkgs,
      buildSystem ? pkgs.stdenv.buildPlatform.system,
      src ? katex.outputs.packages.${buildSystem}.default,
    }: let
      buildPkgs = pkgs.buildPackages or pkgs;
    in
      pkgs.stdenvNoCC.mkDerivation {
        pname = "katex";
        version = "0.1.0";
        inherit src;

        installPhase = ''
          mkdir "$out"
          cp -r . "$out/dist"
        '';
      };
    mkWebsite = {
      pkgs,
      buildSystem ? pkgs.stdenv.buildPlatform.system,
      extraContent ? extra-content,
      imagesPackage ? images.packages.${buildSystem}.default,
      pdfsPackage ? pdfs.packages.${buildSystem}.default,
      ankiDecksPackage ? anki-decks.packages.${buildSystem}.default,
      katexParts ? mkKatexParts {
        inherit pkgs buildSystem;
      },
    }: let
      buildPkgs = pkgs.buildPackages or pkgs;
      buildHugo = scripts.lib.createShellScript buildPkgs "hugo" ./docker/hugo/build.sh;
      websiteBuilder = scripts.lib.createShellScript buildPkgs "all" ./build/all.sh;
    in
      pkgs.stdenvNoCC.mkDerivation {
        pname = "patrickstevens.co.uk";
        version = "0.1.0";

        src = ./hugo;

        nativeBuildInputs = [
          buildPkgs.bash
          buildPkgs.hugo
          buildPkgs.html-tidy
        ];

        buildPhase = ''
          ${websiteBuilder}/run.sh "${pdfsPackage}" "${imagesPackage}" "${ankiDecksPackage}" "${buildHugo}" "${katexParts}" "${extraContent}"
        '';

        checkPhase = ''
          echo "Linting HTML."
          ${buildPkgs.html-tidy}/bin/tidy
        '';

        installPhase = ''
          mv output $out
        '';
      };
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      buildPkgs = pkgs.buildPackages or pkgs;
      website = mkWebsite {inherit pkgs;};
    in {
      packages = flake-utils.lib.flattenTree {
        default = website;
      };
      checks = {
        fmt-check = pkgs.stdenvNoCC.mkDerivation {
          name = "fmt-check";
          src = ./.;
          nativeBuildInputs = [pkgs.alejandra pkgs.shellcheck pkgs.shfmt];
          checkPhase = ''
            find . -type f -name '*.sh' | xargs shfmt -d -s -i 2 -ci
            alejandra -c .
            find . -type f -name '*.sh' -exec shellcheck -x {} \;
          '';
          installPhase = "mkdir $out";
          dontBuild = true;
          doCheck = true;
        };

        website-check = pkgs.stdenvNoCC.mkDerivation {
          name = "website-check";
          src = website;
          installPhase = "mkdir $out";
          dontBuild = true;
          doCheck = true;
          checkPhase = ''
            ${buildPkgs.bash}/bin/bash ${scripts.lib.createShellScript buildPkgs "linkcheck" ./linkcheck.sh}/run.sh ${buildPkgs.lynx}/bin/lynx
          '';
        };
      };
    })
    // {
      lib = {
        inherit mkKatexParts mkWebsite;
      };
    };
}
