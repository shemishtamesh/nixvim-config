{
  plugins = {
    render-markdown.enable = true;

    cmp = {
      settings = {
        sources = [ { name = "render-markdown"; } ];
      };
    };
  };
}
