{ utils, ... }:
{
  plugins.flash = {
    enable = true;
    settings = {
      modes = {
        search.enabled = false;
        char.enabled = false;
      };
      jump.autojump = true;
    };
  };

  keymaps = [
    (utils.map "n" "<C-s>" "<cmd>lua require('flash').jump()<cr>" { })
  ];
}
