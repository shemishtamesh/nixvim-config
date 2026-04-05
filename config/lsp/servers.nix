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
      # c/c++
      clangd.enable = true;

      # java
      java_language_server.enable = true;

      # sql
      sqls.enable = true;

      # bash
      bashls.enable = true;

      # yaml
      yamlls.enable = true;

      # toml
      taplo.enable = true;

      # json
      jsonls.enable = true;

      # openscad
      openscad_lsp.enable = true;

      # html
      html.enable = true;
    };
  };
  imports = [
    # nix
    # ./tix.nix
    ./nixd.nix

    # python
    # ./pylsp.nix
    ./astral.nix

    # go
    ./gopls.nix

    # qml
    ./qmlls.nix

    # rust
    ./rustaceanvim.nix

    # typescript
    ./typescript-tools.nix
  ];
  plugins = {
    # lean
    lean.enable = true;
  };
}
