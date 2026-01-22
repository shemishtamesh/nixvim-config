{
  plugins = {
    avante = {
      enable = true;
      settings = {
        provider = "opencode";
        acp_providers = {
          opencode = {
            command = "opencode";
            args = [ "acp" ];
          };
        };
      };
    };
  };
}
