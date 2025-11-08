{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    teamtype
  ];
}
