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
    (keymap "n" "<leader>gs" "<cmd>Neogit<CR>" { })
    (keymap "n" "<leader>gl" "<cmd>Neogit log<CR>" { })
    (keymap "n" "<leader>gc" "<cmd>Neogit commit<CR>" { })
    (keymap "n" "<leader>gw" "<cmd>Neogit worktree<CR>" { })
    (keymap "n" "<leader>gb" "<cmd>Neogit branch<CR>" { })
    (keymap "n" "<leader>gm" "<cmd>Neogit merge<CR>" { })
    (keymap "n" "<leader>gr" "<cmd>Neogit remote<CR>" { })
    (keymap "n" "<leader>gf" "<cmd>Neogit fetch<CR>" { })
    (keymap "n" "<leader>gp" "<cmd>Neogit pull<CR>" { })
    (keymap "n" "<leader>gP" "<cmd>Neogit push<CR>" { })
    (keymap "n" "<leader>gS" "<cmd>Neogit stash<CR>" { })
    (keymap "n" "<leader>gL" "<cmd>NeogitLog<CR>" { })
    (keymap "n" "<leader>gC" "<cmd>NeogitCommit<CR>" { })
  ];
}
