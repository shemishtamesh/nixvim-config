{
  plugins.navic = {
    enable = true;
    settings.lsp.auto_attach = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>to";
      action.__raw = ''
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
        desc = "Toggle Breadcrumbs (Navic)";
      };
    }
  ];
}
