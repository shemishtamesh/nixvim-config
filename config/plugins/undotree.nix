{ utils, ... }:
{
  plugins.undotree.enable = true;
  keymaps = [
    (utils.map "n" "<leader>u" "<cmd>UndotreeToggle<cr>" { })
  ];
}
