{ lib, ... }:

{
  plugins = {
    codeium-nvim = {
      enable = true;
      settings.enable_chat = true;
    };
    cmp = {
      settings = {
        sources = lib.mkBefore [ { name = "codeium"; } ];
      };
    };
  };
}
