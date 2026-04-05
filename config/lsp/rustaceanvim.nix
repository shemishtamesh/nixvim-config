{ pkgs, ... }:
{
  plugins.rustaceanvim.enable = true;
  extraPackages = with pkgs; [
    cargo
    rustc
  ];
}
