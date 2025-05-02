{ pkgs, ... }:
{
  plugins = {
    jupytext.enable = true;
  };
  extraPackages = with pkgs; [ python3Packages.jupytext ];
}
