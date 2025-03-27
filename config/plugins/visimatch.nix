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
        sha256 = "sha256-nN3bA/px6vYvs2j6xUpcJzvIx1d71kKvJBSp5DuEXhk=";
      };
    })
  ];

  extraConfigLua = # lua
    ''require('visimatch').setup()'';
}
