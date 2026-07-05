{ utils, ... }:
{
  plugins.octo = {
    enable = true;
    settings = {
      picker = "telescope";
      enable_builtin = true;
    };
  };

  keymaps = [
    (utils.map "n" "<leader>ghi" "<cmd>Octo issue list<cr>" { desc = "List GitHub Issues"; })
    (utils.map "n" "<leader>ghI" "<cmd>Octo issue search<cr>" { desc = "Search Issues"; })
    (utils.map "n" "<leader>ghc" "<cmd>Octo issue create<cr>" { desc = "Create Issue"; })

    (utils.map "n" "<leader>ghp" "<cmd>Octo pr list<cr>" { desc = "List Pull Requests"; })
    (utils.map "n" "<leader>ghP" "<cmd>Octo pr search<cr>" { desc = "Search Pull Requests"; })
    (utils.map "n" "<leader>ghC" "<cmd>Octo pr create<cr>" { desc = "Create Pull Request"; })

    (utils.map "n" "<leader>ghd" "<cmd>Octo discussion list<cr>" { desc = "List Discussions"; })
    (utils.map "n" "<leader>ghn" "<cmd>Octo notification list<cr>" { desc = "List Notifications"; })
    (utils.map "n" "<leader>ghs" "<cmd>Octo search<cr>" { desc = "Search GitHub"; })
    (utils.map "n" "<leader>ghr" "<cmd>Octo repo list<cr>" { desc = "List Repos"; })
  ];
}
