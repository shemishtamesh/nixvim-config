{
  imports = [
    ./completions.nix
    ./telescope.nix
    ./undotree.nix
    ./treesitter.nix
    ./comment.nix
    ./minuet.nix
    ./zen-mode.nix
    ./indent-blankline.nix
    ./which-key.nix
    ./snacks.nix
    ./dadbod.nix
    ./nvim-dap.nix
    ./flash.nix
    ./render-markdown.nix
    ./nvim-surround.nix
    ./visimatch.nix
    ./jupytext.nix
    ./luasnip.nix
    ./codecompanion.nix
    ./gitsigns.nix
    ./neogit.nix
    ./git-worktree.nix
    ./coerce.nix
    ./tmux.nix
    ./lualine.nix
    ./noice-nvim.nix
    ./oil.nix
    ./navic.nix
    ./otter.nix
    ./aerial.nix
  ];

  plugins = {
    colorizer.enable = true;
    numbertoggle.enable = true;
    web-devicons.enable = true;
    lastplace.enable = true;
    rainbow-delimiters.enable = true;
    quicker.enable = true;
    smear-cursor.enable = true;
    teamtype.enable = true;
  };
}
