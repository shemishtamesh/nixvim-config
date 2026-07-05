{
  lsp.servers.gopls = {
    enable = true;
    config.settings.gopls.hints = {
      assignVariableTypes = true;
      compositeLiteralFields = true;
      compositeLiteralTypes = true;
      constantValues = true;
      functionTypeParameters = true;
      parameterNames = true;
      rangeVariableTypes = true;
    };
  };
}
