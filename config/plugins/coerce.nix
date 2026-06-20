{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "coerce.nvim";
      version = "latest";
      src = fetchFromGitHub {
        owner = "gregorias";
        repo = "coerce.nvim";
        rev = "main";
        sha256 = "sha256-U8+jNFqYHKDadr+WO1GjIc0FYcyajvRubc+15949BLg=";
      };
    })
    (vimUtils.buildVimPlugin {
      pname = "coop";
      version = "latest";
      src = fetchFromGitHub {
        owner = "gregorias";
        repo = "coop.nvim";
        rev = "main";
        sha256 = "sha256-S6iGmdakI714Im0tetgfASbe0K4/olYsjj26+WP+rSU=";
      };
    })
  ];

  extraConfigLua = ''
    require"coerce".setup{
      default_mode_keymap_prefixes = {
        normal_mode = "<leader>c",
        motion_mode = "<leader>C",
        visual_mode = "<leader>c"
      },
    }
  '';
}
