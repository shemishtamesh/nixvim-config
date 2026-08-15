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
        sha256 = "sha256-v7DRUpD0IGCD1g9CKfIA1AL/BKU4DEFWZ9zmzN42yY4=";
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
