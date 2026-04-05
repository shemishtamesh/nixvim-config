{ pkgs, ... }:
{
  plugins.typescript-tools.enable = true;
  extraPackages = with pkgs; [
    typescript
  ];

}
