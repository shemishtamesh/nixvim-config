{
  plugins.navic = {
    enable = true;
    settings.lsp.auto_attach = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>o";
      action.__raw = ''
        ---@diagnostic disable: miss-name
        function()
          if vim.o.winbar == "" then
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            return
          end
          vim.o.winbar = ""
        end
      '';
      options = {
        silent = true;
      };
    }
  ];
}
