{ utils, ... }:
{
  plugins = {
    noice = {
      enable = true;
      settings = {
        cmdline.view = "hover";
        views.hover.border.style = "none";
        messages.view_search = "notify";
      };
    };
    notify = {
      enable = true;
      settings = {
        stages = "slide";
        top_down = false;
        minimum_width = 0;
        render = "compact";
      };
    };
  };
  keymaps = [
    (utils.map [ "n" ] "<leader>n" "<cmd>NoicePick<cr>" { })
    (utils.map [ "n" "i" "v" ] "<M-;>" "<cmd>NoiceDismiss<cr>" { })
  ];
}
