{ pkgs, utils, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "atone.nvim";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "XXiaoA";
        repo = "atone.nvim";
        rev = "main";
        sha256 = "sha256-+nlupLZqrVhb8emYQwbs6mEy7fMhGCa6pXoYGwFBuKY=";
      };
    })
  ];
  extraConfigLua = /* lua */ "require('atone').setup()";
  keymaps = [ (utils.map "n" "<leader>u" "<cmd>Atone<cr>" { }) ];
}
