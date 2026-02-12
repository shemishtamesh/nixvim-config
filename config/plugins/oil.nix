{
  plugins = {
    oil = {
      enable = true;
      settings = {
        columns = [
          "icon"
          "permissions"
          "size"
          "mtime"
        ];
        delete_to_trash = true;
        skip_confirm_for_simple_edits = false;
        view_options = {
          show_hidden = true;
        };
        keymaps = {
          "<M-s>" = "actions.select";
          "<M-h>" = "actions.select";
          "<M-t>" = "actions.select";
          "<M-p>" = "actions.preview";
          "<M-c>" = "actions.close";
          "<M-l>" = "actions.refresh";
          "<C-s>" = false;
          "<C-h>" = false;
          "<C-t>" = false;
          "<C-p>" = false;
          "<C-c>" = false;
          "<C-l>" = false;
        };
      };
    };
    oil-git-status.enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = ''
        function()
          if vim.w.is_oil_win then
            require("oil").close()
          else
            require("oil").open_float(nil, { preview = {} })
          end
        end
      '';
      options = {
        silent = true;
        desc = "Toggle file explorer";
      };
    }
  ];
}
