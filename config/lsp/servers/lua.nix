{ pkgs, ... }:
let
  solarus_lua_api = pkgs.fetchzip {
    name = "solarus_lua_api";
    url = "https://gitlab.com/api/v4/projects/solarus-games%2Fsolarus/repository/archive.zip?path=work/EmmyLua/emmy_api&sha=release-2.0.1";
    extension = "zip";
    sha256 = "sha256-y+OQAWjazwwf/EFiLvBrgt90pOF4jM7GpCDiqzaWINE=";
  };
in
{
  lsp.servers.lua_ls = {
    enable = true;
    config.settings.Lua = {
      telemetry = {
        enable = false;
      };
      diagnostics.globals = [
        "vim"
        "love"
        "sol"
      ];
      workspace = {
        library = [
          "${pkgs.neovim}/share/nvim/runtime"
          "\${3rd}/love2d/library"
          "${solarus_lua_api}/work/EmmyLua/emmy_api"
        ];
        checkThirdParty = false;
      };
      hint = {
        enable = true;
        arrayIndex = "Enable";
        setType = true;
        paramName = "All";
        paramType = true;
      };
    };
  };
}
