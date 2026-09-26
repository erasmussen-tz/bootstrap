{
  description = "OpenTofu management of version control platforms";

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
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              age
              gh
              gnumake
              nixfmt
              opentofu
              sops
              terraform-backend-git
            ];
          };

          treefmt.programs = {
            actionlint.enable = true;
            nixfmt.enable = true;
            terraform = {
              enable = true;
              package = pkgs.opentofu;
            };
          };
        };
    };
}
