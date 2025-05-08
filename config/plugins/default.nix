{
  imports = [
    ./lsp.nix
    ./completions.nix
    ./telescope.nix
    ./undotree.nix
    ./treesitter.nix
    ./comment.nix
    # ./codeium.nix
    ./minuet.nix
    ./zen-mode.nix
    ./indent-blankline.nix
    ./which-key.nix
    ./snacks.nix
    ./dadbod.nix
    ./nvim-dap.nix
    ./flash.nix
    ./nvim-surround.nix
    ./render-markdown.nix
    ./visimatch.nix
    ./jupytext.nix
    ./hardtime.nix
    # ./dashboard.nix
    # ./obsidian.nix
  ];

  plugins = {
    lualine.enable = true;
    colorizer.enable = true;
    tmux-navigator.enable = true;
    otter.enable = true;
    numbertoggle.enable = true;
    gitsigns.enable = true;
    web-devicons.enable = true;
    lastplace.enable = true;
    # rustaceanvim.enable = true;
    # "dressing.nvim".enable = true;
    # vimtex.enable = true;
    # gen.enable = true
    # vim-asciidoctor.enable = true;
    # beacon.enable = true;
    # noice.enable =  true;
  };
  # extraPlugins = with pkgs; [
  #   (vimUtils.buildVimPlugin {
  #     pname = "cheat.sh-vim";
  #     version = "latest";
  #     src = fetchFromGitHub {
  #       owner = "dbeniamine";
  #       repo = "cheat.sh-vim";
  #       rev = "master";
  #       sha256 = "sha256-awowfQ4q9CCX2V7Vhf1EjKr2GaqQFPOpdwq7FT8os0Y=";
  #     };
  #   })
  # ];
}
