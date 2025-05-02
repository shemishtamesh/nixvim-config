{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
  ];

  extraPackages = with pkgs; [
    python3Packages.jupytext
    python3Packages.pylatexenc
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
