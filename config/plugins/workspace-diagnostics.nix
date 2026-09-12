{ pkgs, ... }:

{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "workspace-diagnostics.nvim";
      version = "latest";
      src = fetchFromGitHub {
        owner = "artemave";
        repo = "workspace-diagnostics.nvim";
        rev = "main";
        sha256 = "sha256-xVZYcOw+n/6+4aW+7pcngTTQUBbGsO+QjcHXf3GtaFs=";
      };
    })
  ];

  lsp.onAttach = # lua
    ''
      if client:supports_method("workspace/diagnostic", bufnr) then
        vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
      else
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
      end
    '';
}
