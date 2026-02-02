let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.noice = {
    enable = true;
    settings = {
      cmdline.view = "hover";
      views.hover.border = {
        style = "rounded";
        padding = [
          0
          4
        ];
      };
    };
  };
  keymaps = [
    (keymap [ "n" ] "<leader>n" "<cmd>NoicePick<cr>" { })
    (keymap [ "n" "i" "v" ] "<M-;>" "<cmd>NoiceDismiss<cr>" { })
  ];
}
