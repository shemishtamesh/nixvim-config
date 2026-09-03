{ utils, ... }:
{
  extraConfigLua = builtins.readFile ./config.lua;

  keymaps = [
    # system clipboard
    (utils.map "n" "<leader>y" ''"+y'' { silent = true; desc = "Yank to clipboard"; })
    (utils.map "v" "<leader>y" ''"+y:let @*=@+<cr>'' { silent = true; desc = "Yank selection to clipboard"; })
    (utils.map "n" "<leader>Y" ''"+y$:let @*=@+<cr>'' { silent = true; desc = "Yank line to clipboard"; })
    (utils.map "v" "<leader>Y" ''"+yy:let @*=@+<cr>'' { silent = true; desc = "Yank line to clipboard (visual)"; })
    (utils.map [ "n" "v" ] "<leader>p" ''"+p'' { silent = true; desc = "Paste from clipboard"; })
    (utils.map [ "n" "v" ] "<leader>P" ''"+P'' { silent = true; desc = "Paste from clipboard (before cursor)"; })
    (utils.map [ "n" "v" ] "<M-p>" ''"0p'' { silent = true; desc = "Paste from register 0"; })
    (utils.map [ "n" "v" ] "<M-P>" ''"0P'' { silent = true; desc = "Paste from register 0 (before cursor)"; })

    # copy file location to clipboard
    {
      mode = "n";
      key = "<leader>bY";
      action.__raw = "function() CopyLocation(false) end";
      options = { silent = true; desc = "Copy cursor location (absolute path)"; };
    }
    {
      mode = "n";
      key = "<leader>by";
      action.__raw = "function() CopyLocation(true) end";
      options = { silent = true; desc = "Copy cursor location (relative path)"; };
    }
    {
      mode = "v";
      key = "<leader>bY";
      action.__raw = "function() CopyVisualLocation(false) end";
      options = { silent = true; desc = "Copy cursor location + code block (absolute)"; };
    }
    {
      mode = "v";
      key = "<leader>by";
      action.__raw = "function() CopyVisualLocation(true) end";
      options = { silent = true; desc = "Copy cursor location + code block (relative)"; };
    }
  ];
}
