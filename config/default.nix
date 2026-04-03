{ lib, ... }:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
    ./ftplugin.nix
  ];

  _module.args = {
    utils = import ./utils.nix lib;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
