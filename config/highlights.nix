{
  colorschemes.base16 = {
    enable = true;
    colorscheme = {
      base00 = "#000000";
      base01 = "#242422";
      base02 = "#484844";
      base03 = "#6c6c66";
      base04 = "#918f88";
      base05 = "#b5b3aa";
      base06 = "#d9d7cc";
      base07 = "#fdfbee";
      base08 = "#df4c40";
      base09 = "#c9a042";
      base0A = "#dfdf96";
      base0B = "#88df40";
      base0C = "#a6a5de";
      base0D = "#76abde";
      base0E = "#df53dd";
      base0F = "#916a1d";
    };
    settings = {
      telescope = true;
      telescope_borders = true;
      cmp = true;
      dapui = true;
      indentblankline = true;
    };
  };
  autoCmd = [
    {
      event = "TextYankPost";
      command = # lua
        ''
          lua vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
        '';
    }
  ];
}
