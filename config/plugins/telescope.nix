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
    (utils.map "n" "<leader>fo" "<cmd>Telescope oldfiles<cr>" { })
    (utils.map "n" "<leader>ff" ''<cmd>Telescope frecency workspace=CWD path_display={"smart"}<cr>''
      { }
    )
    (utils.map "n" "<leader>fF" "<cmd>Telescope frecency<cr>" { })
    {
      mode = "n";
      key = "<leader>F";
      action.__raw = ''
        ---@diagnostic disable: miss-name
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
    (utils.map "n" "<leader>fl"
      "<cmd>lua require('telescope.builtin').live_grep({additional_args=${rg_args}})<cr>"
      { }
    )
    (utils.map "n" "<leader>fa" "<cmd>Telescope find_files hidden=true<cr>" { })
    (utils.map [ "n" "v" ] "<leader>fs"
      "<cmd>lua require('telescope.builtin').grep_string({additional_args=${rg_args}})<cr>"
      { }
    )
    (utils.map "n" "<leader>fc" "<cmd>Telescope command_history<cr>" { })
    (utils.map "n" "<leader>fq" "<cmd>Telescope quickfix<cr>" { })
    (utils.map "n" "<leader>fj" "<cmd>Telescope jumplist<cr>" { })
    (utils.map "n" "<leader>fk" "<cmd>Telescope keymaps<cr>" { })
    (utils.map "n" "<leader>fh" "<cmd>Telescope help_tags<cr>" { })
    (utils.map "n" "<leader>fm" "<cmd>Telescope man_pages sections=['ALL']<cr>" { })
    (utils.map "n" "<leader>fM" "<cmd>set filetype=man | Telescope man_pages sections=['ALL']<cr>" { })
    (utils.map "n" "<leader>fb" "<cmd>Telescope git_branches<cr>" { })
  ];

  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
