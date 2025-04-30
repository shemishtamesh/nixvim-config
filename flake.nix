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
      flake =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          wrappedNvim =
            nvimToWrap:
            with pkgs;
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
        };
      perSystem =
        { system, self', ... }:
        let
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            module = import ./config;
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          packages = {
            inherit nvim;
            default = self'.wrappedNvim system nvim;
          };
        };
    };
}
