{ utils, ... }:
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
    (utils.map "n" "[G" "<cmd>Gitsigns nav_hunk first<cr>" { desc = "First hunk"; })
    (utils.map "n" "[g" "<cmd>Gitsigns nav_hunk prev<cr>" { desc = "Previous hunk"; })
    (utils.map "n" "]g" "<cmd>Gitsigns nav_hunk next<cr>" { desc = "Next hunk"; })
    (utils.map "n" "]G" "<cmd>Gitsigns nav_hunk last<cr>" { desc = "Last hunk"; })

    (utils.map "n" "<leader>Gv" "<cmd>Gitsigns preview_hunk<cr>" { desc = "Preview hunk"; })
    (utils.map "n" "<leader>GV" "<cmd>Gitsigns preview_hunk_inline<cr>" { desc = "Preview hunk (inline)"; })

    (utils.map "n" "<leader>Gs" "<cmd>Gitsigns select_hunk<cr>" { desc = "Select hunk"; })

    (utils.map "n" "<leader>GR" "<cmd>Gitsigns reset_buffer<cr>" { desc = "Reset buffer"; })
    (utils.map "n" "<leader>Gr" "<cmd>Gitsigns reset_hunk<cr>" { desc = "Reset hunk"; })
    (utils.map "n" "<leader>Ga" "<cmd>Gitsigns stage_hunk<cr>" { desc = "Stage hunk"; })
    (utils.map "n" "<leader>GA" "<cmd>Gitsigns stage_buffer<cr>" { desc = "Stage buffer"; })

    (utils.map "n" "<leader>Gw" "<cmd>Gitsigns toggle_word_diff<cr>" { desc = "Toggle word diff"; })

    (utils.map "n" "<leader>Gb" "<cmd>Gitsigns blame_line<cr>" { desc = "Blame line"; })
    (utils.map "n" "<leader>GB" "<cmd>Gitsigns blame<cr>" { desc = "Blame file"; })
    (utils.map "n" "<leader>Gl" "<cmd>Gitsigns toggle_current_line_blame<cr>" { desc = "Toggle line blame"; })

    (utils.map "n" "<leader>Gq" "<cmd>Gitsigns setqflist<cr>" { desc = "Add hunks to quickfix"; })

    (utils.map "n" "<leader>Gd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<cr>" { desc = "Diff working tree"; })
    (utils.map "n" "<leader>GD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<cr>" { desc = "Diff against HEAD~1"; })
  ];
}
