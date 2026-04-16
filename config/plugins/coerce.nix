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
        sha256 = "sha256-kToIauAfK87qP8aa8an7lxd1ugyYwjah4uSgbOL6Jp4=";
      };
    })
    (vimUtils.buildVimPlugin {
      pname = "coop";
      version = "latest";
      src = fetchFromGitHub {
        owner = "gregorias";
        repo = "coop.nvim";
        rev = "main";
        sha256 = "sha256-7brkTkeT8OjG5EWGMR+eJCzf9ynXRHNLHFdprqN2DDk=";
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
