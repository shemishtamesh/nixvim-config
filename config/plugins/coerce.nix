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
        sha256 = "sha256-RTE2THMwNPAgKmZt8j5TYqNVBJ5ZM+BCl0EX7fNjlIk=";
      };
    })
    (vimUtils.buildVimPlugin {
      pname = "coop";
      version = "latest";
      src = fetchFromGitHub {
        owner = "gregorias";
        repo = "coop.nvim";
        rev = "main";
        sha256 = "sha256-d3W9/WLCDTU2qP7yuerk8u7thsYutpnZNauIEIMM3i8=";
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
