{ utils, ... }:
{
  plugins.otter = {
    enable = true;
    settings.handle_leading_whitespace = true;
  };
  extraConfigLua = utils.filetype_configs {
    markdown = /* lua */ ''
      require("otter").activate()
    '';
  };
}
