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

    local function get_common_worktree_dir()
      local handle =
        io.popen("git rev-parse --path-format=absolute --git-common-dir | sed 's|\\(.*\\)/\\.git|\\1|'")
      if handle ~= nil then
        local result = handle:read("*a")
        handle:close()
        return vim.trim(result)
      end
      return nil
    end

    vim.keymap.set("n", "<leader>W", function()
      local common_worktree_dir = get_common_worktree_dir()
      require('telescope').extensions.git_worktree.create_git_worktree({ prefix = common_worktree_dir .. "/" })
    end, { desc = "[G]it [W]orktree [C]reate" })
  '';

  keymaps = [
    (keymap "n" "<leader>w" "<cmd>lua require('telescope').extensions.git_worktree.git_worktree()<cr>"
      { }
    )
  ];
}
