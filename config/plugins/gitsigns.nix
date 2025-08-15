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

    (keymap "n" "<leader>gv" "<cmd>Gitsigns preview_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>gV" "<cmd>Gitsigns preview_hunk_inline<CR>" { silent = true; })

    (keymap "n" "<leader>gs" "<cmd>Gitsigns select_hunk<CR>" { silent = true; })

    (keymap "n" "<leader>gR" "<cmd>Gitsigns reset_buffer<CR>" { silent = true; })
    (keymap "n" "<leader>gr" "<cmd>Gitsigns reset_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>ga" "<cmd>Gitsigns stage_hunk<CR>" { silent = true; })
    (keymap "n" "<leader>gA" "<cmd>Gitsigns stage_buffer<CR>" { silent = true; })

    (keymap "n" "<leader>gw" "<cmd>Gitsigns toggle_word_diff<CR>" { silent = true; })

    (keymap "n" "<leader>gb" "<cmd>Gitsigns blame_line<CR>" { silent = true; })
    (keymap "n" "<leader>gB" "<cmd>Gitsigns blame<CR>" { silent = true; })
    (keymap "n" "<leader>gl" "<cmd>Gitsigns toggle_current_line_blame<CR>" { silent = true; })

    (keymap "n" "<leader>gq" "<cmd>Gitsigns setqflist<CR>" { silent = true; })

    (keymap "n" "<leader>gd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>gD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<CR>" {
      silent = true;
    })
  ];
}
