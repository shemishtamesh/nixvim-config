{ pkgs, ... }:
{
  plugins.jupytext = {
    enable = true;
    settings = {
      output_extension = "md";
      style = "markdown";
      force_ft = "markdown";
    };
  };
  extraPackages = with pkgs; [ python3Packages.jupytext ];
}
