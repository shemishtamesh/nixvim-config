{ utils, ... }:
{
  plugins.otter = {
    enable = true;
    settings.buffers.ignore_pattern = {
      python = "(^ *$|^(%s*[%%!].*))";
      lua = "^ *$";
    };
  };
  extraConfigLua = utils.filetype_configs {
    markdown = /* lua */ ''
      require("otter").activate()
    '';
  };
}
