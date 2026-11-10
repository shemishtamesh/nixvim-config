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
        sha256 = "sha256-I1ID4uzMu2PAapAg+4RNcQLFUXzi3GUP2PhZOc6c8fU=";
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
