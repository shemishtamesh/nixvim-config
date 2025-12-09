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
      apps = per_system (system: {
        view_config = {
          type = "app";
          program = nixpkgs.lib.getExe (
            nixpkgs.legacyPackages.${system}.writeShellApplication {
              name = "view_config";
              text =
                # sh
                ''
                  nix build
                  tmp_init_path=/tmp/nixvim-print-init-output-init.lua
                  ./result/bin/nixvim-print-init > $tmp_init_path
                  $EDITOR $tmp_init_path
                  rm $tmp_init_path
                '';
            }
          );
        };
      });
    };
}
