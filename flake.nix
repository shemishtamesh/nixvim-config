{
  description = "A nixvim configuration";

  inputs = {
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      nixvim,
      flake-parts,
      ...
    }@inputs:
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
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            module = import ./config;
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          packages = {
            default = nvim;
          };
        };
    };
}
