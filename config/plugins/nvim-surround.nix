{ ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.nvim-surround.enable = true;
  keymaps = [
    (keymap "i" "<C-g>s" "<Plug>(nvim-surround-insert)" { })
    (keymap "i" "<C-g>S" "<Plug>(nvim-surround-insert-line)" { })
    (keymap "n" "<leader>s" "<Plug>(nvim-surround-normal)" { })
    (keymap "n" "<leader>ss" "<Plug>(nvim-surround-normal-cur)" { })
    (keymap "n" "<leader>S" "<Plug>(nvim-surround-normal-line)" { })
    (keymap "n" "<leader>SS" "<Plug>(nvim-surround-normal-cur-line)" { })
    (keymap "v" "S" "<Plug>(nvim-surround-visual)" { })
    (keymap "v" "gS" "<Plug>(nvim-surround-visual-line)" { })
    (keymap "n" "ds" "<Plug>(nvim-surround-delete)" { })
    (keymap "n" "cs" "<Plug>(nvim-surround-change)" { })
    (keymap "n" "cS" "<Plug>(nvim-surround-change-line)" { })
  ];
}
