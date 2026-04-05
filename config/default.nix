{ lib, ... }:
{
  imports = [
    ./options.nix
    ./autocommands.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
    ./lsp
    ./ftplugin.nix
  ];

  _module.args = {
    utils = import ./utils.nix lib;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
}
