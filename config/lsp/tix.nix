/*
  NOTE: add this to flake's input to use again:
  ```nix
  tix = {
    url = "github:JRMurr/tix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  ```
*/
{ inputs, pkgs, ... }:
{
  lsp.servers.tix =
    let
      # type: package :: Derivation
      package = inputs.tix.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      name = "tix";
      inherit package;
      config = {
        cmd = [
          "${package}/bin/tix"
          "lsp"
        ];
        filetypes = [ "nix" ];
        root_markers = [
          "tix.toml"
          "flake.nix"
          ".git"
        ];
        settings.inlayHints.enable = false;
      };
    };

  extraPackages = [ pkgs.nixfmt ];
}
