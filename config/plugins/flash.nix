{
  plugins.flash = {
    enable = true;
    settings = {
      modes = {
        search.enabled = false;
        char.enabled = false;
      };
    };
  };

  keymaps = [
    (
      (import ../nix_functions.nix).keymap
      "n"
      "<C-g>"
      "<CMD>lua require('flash').jump()<CR>"
      { }
    )
  ];
}
