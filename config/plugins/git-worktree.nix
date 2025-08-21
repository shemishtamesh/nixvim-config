let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    git-worktree = {
      enable = true;
      enableTelescope = true;
    };
  };

  keymaps = [
    (keymap "n" "<leader>w" "<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>" { })
    (keymap "n" "<leader>W"
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>"
      { }
    )
  ];
}
