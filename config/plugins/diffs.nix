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
        sha256 = "sha256-y6j1x57VoQuOja/60AmO8tWfkVUjMx+khXPGvSUAuVU=";
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
