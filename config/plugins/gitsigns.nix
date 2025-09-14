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
    (keymap "n" "[G" "<cmd>Gitsigns nav_hunk first<cr>" { })
    (keymap "n" "[g" "<cmd>Gitsigns nav_hunk prev<cr>" { })
    (keymap "n" "]g" "<cmd>Gitsigns nav_hunk next<cr>" { })
    (keymap "n" "]G" "<cmd>Gitsigns nav_hunk last<cr>" { })

    (keymap "n" "<leader>Gv" "<cmd>Gitsigns preview_hunk<cr>" { })
    (keymap "n" "<leader>GV" "<cmd>Gitsigns preview_hunk_inline<cr>" { })

    (keymap "n" "<leader>Gs" "<cmd>Gitsigns select_hunk<cr>" { })

    (keymap "n" "<leader>GR" "<cmd>Gitsigns reset_buffer<cr>" { })
    (keymap "n" "<leader>Gr" "<cmd>Gitsigns reset_hunk<cr>" { })
    (keymap "n" "<leader>Ga" "<cmd>Gitsigns stage_hunk<cr>" { })
    (keymap "n" "<leader>GA" "<cmd>Gitsigns stage_buffer<cr>" { })

    (keymap "n" "<leader>Gw" "<cmd>Gitsigns toggle_word_diff<cr>" { })

    (keymap "n" "<leader>Gb" "<cmd>Gitsigns blame_line<cr>" { })
    (keymap "n" "<leader>GB" "<cmd>Gitsigns blame<cr>" { })
    (keymap "n" "<leader>Gl" "<cmd>Gitsigns toggle_current_line_blame<cr>" { })

    (keymap "n" "<leader>Gq" "<cmd>Gitsigns setqflist<cr>" { })

    (keymap "n" "<leader>Gd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<cr>" { })
    (keymap "n" "<leader>GD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<cr>" { })
  ];
}
