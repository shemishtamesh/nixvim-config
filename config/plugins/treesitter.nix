{
  pkgs,
  lib,
  utils,
  ...
}:
{
  plugins = {
    treesitter = {
      enable = true;
      folding.enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        indent.enable = true;
        auto_install = true;
        parser_install_dir = (
          if pkgs.stdenv.isDarwin then
            "$HOME/.local/share/nvim/treesitter"
          else
            "$XDG_DATA_HOME/nvim/treesitter"
        );
      };
    };
    treesitter-context = {
      enable = false;
      settings.max_lines = 2;
    };
    treesitter-textobjects = {
      enable = true;
      settings = {
        lookahead = true;
        select = {
          enable = true;
          lookahead = true;
        };
      };
    };
  };
  keymaps =
    let
      textobjects = {
        f = {
          query = "@function";
          queryGroup = "textobjects";
        };
        c = {
          query = "@class";
          queryGroup = "textobjects";
        };
        o = {
          query = "@loop";
          queryGroup = "locals";
        };
        i = {
          query = "@conditional";
          queryGroup = "locals";
        };
        k = {
          query = "@block";
          queryGroup = "locals";
        };
        s = {
          query = "@scope";
          queryGroup = "locals";
        };
        "=" = {
          query = "@assignment";
          queryGroup = "locals";
        };
        r = {
          query = "@parameter";
          queryGroup = "textobjects";
        };
        u = {
          query = "@call";
          queryGroup = "textobjects";
        };
      };
      objKeys = lib.attrNames textobjects;
      modes = [
        "n"
        "x"
        "o"
      ];
      # Objects that don't have end keymaps (only start)
      startOnly = [
        "="
        "r"
        "u"
      ];

      selectKeymaps = lib.concatLists (
        map (
          obj:
          let
            o = textobjects.${obj};
            require = ''require("nvim-treesitter-textobjects.select")'';
          in
          [
            (utils.map [ "o" "x" ] "a${obj}"
              ''<cmd>lua ${require}.select_textobject("${o.query}.outer", "textobjects")<cr>''
              { desc = "Select outer part of a ${o.query}"; }
            )
            (utils.map [ "o" "x" ] "i${obj}"
              ''<cmd>lua ${require}.select_textobject("${o.query}.inner", "textobjects")<cr>''
              { desc = "Select inner part of a ${o.query}"; }
            )
          ]
        ) objKeys
      );

      moveKeymaps = lib.concatLists (
        lib.concatMap (
          obj:
          let
            o = textobjects.${obj};
            require = ''require("nvim-treesitter-textobjects.move")'';
          in
          [
            (lib.concatMap (mode: [
              (utils.map mode "]${obj}"
                ''<cmd>lua ${require}.goto_next_start("${o.query}.outer", "${o.queryGroup}")<cr>''
                { desc = "Go to the start of the next ${o.query}"; }
              )
              (utils.map mode "[${obj}"
                ''<cmd>lua ${require}.goto_previous_start("${o.query}.outer", "${o.queryGroup}")<cr>''
                { desc = "Go to the start of the previous ${o.query}"; }
              )
            ]) modes)
          ]
          ++ lib.optionals (!lib.elem obj startOnly) [
            (lib.concatMap (mode: [
              (utils.map mode "]${lib.toUpper obj}"
                ''<cmd>lua ${require}.goto_next_end("${o.query}.outer", "${o.queryGroup}")<cr>''
                { desc = "Go to the end of the next ${o.query}"; }
              )
              (utils.map mode "[${lib.toUpper obj}"
                ''<cmd>lua ${require}.goto_previous_end("${o.query}.outer", "${o.queryGroup}")<cr>''
                { desc = "Go to the end of the previous ${o.query}"; }
              )
            ]) modes)
          ]
        ) objKeys
      );

      swapKeymaps = lib.concatMap (
        obj:
        let
          o = textobjects.${obj};
          require = ''require("nvim-treesitter-textobjects.swap")'';
        in
        [
          (utils.map "n" "<leader>r${obj}" ''<cmd>lua ${require}.swap_next("${o.query}.inner")<cr>'' {
            desc = "Swap with next ${o.query}";
          })
          (utils.map "n" "<leader>r${lib.toUpper obj}"
            ''<cmd>lua ${require}.swap_next("${o.query}.outer")<cr>''
            {
              desc = "Swap with next ${o.query} (outer)";
            }
          )
          (utils.map "n" "<leader>R${obj}" ''<cmd>lua ${require}.swap_previous("${o.query}.inner")<cr>'' {
            desc = "Swap with previous ${o.query}";
          })
          (utils.map "n" "<leader>R${lib.toUpper obj}"
            ''<cmd>lua ${require}.swap_previous("${o.query}.outer")<cr>''
            { desc = "Swap with previous ${o.query} (outer)"; }
          )
        ]
      ) objKeys;
    in
    selectKeymaps ++ moveKeymaps ++ swapKeymaps;
  extraPackages = with pkgs; [
    gcc
    nodejs
  ];
}
