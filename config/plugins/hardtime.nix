{
  plugins.hardtime = {
    enable = true;
    settings = {
      disable_mouse = false;
      disabled_keys.__raw = ''
        ---@diagnostic disable: exp-in-action
        {
          ["<Up>"] = {},
          ["<Down>"] = {},
          ["<Left>"] = {},
          ["<Right>"] = {},
        }
      '';
      restriction_mode = "hint";
    };
  };
}
