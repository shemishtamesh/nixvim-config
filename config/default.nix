{ pkgs, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
