let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    neogit = {
      enable = true;
      settings = {
        integrations.telescope = true;
        console_timeout = 0;
        graph_style = "unicode";
      };
    };
  };

  keymaps = [
    (keymap "n" "<leader>gs" "<cmd>Neogit<cr>" { })
    (keymap "n" "<leader>gl" "<cmd>Neogit log<cr>" { })
    (keymap "n" "<leader>gc" "<cmd>Neogit commit<cr>" { })
    (keymap "n" "<leader>gw" "<cmd>Neogit worktree<cr>" { })
    (keymap "n" "<leader>gb" "<cmd>Neogit branch<cr>" { })
    (keymap "n" "<leader>gm" "<cmd>Neogit merge<cr>" { })
    (keymap "n" "<leader>gr" "<cmd>Neogit remote<cr>" { })
    (keymap "n" "<leader>gf" "<cmd>Neogit fetch<cr>" { })
    (keymap "n" "<leader>gp" "<cmd>Neogit pull<cr>" { })
    (keymap "n" "<leader>gP" "<cmd>Neogit push<cr>" { })
    (keymap "n" "<leader>gS" "<cmd>Neogit stash<cr>" { })
    (keymap "n" "<leader>gL" "<cmd>NeogitLog<cr>" { })
    (keymap "n" "<leader>gC" "<cmd>NeogitCommit<cr>" { })
  ];
}
