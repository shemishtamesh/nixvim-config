{
  imports = [
    ./nix
    ./python
    ./lua.nix
    ./go.nix
    ./qml.nix
    ./rust.nix
    ./typescript.nix
    ./typst.nix
  ];
  lsp = {
    inlayHints.enable = true;
    servers = {
      clangd.enable = true; # c/c++
      java_language_server.enable = true; # java
      sqls.enable = true; # sql
      bashls.enable = true; # bash
      yamlls.enable = true; # yaml
      taplo.enable = true; # toml
      jsonls.enable = true; # json
      openscad_lsp.enable = true; # openscad
      html.enable = true; # html
    };
  };
  plugins.lean.enable = true; # lean
}
