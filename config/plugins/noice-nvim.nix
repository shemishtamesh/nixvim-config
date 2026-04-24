{ utils, ... }:
{
  plugins = {
    noice = {
      enable = true;
      settings = {
        messages.view_search = "mini";
        cmdline.view = "hover_pill";
        views = {
          hover.border.style = "rounded";
          hover_pill = {
            backend = "popup";
            relative = "cursor";
            position = {
              row = "0";
              col = "-2";
            };
            size = {
              width = "auto";
              height = "auto";
            };
            border = {
              style = [
                ""
                ""
                ""
                [
                  ""
                  "NoiceHoverPillBorder"
                ]
                ""
                ""
                ""
                [
                 ""
                  "NoiceHoverPillBorder"
                ]
              ];
            };
            win_options = {
              winhighlight = {
                Normal = "NoiceHoverPill";
                FloatBorder = "NoiceHoverPillBorder";
              };
              winblend = 0;
            };
          };
        };
      };
    };
  };
  keymaps = [
    (utils.map [ "n" ] "<leader>n" "<cmd>NoicePick<cr>" { })
    (utils.map [ "n" "i" "v" ] "<M-;>" "<cmd>NoiceDismiss<cr>" { })
  ];
  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "NoiceHoverPill", {
      bg = vim.g.base16_gui01,
    })
    vim.api.nvim_set_hl(0, "NoiceHoverPillBorder", {
      fg = vim.g.base16_gui01,
      bg = vim.g.base16_gui00,
    })
  '';
}
