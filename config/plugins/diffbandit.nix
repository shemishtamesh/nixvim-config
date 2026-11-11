{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "diffbandit.nvim";
      version = "0-unstable-1897aea";
      src = pkgs.fetchFromGitHub {
        owner = "CoreyKaylor";
        repo = "diffbandit.nvim";
        rev = "1897aea7a970b49f0687617a16bcea1f53290fbc";
        hash = "sha256-2uDbK/Mg4HcK795aEOYEpt6mhv3GqCVB3yk6Alz3y3I=";
      };
    })
  ];

  extraConfigLua = /* lua */ ''
    require('diffbandit').setup()
  '';
}
