{ pkgs, ... }:
{
  extraPlugins = with pkgs; [
    vimPlugins.opencode-nvim
    # (vimUtils.buildVimPlugin {
    #   pname = "opencode-nvim";
    #   version = "latest";
    #   src = fetchFromGitHub {
    #     owner = "NickvanDyke";
    #     repo = "opencode.nvim";
    #     rev = "main";
    #     sha256 = "sha256-U3oF7Vpi6ozsXXe8gYNtWswZLtr+PrUdON0qAsnycmo=";
    #   };
    # })
  ];
  keymaps = [
    {
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<cr>";
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask()<cr>";
      mode = "n";
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask('@selection: ')<cr>";
      mode = "v";
    }
    {
      key = "<leader>oe";
      action = "<cmd>lua require('opencode').select_prompt()<cr>";
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>on";
      action = "<cmd>lua require('opencode').command('session_new')<cr>";
    }
  ];
  extraPackages = with pkgs; [ lsof ];
}
