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
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in let
      buildHugo = scripts.lib.createShellScript pkgs "hugo" ./docker/hugo/build.sh;
    in let
      katex-parts = pkgs.stdenv.mkDerivation {
        __contentAddressed = true;
        pname = "katex";
        version = "0.1.0";
        src = katex.outputs.packages.${system}.default;

        installPhase = ''
          mkdir "$out"
          ls -la .
          cp -r ./libexec/katex/dist "$out/dist"
        '';
      };
    in let
      website = pkgs.stdenv.mkDerivation {
        __contentAddressed = true;
        pname = "patrickstevens.co.uk";
        version = "0.1.0";

        src = ./hugo;

        buildInputs = [
          pkgs.hugo
          pkgs.html-tidy
        ];

        buildPhase = ''
          ${scripts.lib.createShellScript pkgs "all" ./build/all.sh}/run.sh "${pdfs.packages.${system}.default}" "${images.packages.${system}.default}" "${anki-decks.packages.${system}.default}" "${buildHugo}" "${katex-parts}" "${extra-content}"
        '';

        checkPhase = ''
          echo "Linting HTML."
          ${pkgs.html-tidy}/bin/tidy
        '';

        installPhase = ''
          mv output $out
        '';
      };
    in {
      packages = flake-utils.lib.flattenTree {
        gitAndTools = pkgs.gitAndTools;
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
            ${pkgs.bash}/bin/bash ${scripts.lib.createShellScript pkgs "linkcheck" ./linkcheck.sh}/run.sh ${pkgs.lynx}/bin/lynx
          '';
        };
      };
    });
}
