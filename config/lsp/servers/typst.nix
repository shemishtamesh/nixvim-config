{
  lsp.servers.tinymist = {
    enable = true;
    config.settings = {
      formatterMode = "typstyle";
      exportPdf = "onType";
      outputPath = "$root/target/$name";
    };
  };
}
