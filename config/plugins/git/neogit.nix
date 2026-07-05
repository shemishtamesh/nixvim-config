{ utils, ... }:
{
  plugins = {
    neogit = {
      enable = true;
      settings = {
        integrations.telescope = true;
        graph_style = "unicode";
      };
    };
  };

  keymaps = [
    (utils.map "n" "<leader>gs" "<cmd>Neogit<cr>" { desc = "Neogit status"; })
    (utils.map "n" "<leader>gl" "<cmd>Neogit log<cr>" { desc = "Neogit log"; })
    (utils.map "n" "<leader>gc" "<cmd>Neogit commit<cr>" { desc = "Neogit commit"; })
    (utils.map "n" "<leader>gw" "<cmd>Neogit worktree<cr>" { desc = "Neogit worktree"; })
    (utils.map "n" "<leader>gb" "<cmd>Neogit branch<cr>" { desc = "Neogit branch"; })
    (utils.map "n" "<leader>gm" "<cmd>Neogit merge<cr>" { desc = "Neogit merge"; })
    (utils.map "n" "<leader>gr" "<cmd>Neogit remote<cr>" { desc = "Neogit remote"; })
    (utils.map "n" "<leader>gf" "<cmd>Neogit fetch<cr>" { desc = "Neogit fetch"; })
    (utils.map "n" "<leader>gp" "<cmd>Neogit pull<cr>" { desc = "Neogit pull"; })
    (utils.map "n" "<leader>gP" "<cmd>Neogit push<cr>" { desc = "Neogit push"; })
    (utils.map "n" "<leader>gS" "<cmd>Neogit stash<cr>" { desc = "Neogit stash"; })
    (utils.map "n" "<leader>gL" "<cmd>NeogitLog<cr>" { desc = "Neogit log (current branch)"; })
    (utils.map "n" "<leader>gC" "<cmd>NeogitCommit<cr>" { desc = "Neogit commit (popup)"; })
  ];
}
