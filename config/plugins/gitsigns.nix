let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.gitsigns = {
    enable = true;
    settings = {
      current_line_blame = false;
      current_line_blame_formatter = "<author>, <author_time:%R>: <summary>";
      current_line_blame_opts = {
        virt_text = true;
        virt_text_pos = "eol";
        delay = 0;
      };
      diff_opts.vertical = true;
      signcolumn = false;
      numhl = true;
      watch_gitdir.follow_files = true;
    };
  };

  keymaps = [
    (keymap "n" "[G" "<cmd>Gitsigns nav_hunk first<CR>" { silent = true; })
    (keymap "n" "[g" "<cmd>Gitsigns nav_hunk prev<CR>" { silent = true; })
    (keymap "n" "]g" "<cmd>Gitsigns nav_hunk next<CR>" { silent = true; })
    (keymap "n" "]G" "<cmd>Gitsigns nav_hunk last<CR>" { silent = true; })

    (keymap "n" "<leader>cv" "<cmd>Gitsigns preview_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>cV" "<cmd>Gitsigns preview_hunk_inline<CR>" { silent = true; })

    (keymap "n" "<leader>cs" "<cmd>Gitsigns select_hunk<CR>" { silent = true; })

    (keymap "n" "<leader>cR" "<cmd>Gitsigns reset_buffer<CR>" { silent = true; })
    (keymap "n" "<leader>cr" "<cmd>Gitsigns reset_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>ca" "<cmd>Gitsigns stage_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>cA" "<cmd>Gitsigns stage_buffer<CR>" { silent = true; })

    (keymap "n" "<leader>cw" "<cmd>Gitsigns toggle_word_diff<CR>" { silent = true; })

    (keymap "n" "<leader>cb" "<cmd>Gitsigns blame_line<CR>" { silent = true; })
    (keymap "n" "<leader>cB" "<cmd>Gitsigns blame<CR>" { silent = true; })
    (keymap "n" "<leader>cl" "<cmd>Gitsigns toggle_current_line_blame<CR>" { silent = true; })

    (keymap "n" "<leader>cq" "<cmd>Gitsigns setqflist<CR>" { silent = true; })

    (keymap "n" "<leader>cd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>cD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<CR>" {
      silent = true;
    })
  ];
}
