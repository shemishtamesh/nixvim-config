{ lib, ... }:
{
  plugins = {
    luasnip = {
      enable = true;
      luaConfig.content = ''
        local luasnip = require("luasnip")
        local fmt = require("luasnip.extras.fmt").fmt

        luasnip.add_snippets("nix", {
          luasnip.snippet(
            "pr",
            fmt(
              [["https://github.com/NixOS/nixpkgs/archive/pull/{}/head.tar.gz";]],
              { luasnip.insert_node(0) }
            )
          ),

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

        luasnip.add_snippets("python", {
          luasnip.snippet(
            "main",
            fmt(
              "\n\n\n" .. [[
                  def main():
                      {}


                  if __name__ == "__main__":
                      main()
              ]],
              { luasnip.insert_node(0) }
            )
          ),
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
