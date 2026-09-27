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
        sha256 = "sha256-kdY8XiTzknG+rhr2hprK0BJC06iKuEm7QLWsNqxant8=";
      };
    })
  ];

  extraConfigLua = # lua
    "require('visimatch').setup()";
}
