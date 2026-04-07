{
  plugins.zen-mode = {
    enable = true;
    settings = {
      window = {
        backdrop = 0;
        width = 80;
        height = 1;
        options = {
          signcolumn = "no";
          colorcolumn = "0";
          number = false;
          relativenumber = false;
          foldcolumn = "0";
          list = false;
        };
      };
      plugins = {
        options = {
          enabled = true;
          ruler = false;
          showcmd = false;
          laststatus = 0;
        };
        tmux.enabled = true;
        kitty = {
          enabled = true;
          font = "+8";
        };
        wezterm = {
          enabled = true;
          font = "+8";
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>z";
      action.__raw = ''
        ---@diagnostic disable: miss-name
        function()
          require("zen-mode").toggle()
          vim.cmd('IBLToggle');
          vim.diagnostic.enable(not vim.diagnostic.is_enabled());
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
        end
      '';
      options = {
        silent = true;
      };
    }
  ];
}
