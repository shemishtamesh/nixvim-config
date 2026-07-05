{ pkgs, ... }:
{
  plugins = {
    render-markdown = {
      enable = true;
      settings.file_types = [
        "markdown"
        "codecompanion"
        "octo"
      ];
    };

    cmp = {
      settings = {
        sources = [ { name = "render-markdown"; } ];
      };
    };
  };

  extraPackages = with pkgs; [ python3Packages.pylatexenc ];
}
