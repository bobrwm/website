{
  description = "website development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (
      system: let
        packages = import nixpkgs {inherit system;};
      in {
        default = packages.mkShellNoCC {
          packages = [
            packages.nodejs_24
            packages.pnpm
          ];
        };
      }
    );
  };
}
