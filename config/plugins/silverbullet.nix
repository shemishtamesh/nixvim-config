{ pkgs, utils, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "silverbullet";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "eyko139";
        repo = "silverbullet.nvim";
        rev = "main";
        sha256 = "sha256-4uagubuAZPBZ9CR9htVz4gZc/5I16hA26F9UtsHbqvU=";
      };
    })
  ];
  extraConfigLua = /* lua */ ''
    require("silverbullet").setup({
      default_space = "personal",
      spaces = {
        personal = {
          url = "https://shenixtamesh.local:8443/",
        },
      },
    })
  '';

  keymaps = [
    (utils.map "n" "<leader>nf" "<cmd>SilverBulletFind<cr>" { desc = "Note: find page"; })
    (utils.map "n" "<leader>nn" ''<cmd>lua vim.ui.input({ prompt = "New note: " }, function(name) if name and name ~= "" then vim.cmd("SilverBulletNew " .. name) end end)<cr>''
      { desc = "Note: new page"; })
    (utils.map "n" "<leader>no" ''<cmd>lua vim.ui.input({ prompt = "Open note: " }, function(name) if name and name ~= "" then vim.cmd("SilverBulletOpen " .. name) end end)<cr>''
      { desc = "Note: open page"; })
    (utils.map "n" "<leader>nh" "<cmd>SilverBulletHome<cr>" { desc = "Note: home"; })
    (utils.map "n" "<leader>nl" "<cmd>SilverBulletSearch<cr>" { desc = "Note: search (live grep)"; })
    (utils.map "n" "<leader>nb" "<cmd>SilverBulletBacklinks<cr>" { desc = "Note: backlinks"; })
    (utils.map "n" "<leader>ng" "<cmd>SilverBulletFollowLink<cr>" { desc = "Note: follow link (go to)"; })
    (utils.map "n" "<leader>nw" "<cmd>SilverBulletOpenWeb<cr>" { desc = "Note: open in browser"; })
    (utils.map "n" "<leader>nq" ''<cmd>lua vim.cmd("SilverBulletNew Inbox/" .. os.date("%Y-%m-%d/%H-%M-%S"))<cr>''
      { desc = "Note: quick note"; })
    (utils.map "n" "<leader>nr" "<cmd>SilverBulletReload<cr>" { desc = "Note: reload page"; })
    (utils.map "n" "<leader>nR" "<cmd>SilverBulletReload!<cr>" { desc = "Note: reload page (discard changes)"; })
    (utils.map "n" "<leader>nd" "<cmd>SilverBulletDelete<cr>" { desc = "Note: delete page"; })
  ];
}
