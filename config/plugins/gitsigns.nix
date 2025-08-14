let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.gitsigns.enable = true;

  keymaps = [
    # defined outside of lsp for whichkey
    (keymap "n" "<leader>gP" "<cmd>Gitsigns nav_hunk first<CR>" { silent = true; })
    (keymap "n" "<leader>gp" "<cmd>Gitsigns nav_hunk prev<CR>" { silent = true; })
    (keymap "n" "<leader>gn" "<cmd>Gitsigns nav_hunk next<CR>" { silent = true; })
    (keymap "n" "<leader>gN" "<cmd>Gitsigns nav_hunk last<CR>" { silent = true; })

    (keymap "n" "<leader>gv" "<cmd>Gitsigns preview_hunk<CR>" { silent = true; })

    (keymap "n" "<leader>gs" "<cmd>Gitsigns select_hunk<CR>" { silent = true; })

    (keymap "n" "<leader>gR" "<cmd>Gitsigns reset_buffer<CR>" { silent = true; })
    (keymap "n" "<leader>gr" "<cmd>Gitsigns reset_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>ga" "<cmd>Gitsigns stage_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>gA" "<cmd>Gitsigns stage_buffer<CR>" { silent = true; })

    (keymap "n" "<leader>gw" "<cmd>Gitsigns toggle_word_diff<CR>" { silent = true; })

    (keymap "n" "<leader>gb" "<cmd>Gitsigns blame_line<CR>" { silent = true; })
    (keymap "n" "<leader>gB" "<cmd>Gitsigns blame<CR>" { silent = true; })

    (keymap "n" "<leader>gq" "<cmd>Gitsigns setqflist<CR>" { silent = true; })
  ];
}
