{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
    ./ftplugin.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
