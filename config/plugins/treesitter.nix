{ pkgs, ... }:
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
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<leader>,";
            node_incremental = "<leader>,";
            scope_incremental = "<leader><";
            node_decremental = "<leader>.";
          };
        };
      };
    };
    treesitter-context = {
      enable = true;
      settings.max_lines = 2;
    };
    treesitter-textobjects = {
      enable = true;
      settings = {
        lookahead = true;
        move = {
          enable = true;
          set_jumps = true;
        };
        select = {
          enable = true;
          lookahead = true;
        };
      };
    };
  };
  extraPackages = with pkgs; [
    gcc
    nodejs
  ];
}
