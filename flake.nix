{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      nixvim,
      nixpkgs,
      ...
    }:
    let
      per_system = nixpkgs.lib.genAttrs nixpkgs.lib.systems.doubles.all;
      nixvimModule = system: {
        inherit system;
        module = import ./config;
      };
    in
    {
      checks = per_system (system: {
        default = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule (nixvimModule system);
      });
      packages = per_system (system: {
        default = nixvim.legacyPackages.${system}.makeNixvimWithModule (nixvimModule system);
      });
    };
}
