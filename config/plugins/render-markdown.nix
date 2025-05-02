{ pkgs, ... }:
{
  plugins = {
    render-markdown.enable = true;

    cmp = {
      settings = {
        sources = [ { name = "render-markdown"; } ];
      };
    };
  };

  extraPackages = with pkgs; [ python3Packages.pylatexenc ];
}
