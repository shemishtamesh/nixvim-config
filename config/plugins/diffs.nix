{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "diffs";
      version = "latest";
      src = pkgs.fetchFromGitHub {
        owner = "barrettruth";
        repo = "diffs.nvim";
        rev = "main";
        sha256 = "sha256-gCMg7oyoa+k0p0YDWElXCdY8bGZ/TEp0V4JXnQd27og=";
      };
    })
  ];
  extraConfigLua = /* lua */ ''
    vim.g.diffs = {
      integrations = {
        neogit = true,
        gitsigns = true,
      }
    }
  '';
}
