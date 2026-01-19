{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.opencode-nvim
  ];
  keymaps = [
    {
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<cr>";
    }
    {
      key = "<leader>oa";
      action = ''<cmd>lua require('opencode').ask("@this: ", { submit = true })<cr>'';
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>os";
      action = "<cmd>lua require('opencode').select()<cr>";
      mode = [
        "n"
        "v"
      ];
    }
  ];
  extraPackages = with pkgs; [ lsof ];
}
