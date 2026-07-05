{ pkgs, utils, ... }:
let
  rg_args = "{'--hidden', '--glob', '!**/.git/**', '--glob', '!**/*.lock'}";
in
{
  plugins.telescope = {
    enable = true;
    extensions = {
      frecency = {
        enable = true;
        settings.auto_validate = true;
      };
      ui-select.enable = true;
    };
    settings.defaults.layout_config.horizontal.width = 0.9;
  };
  keymaps = [
    (utils.map "n" "<leader>fo" "<cmd>Telescope oldfiles<cr>" { desc = "Find recent files"; })
    (utils.map "n" "<leader>ff" ''<cmd>Telescope frecency workspace=CWD path_display={"smart"}<cr>''
      { desc = "Find frecent files"; }
    )
    (utils.map "n" "<leader>fF" "<cmd>Telescope frecency<cr>" { desc = "Find frecent files (global)"; })
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
      options = { desc = "Find Git Files (or Find Files)"; };
    }
    (utils.map "n" "<leader>fl"
      "<cmd>lua require('telescope.builtin').live_grep({additional_args=${rg_args}})<cr>"
      { desc = "Live grep"; }
    )
    (utils.map "n" "<leader>fa" "<cmd>Telescope find_files hidden=true<cr>" { desc = "Find all files (hidden)"; })
    (utils.map [ "n" "v" ] "<leader>fs"
      "<cmd>lua require('telescope.builtin').grep_string({additional_args=${rg_args}})<cr>"
      { desc = "Grep word under cursor"; }
    )
    (utils.map "n" "<leader>fc" "<cmd>Telescope command_history<cr>" { desc = "Command history"; })
    (utils.map "n" "<leader>fq" "<cmd>Telescope quickfix<cr>" { desc = "Quickfix list"; })
    (utils.map "n" "<leader>fj" "<cmd>Telescope jumplist<cr>" { desc = "Jump list"; })
    (utils.map "n" "<leader>fk" "<cmd>Telescope keymaps<cr>" { desc = "Keymaps"; })
    (utils.map "n" "<leader>fh" "<cmd>Telescope help_tags<cr>" { desc = "Help tags"; })
    (utils.map "n" "<leader>fm" "<cmd>Telescope man_pages sections=['ALL']<cr>" { desc = "Man pages"; })
    (utils.map "n" "<leader>fM" "<cmd>set filetype=man | Telescope man_pages sections=['ALL']<cr>" { desc = "Man pages (force)"; })
    (utils.map "n" "<leader>fb" "<cmd>Telescope git_branches<cr>" { desc = "Git branches"; })
  ];

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
