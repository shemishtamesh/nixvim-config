{ pkgs, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.tmux-navigator.enable = true;
  extraPlugins = with pkgs.vimPlugins; [ vim-tpipeline ];
  extraConfigLua = ''
    if vim.env.TMUX then
      vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme" }, {
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
    (keymap "i" "<c-h>" "<c-o>:TmuxNavigateLeft<cr>" { silent = true; })
    (keymap "i" "<c-j>" "<c-o>:TmuxNavigateDown<cr>" { silent = true; })
    (keymap "i" "<c-k>" "<c-o>:TmuxNavigateUp<cr>" { silent = true; })
    (keymap "i" "<c-l>" "<c-o>:TmuxNavigateRight<cr>" { silent = true; })
    (keymap "i" "<c-\\>" "<c-o>:TmuxNavigatePrevious<cr>" { silent = true; })

    (keymap "v" "<c-h>" ":<c-u>TmuxNavigateLeft<cr>gv" { silent = true; })
    (keymap "v" "<c-j>" ":<c-u>TmuxNavigateDown<cr>gv" { silent = true; })
    (keymap "v" "<c-k>" ":<c-u>TmuxNavigateUp<cr>gv" { silent = true; })
    (keymap "v" "<c-l>" ":<c-u>TmuxNavigateRight<cr>gv" { silent = true; })
    (keymap "v" "<c-\\>" ":<c-u>TmuxNavigatePrevious<cr>gv" { silent = true; })
  ];
}
