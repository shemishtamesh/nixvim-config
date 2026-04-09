{ pkgs, ... }:
{
  lsp.servers = {
    ty.enable = true;
    ruff = {
      enable = true;
      config = {
        init_options = {
          settings = {
            lineLength = 79;

            lint = {
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
              ignore = [
                "F821" # duplicate of a ty error
                "ISC003"
              ];
            };

            configuration = toString (
              (pkgs.formats.toml { }).generate "ruff.toml" {
                lint = {
                  flake8-implicit-str-concat.allow-multiline = false;
                  pycodestyle.max-line-length = 79;
                  flake8-quotes = {
                    inline-quotes = "double";
                    multiline-quotes = "double";
                    docstring-quotes = "double";
                  };
                };
                format = {
                  quote-style = "double";
                  indent-width = 4;
                  line-ending = "lf";
                  skip-magic-trailing-comma = false;
                  docstring-code-format = true;
                };
              }
            );
          };
        };
      };
    };
  };
}
