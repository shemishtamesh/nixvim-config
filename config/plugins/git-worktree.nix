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

  extraConfigLua = ''
    local Hooks = require("git-worktree.hooks")
    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function (path, prev_path)
      update_on_switch(path, prev_path)
      vim.cmd('clearjumps')
    end)
  '';

  keymaps = [
    (keymap "n" "<leader>w" "<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<CR>"
      { }
    )
    (keymap "n" "<leader>W"
      "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>"
      { }
    )
  ];
}
