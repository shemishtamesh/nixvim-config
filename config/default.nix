{
  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    ./options.nix
    ./keymaps.nix
    ./highlights.nix
    ./plugins
  ];
}
