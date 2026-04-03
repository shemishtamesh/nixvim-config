{utils, ...}:
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
    (utils.map "n" "[G" "<cmd>Gitsigns nav_hunk first<cr>" { })
    (utils.map "n" "[g" "<cmd>Gitsigns nav_hunk prev<cr>" { })
    (utils.map "n" "]g" "<cmd>Gitsigns nav_hunk next<cr>" { })
    (utils.map "n" "]G" "<cmd>Gitsigns nav_hunk last<cr>" { })

    (utils.map "n" "<leader>Gv" "<cmd>Gitsigns preview_hunk<cr>" { })
    (utils.map "n" "<leader>GV" "<cmd>Gitsigns preview_hunk_inline<cr>" { })

    (utils.map "n" "<leader>Gs" "<cmd>Gitsigns select_hunk<cr>" { })

    (utils.map "n" "<leader>GR" "<cmd>Gitsigns reset_buffer<cr>" { })
    (utils.map "n" "<leader>Gr" "<cmd>Gitsigns reset_hunk<cr>" { })
    (utils.map "n" "<leader>Ga" "<cmd>Gitsigns stage_hunk<cr>" { })
    (utils.map "n" "<leader>GA" "<cmd>Gitsigns stage_buffer<cr>" { })

    (utils.map "n" "<leader>Gw" "<cmd>Gitsigns toggle_word_diff<cr>" { })

    (utils.map "n" "<leader>Gb" "<cmd>Gitsigns blame_line<cr>" { })
    (utils.map "n" "<leader>GB" "<cmd>Gitsigns blame<cr>" { })
    (utils.map "n" "<leader>Gl" "<cmd>Gitsigns toggle_current_line_blame<cr>" { })

    (utils.map "n" "<leader>Gq" "<cmd>Gitsigns setqflist<cr>" { })

    (utils.map "n" "<leader>Gd" "<cmd>Gitsigns diffthis vertical=true split=rightbelow<cr>" { })
    (utils.map "n" "<leader>GD" "<cmd>Gitsigns diffthis ~1 vertical=true split=rightbelow<cr>" { })
  ];
}
