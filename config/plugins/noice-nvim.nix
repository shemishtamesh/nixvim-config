let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    noice = {
      enable = true;
    };
  };
  keymaps = [
    (keymap [ "n" ] "<leader>n" "<cmd>NoicePick<cr>" { })
    (keymap [ "n" "i" "v" ] "<M-;>" "<cmd>NoiceDismiss<cr>" { })
  ];
}
