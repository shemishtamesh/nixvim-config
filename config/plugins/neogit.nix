{utils, ...}:
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
    (utils.map "n" "<leader>gs" "<cmd>Neogit<cr>" { })
    (utils.map "n" "<leader>gl" "<cmd>Neogit log<cr>" { })
    (utils.map "n" "<leader>gc" "<cmd>Neogit commit<cr>" { })
    (utils.map "n" "<leader>gw" "<cmd>Neogit worktree<cr>" { })
    (utils.map "n" "<leader>gb" "<cmd>Neogit branch<cr>" { })
    (utils.map "n" "<leader>gm" "<cmd>Neogit merge<cr>" { })
    (utils.map "n" "<leader>gr" "<cmd>Neogit remote<cr>" { })
    (utils.map "n" "<leader>gf" "<cmd>Neogit fetch<cr>" { })
    (utils.map "n" "<leader>gp" "<cmd>Neogit pull<cr>" { })
    (utils.map "n" "<leader>gP" "<cmd>Neogit push<cr>" { })
    (utils.map "n" "<leader>gS" "<cmd>Neogit stash<cr>" { })
    (utils.map "n" "<leader>gL" "<cmd>NeogitLog<cr>" { })
    (utils.map "n" "<leader>gC" "<cmd>NeogitCommit<cr>" { })
  ];
}
