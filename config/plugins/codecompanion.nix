{ lib, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.codecompanion = {
    enable = true;
    settings = {
      opts.completion_provider = "cmp";
      interactions = lib.genAttrs [ "chat" "inline" "background" "cmd" ] (_: {
        adapter = {
          name = "ollama";
          model = "qwen3-coder";
        };
      });
      display.action_palette.provider = "telescope";
    };
  };
  keymaps = [
    (keymap [ "n" "v" ] "<C-a>" "<cmd>CodeCompanion<cr>" { })
    (keymap [ "n" "v" ] "<leader>A" "<cmd>CodeCompanionActions<cr>" { })
    (keymap "n" "<leader>a" "<cmd>CodeCompanionChat Toggle<cr>" { })
    (keymap "v" "<leader>a" "<cmd>CodeCompanionChat Add<cr>" { })
  ];
}
