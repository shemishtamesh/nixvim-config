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
        sha256 = "sha256-1wHS8/5gvEVdXEQj9WMMT46qVjPPGv6H6lZugKU8BCU=";
      };
    })
  ];

  extraConfigLua = # lua
    ''require('visimatch').setup()'';
}
