{ pkgs, ... }:
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
    ./luasnip.nix
    ./neoscroll.nix
    # ./gitblame.nix
    # ./hardtime.nix
    # ./dashboard.nix
    # ./obsidian.nix
    ./ethersync-nvim.nix
    # ./opencode-nvim.nix
    ./gitsigns.nix
    ./neogit.nix
    ./git-worktree.nix
    ./coerce.nix
  ];

  plugins = {
    lualine.enable = true;
    colorizer.enable = true;
    tmux-navigator.enable = true;
    otter.enable = true;
    numbertoggle.enable = true;
    web-devicons.enable = true;
    lastplace.enable = true;
    rainbow-delimiters.enable = true;
    # rustaceanvim.enable = true;
    # "dressing.nvim".enable = true;
    # vimtex.enable = true;
    # gen.enable = true
    # vim-asciidoctor.enable = true;
    # beacon.enable = true;
    # noice.enable =  true;
  };
}
