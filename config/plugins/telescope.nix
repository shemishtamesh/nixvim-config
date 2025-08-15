{ pkgs, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
  rg_args = "{'--hidden', '--glob', '!**/.git/**', '--glob', '!**/*.lock'}";
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
    {
      mode = "n";
      key = "<leader>F";
      action.__raw = ''
        function()
          local _ = vim.fn.system("git rev-parse --is-inside-work-tree")
          if vim.v.shell_error == 0 then
            require('telescope.builtin').git_files({show_untracked=true})
          else
            require('telescope.builtin').find_files()
          end
        end
      '';
      options = { };
    }
    (keymap "n" "<leader>fl"
      "<cmd>lua require('telescope.builtin').live_grep({additional_args=${rg_args}})<CR>"
      { }
    )
    (keymap "n" "<leader>fa" "<cmd>Telescope find_files hidden=true<CR>" { })
    (keymap [ "n" "v" ] "<leader>fs"
      "<cmd>lua require('telescope.builtin').grep_string({additional_args=${rg_args}})<CR>"
      { }
    )
    (keymap "n" "<leader>fc" "<cmd>Telescope command_history<CR>" { })
    (keymap "n" "<leader>fq" "<cmd>Telescope quickfix<CR>" { })
    (keymap "n" "<leader>fj" "<cmd>Telescope jumplist<CR>" { })
    (keymap "n" "<leader>fk" "<cmd>Telescope keymaps<CR>" { })
    (keymap "n" "<leader>fh" "<cmd>Telescope help_tags<CR>" { })
    (keymap "n" "<leader>fm" "<cmd>Telescope man_pages sections=['ALL']<CR>" { })
    (keymap "n" "<leader>fM" "<cmd>set filetype=man | Telescope man_pages sections=['ALL']<CR>" { })
    (keymap "n" "<leader>fb" "<cmd>Telescope git_branches<CR>" { })
  ];

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
