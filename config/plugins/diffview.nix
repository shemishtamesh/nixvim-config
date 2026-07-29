{ utils, ... }:
{
  plugins.diffview.enable = true;

  keymaps = [
    (utils.map "n" "<leader>vo" "<cmd>DiffviewOpen<cr>" { desc = "Diffview open"; })
    (utils.map "n" "<leader>vc" "<cmd>DiffviewClose<cr>" { desc = "Diffview close"; })
    (utils.map "n" "<leader>vr" "<cmd>DiffviewRefresh<cr>" { desc = "Diffview refresh"; })
    (utils.map "n" "<leader>vf" "<cmd>DiffviewToggleFiles<cr>" { desc = "Diffview toggle file panel"; })
    (utils.map "n" "<leader>vh" "<cmd>DiffviewFileHistory %<cr>" { desc = "Diffview file history (current file)"; })
    (utils.map "n" "<leader>vH" "<cmd>DiffviewFileHistory<cr>" { desc = "Diffview file history (repo)"; })
    (utils.map "ca" "DV" "DiffviewOpen" { })
  ];
}
