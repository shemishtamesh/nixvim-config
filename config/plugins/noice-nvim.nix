{utils, ...}:
{
  plugins.noice = {
    enable = true;
    settings = {
      cmdline.view = "hover";
      views.hover.border = {
        style = "rounded";
        padding = [
          0
          4
        ];
      };
    };
  };
  keymaps = [
    (utils.map [ "n" ] "<leader>n" "<cmd>NoicePick<cr>" { })
    (utils.map [ "n" "i" "v" ] "<M-;>" "<cmd>NoiceDismiss<cr>" { })
  ];
}
