{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      ...
    }@inputs:
    let
      per_system = inputs.nixpkgs.lib.genAttrs inputs.nixpkgs.lib.systems.doubles.all;
    in
    {
      packages = per_system (
        system:
        let
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            module = import ./config;
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          wrappedNvim =
            system: nvimToWrap:
            with nixpkgs.legacyPackages.${system};
            writeShellScriptBin "nvim" ''
              export PATH=${
                lib.makeBinPath [
                  gcc
                  ripgrep
                  fd
                  python3Packages.jupytext
                  python3Packages.pylatexenc
                ]
              }:$PATH
              exec ${nvimToWrap}/bin/nvim "$@"
            '';
        in
        {
          inherit nvim;
          default = wrappedNvim system nvim;
        }
      );
    };
}
