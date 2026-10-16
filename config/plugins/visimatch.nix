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
        sha256 = "sha256-ptUZy3tIBD5FG7B2stHPk6OAxj3+q8NLKDepZl75gvg=";
      };
    })
  ];

  extraConfigLua = # lua
    "require('visimatch').setup()";
}
