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
    (keymap "n" "<leader>gs" "<cmd>Neogit<CR>" { silent = true; })
    (keymap "n" "<leader>gl" "<cmd>Neogit log<CR>" { silent = true; })
    (keymap "n" "<leader>gc" "<cmd>Neogit commit<CR>" { silent = true; })
    (keymap "n" "<leader>gw" "<cmd>Neogit worktree<CR>" { silent = true; })
    (keymap "n" "<leader>gb" "<cmd>Neogit branch<CR>" { silent = true; })
    (keymap "n" "<leader>gm" "<cmd>Neogit merge<CR>" { silent = true; })
    (keymap "n" "<leader>gr" "<cmd>Neogit remote<CR>" { silent = true; })
    (keymap "n" "<leader>gf" "<cmd>Neogit fetch<CR>" { silent = true; })
    (keymap "n" "<leader>gp" "<cmd>Neogit pull<CR>" { silent = true; })
    (keymap "n" "<leader>gP" "<cmd>Neogit push<CR>" { silent = true; })
    (keymap "n" "<leader>gS" "<cmd>Neogit stash<CR>" { silent = true; })
    (keymap "n" "<leader>gL" "<cmd>NeogitLog<CR>" { silent = true; })
    (keymap "n" "<leader>gC" "<cmd>NeogitCommit<CR>" { silent = true; })
  ];
}
