{ utils, ... }:
{
  plugins.nvim-surround.enable = true;
  keymaps = [
    (utils.map "i" "<C-g>s" "<Plug>(nvim-surround-insert)" { })
    (utils.map "i" "<C-g>S" "<Plug>(nvim-surround-insert-line)" { })
    (utils.map "n" "<leader>s" "<Plug>(nvim-surround-normal)" { })
    (utils.map "n" "<leader>ss" "<Plug>(nvim-surround-normal-cur)" { })
    (utils.map "n" "<leader>S" "<Plug>(nvim-surround-normal-line)" { })
    (utils.map "n" "<leader>SS" "<Plug>(nvim-surround-normal-cur-line)" { })
    (utils.map "v" "S" "<Plug>(nvim-surround-visual)" { })
    (utils.map "v" "gS" "<Plug>(nvim-surround-visual-line)" { })
    (utils.map "n" "ds" "<Plug>(nvim-surround-delete)" { })
    (utils.map "n" "cs" "<Plug>(nvim-surround-change)" { })
    (utils.map "n" "cS" "<Plug>(nvim-surround-change-line)" { })
  ];
}
