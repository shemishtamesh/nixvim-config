{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
    };
  };
  autoCmd = [
    {
      event = "ModeChanged";
      command = "WhichKey";
    }
  ];
}
