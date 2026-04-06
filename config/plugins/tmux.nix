{ pkgs, utils, ... }:
{
  plugins.tmux-navigator.enable = true;
  extraPlugins = with pkgs.vimPlugins; [ vim-tpipeline ];
  extraConfigLua = ''
    if vim.env.TMUX then
      vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme", "VimResized" }, {
        callback = function()
          vim.defer_fn(function()
            vim.opt.laststatus = 1
          end, 100)
        end,
      })

      vim.o.laststatus = 1
    end
  '';
  keymaps = [
    (utils.map "v" "<c-h>" ":<c-u>TmuxNavigateLeft<cr>gv" { silent = true; })
    (utils.map "v" "<c-j>" ":<c-u>TmuxNavigateDown<cr>gv" { silent = true; })
    (utils.map "v" "<c-k>" ":<c-u>TmuxNavigateUp<cr>gv" { silent = true; })
    (utils.map "v" "<c-l>" ":<c-u>TmuxNavigateRight<cr>gv" { silent = true; })
    (utils.map "v" "<c-\\>" ":<c-u>TmuxNavigatePrevious<cr>gv" { silent = true; })

    (utils.map "i" "<c-h>" "<c-o>:TmuxNavigateLeft<cr>" { silent = true; })
    (utils.map "i" "<c-j>" "<c-o>:TmuxNavigateDown<cr>" { silent = true; })
    (utils.map "i" "<c-k>" "<c-o>:TmuxNavigateUp<cr>" { silent = true; })
    (utils.map "i" "<c-l>" "<c-o>:TmuxNavigateRight<cr>" { silent = true; })
    (utils.map "i" "<c-\\>" "<c-o>:TmuxNavigatePrevious<cr>" { silent = true; })

    (utils.map "t" "<c-h>" "<c-\\><c-o>:TmuxNavigateLeft<CR>" { silent = true; })
    (utils.map "t" "<c-j>" "<c-\\><c-o>:TmuxNavigateDown<CR>" { silent = true; })
    (utils.map "t" "<c-k>" "<c-\\><c-o>:TmuxNavigateUp<CR>" { silent = true; })
    (utils.map "t" "<c-l>" "<c-\\><c-o>:TmuxNavigateRight<CR>" { silent = true; })
    (utils.map "t" "<c-\\>" "<c-\\><c-o>:TmuxNavigatePrevious<CR>" { silent = true; })
  ];
}
