lib: {
  map = mode: key: action: options: {
    inherit
      mode
      key
      action
      options
      ;
  };

  filetype_configs =
    configs:
    lib.strings.concatStrings (
      builtins.attrValues (
        builtins.mapAttrs (
          filetype: config: # lua
          ''
            vim.api.nvim_create_autocmd("FileType", {
              ---@diagnostic disable: miss-sep-in-table
              ---@diagnostic disable: miss-symbol
              pattern = "${filetype}",
              callback = function()
                ${config}
              end,
            })
          '') configs
      )
    );
}
