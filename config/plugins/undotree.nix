{ utils, ... }:
{
  plugins.undotree.enable = true;
  keymaps = [
    (utils.map "n" "<leader>tu" "<cmd>UndotreeToggle<cr>" { desc = "Toggle Undotree"; })
  ];
}
