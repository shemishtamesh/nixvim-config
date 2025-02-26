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
          pkgs = nixpkgs.legacyPackages.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            module = import ./config;
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;

          wrappedNvim =
            nvimToWrap:
            with pkgs;
            writeShellScriptBin "nvim" ''
              export PATH=${
                lib.makeBinPath [
                  ripgrep
                  fd
                  python3Packages.jupytext
                ]
              }:$PATH
              exec ${nvimToWrap}/bin/nvim "$@"
            '';
        in
        {
          packages = {
            inherit nvim;
            default = wrappedNvim nvim;
          };
        };
    };
}
