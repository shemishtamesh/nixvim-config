let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.aerial.enable = true;
  keymaps = [
    (keymap "n" "<leader>O" "<cmd>:AerialToggle<cr>" { silent = true; })
  ];
}
