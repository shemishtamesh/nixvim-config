{ pkgs, ... }:

{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "visimatch.nvim";
      version = "latest";
      src = fetchFromGitHub {
        owner = "wurli";
        repo = "visimatch.nvim";
        rev = "main";
        sha256 = "sha256-+ye0R8pZxiXJ1UnU3jLajXYI5PHIuADZgjLS8Yj6TeQ=";
      };
    })
  ];

  extraConfigLua = # lua
    ''require('visimatch').setup()'';
}
