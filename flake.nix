{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          defaultPalette = {
            primary = "#ff0000";
            secondary = "#00ff00";
            accent = "#0000ff";
          };
          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = { };
          };
          makeNixvim =
            {
              colorPalette ? defaultPalette,
            }:
            nixvim'.makeNixvimWithModule (
              nixvimModule
              // {
                extraSpecialArgs = nixvimModule.extraSpecialArgs // {
                  colorPalette = colorPalette;
                };
              }
            );
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            custom = makeNixvim { };
            default = makeNixvim;
          };
        };
    };
}
