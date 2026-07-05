{ utils, ... }:
{
  plugins.aerial.enable = true;
  keymaps = [
    (utils.map "n" "<leader>tO" "<cmd>:AerialToggle<cr>" { silent = true; desc = "Toggle Symbols Outline (Aerial)"; })
  ];
}
