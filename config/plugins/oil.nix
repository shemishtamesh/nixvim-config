let
  keymap = (import ../nix_functions.nix).keymap;
in
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
        keymaps.q = "actions.close";
        delete_to_trash = true;
        skip_confirm_for_simple_edits = false;
        view_options = {
          show_hidden = true;
        };
      };
    };
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
