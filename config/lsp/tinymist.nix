{
  lsp.servers.tinymist = {
    enable = true;
    config = {
      formatterMode = "typstyle";
      exportPdf = "onType";
      outputPath = "$root/target/$name";
    };
  };
}
