let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    neogit = {
      enable = true;
      settings = {
        integrations = {
          diffview = true;
          telescope = true;
        };
        console_timeout = 0;
        graph_style = "unicode";
      };
    };
    diffview.enable = true;
  };

  keymaps = [
    (keymap "n" "<leader>GS" "<cmd>Neogit<CR>" { silent = true; })
    (keymap "n" "<leader>GL" "<cmd>NeogitLog<CR>" { silent = true; })
    (keymap "n" "<leader>GC" "<cmd>NeogitCommit<CR>" { silent = true; })
  ];
}
