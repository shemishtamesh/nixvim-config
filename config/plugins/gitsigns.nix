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
    (keymap "n" "[G" "<cmd>Gitsigns nav_hunk first<CR>" { })
    (keymap "n" "[g" "<cmd>Gitsigns nav_hunk prev<CR>" { })
    (keymap "n" "]g" "<cmd>Gitsigns nav_hunk next<CR>" { })
    (keymap "n" "]G" "<cmd>Gitsigns nav_hunk last<CR>" { })

    (keymap "n" "<leader>cv" "<cmd>Gitsigns preview_hunk<CR>" { })
    (keymap "n" "<leader>cV" "<cmd>Gitsigns preview_hunk_inline<CR>" { })

    (keymap "n" "<leader>cs" "<cmd>Gitsigns select_hunk<CR>" { })

    (keymap "n" "<leader>cR" "<cmd>Gitsigns reset_buffer<CR>" { })
    (keymap "n" "<leader>cr" "<cmd>Gitsigns reset_hunk<CR>" { })
    (keymap "n" "<leader>ca" "<cmd>Gitsigns stage_hunk<CR>" { })
    (keymap "n" "<leader>cA" "<cmd>Gitsigns stage_buffer<CR>" { })

    (keymap "n" "<leader>cw" "<cmd>Gitsigns toggle_word_diff<CR>" { })

    (keymap "n" "<leader>cb" "<cmd>Gitsigns blame_line<CR>" { })
    (keymap "n" "<leader>cB" "<cmd>Gitsigns blame<CR>" { })
    (keymap "n" "<leader>cl" "<cmd>Gitsigns toggle_current_line_blame<CR>" { })

    (keymap "n" "<leader>cq" "<cmd>Gitsigns setqflist<CR>" { })

    (keymap "n" "<leader>cd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<CR>" { })
    (keymap "n" "<leader>cD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<CR>" { })
  ];
}
