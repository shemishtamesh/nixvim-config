{ utils, ... }:
{
  plugins.aerial.enable = true;
  keymaps = [
    (utils.map "n" "<leader>O" "<cmd>:AerialToggle<cr>" { silent = true; })
  ];
}
