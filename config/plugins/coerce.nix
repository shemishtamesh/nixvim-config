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
        sha256 = "sha256-phUwUOwo6TFoOjpqtix1cfbNu1JtYdcwygGOE+tYxLo=";
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
