{ lib, ... }:
{
  plugins = {
    luasnip = {
      enable = true;
      luaConfig.content = ''
        luasnip = require("luasnip")
        fmt = require("luasnip.extras.fmt").fmt

        luasnip.add_snippets("nix", {
          luasnip.snippet(
            "python-devenv",
            fmt(
              [[
                {{ pkgs, ... }}:
                {{
                  languages.python = {{
                    enable = true;
                    venv = {{
                      enable = true;
                      requirements = '''
                        {}
                      ''';
                    }};
                  }};
                  packages = with pkgs; [
                    stdenv.cc.cc
                    libuv
                    zlib
                  ];
                }}
              ]],
              { luasnip.insert_node(0) }
            )
          )
        })
      '';
    };
    cmp = {
      settings = {
        sources = lib.mkBefore [ { name = "luasnip"; } ];
      };
    };
  };
}
