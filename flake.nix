{
  description = "A Nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/triplet";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem =
        { system, pkgs, ... }:
        let
          # 1password-cli is unfree-licensed; allow it specifically rather
          # than allowing unfree packages wholesale.
          unfreePkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: builtins.elem (pkg.pname or "") [ "1password-cli" ];
          };

          # `terraform` in $PATH execs opentofu, so muscle memory and any
          # script still typing `terraform` keeps working, but tofu is what
          # actually runs.
          terraformAlias = pkgs.writeShellScriptBin "terraform" ''exec tofu "$@"'';
        in
        {
          devShells.default = pkgs.mkShellNoCC {
            packages =
              (with pkgs; [
                gnumake
                nixfmt
                sops
                age
                ssh-to-age
                opentofu
              ])
              ++ [ terraformAlias ]
              ++ (with unfreePkgs; [ _1password-cli ]);
          };

          treefmt.programs = {
            nixfmt.enable = true;
          };
        };
    };
}
