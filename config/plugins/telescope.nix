{ pkgs, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.telescope = {
    enable = true;
    extensions.frecency.enable = true;
  };
  keymaps = [
    (keymap "n" "<leader>fo" "<cmd>Telescope oldfiles<CR>" { })
    (keymap "n" "<leader>ff" ''<cmd>Telescope frecency workspace=CWD path_display={"smart"}<CR>'' { })
    (keymap "n" "<leader>fF" "<cmd>Telescope frecency<CR>" { })
    (keymap "n" "<leader>F" "<cmd>Telescope git_files show_untracked=true<CR>" { })
    (keymap "n" "<leader>fl" "<cmd>Telescope live_grep<CR>" { })
    (keymap "n" "<leader>fa" "<cmd>Telescope find_files hidden=true<CR>" { })
    (keymap "n" "<leader>fs" "<cmd>Telescope grep_string<CR>" { })
    (keymap "n" "<leader>fc" "<cmd>Telescope command_history<CR>" { })
    (keymap "n" "<leader>fq" "<cmd>Telescope quickfix<CR>" { })
    (keymap "n" "<leader>fj" "<cmd>Telescope jumplist<CR>" { })
    (keymap "n" "<leader>fk" "<cmd>Telescope keymaps<CR>" { })
  ];

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
