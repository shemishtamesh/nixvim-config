{ pkgs, lib, ... }:
{
  diagnostic.settings = {
    signs = false;
    underline = true;
    virtual_text = true;
    severity_sort = true;
    update_in_insert = true;
  };
  lsp = {
    inlayHints.enable = true;
    servers = {
      clangd.enable = true;
      java_language_server.enable = true;
      sqls.enable = true;
      bashls.enable = true;
      yamlls.enable = true;
      taplo.enable = true;
      jsonls.enable = true;
      openscad_lsp.enable = true;
      html.enable = true;
    };
  };
  imports = [
    # ./tix.nix
    ./nixd.nix
    # ./pylsp.nix
    ./astral.nix
    ./gopls.nix
    ./qmlls.nix
    ./rustaceanvim.nix
    ./typescript-tools.nix
  ];
  plugins = {
    lean.enable = true;
  };
}
