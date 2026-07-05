{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.opencode-nvim
  ];
  plugins.opencode-nvim = {
    enable = true;
    setup = {
      user_commands = {
        "OpenCode" = "toggle";
      };
    };
  };
  keymaps = [
    {
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<cr>";
      options = { desc = "Toggle OpenCode"; };
    }
    {
      key = "<leader>oa";
      action = ''<cmd>lua require('opencode').ask("@this: ", { submit = true })<cr>'';
      mode = [
        "n"
        "v"
      ];
      options = { desc = "Ask OpenCode about selection"; };
    }
    {
      key = "<leader>os";
      action = "<cmd>lua require('opencode').select()<cr>";
      mode = [
        "n"
        "v"
      ];
      options = { desc = "Select OpenCode agent"; };
    }
  ];
  extraPackages = with pkgs; [ lsof ];
}
