{ pkgs, ... }:
{
  lsp.servers.nixd = {
    enable = true;
    config.formatting.command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
  };
}
