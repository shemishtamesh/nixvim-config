{ pkgs, ... }:
{
  lsp.servers.pylsp = {
    enable = true;
    config.settings.pylsp.plugins = {
      ruff = {
        enabled = true;
        extendSelect = [
          "I"
          "E"
          "W"
          "Q"
          "N"
          "T10"
          "ARG"
          "ISC"
          "D414"
          "D417"
          "D419"
        ];
        lineLength = 79;
        config = toString (
          (pkgs.formats.toml { }).generate "ruff.toml" {
            lint = {
              flake8-implicit-str-concat.allow-multiline = false;
              pycodestyle.max-line-length = 79;
            };
          }
        );
      };
      pylsp_mypy = {
        enabled = true;
        overrides.__raw = # lua
          ''
            (function ()
                local virtual_environment = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                if virtual_environment then
                    return { "--python-executable", virtual_environment .. "/bin/python3", true }
                end
                return { true }
            end)()
          '';
      };
    };
  };
}
