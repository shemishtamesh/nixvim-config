{
  plugins = {
    lualine = {
      enable = true;
      settings.sections.lualine_a = [
        {
          __unkeyed-1 = {
            __raw = ''
              function()
                local reg = vim.fn.reg_recording()
                if reg == "" then return "" end
                return "@" .. reg
              end
            '';
          };
        }
        "mode"
      ];
    };
  };
}
