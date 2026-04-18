{
  lsp.servers.ruff = {
    enable = true;
    config = {
      init_options = {
        settings = {
          lineLength = 79;
          indent-width = 4;
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
          configuration = {
            lint = {
              flake8-implicit-str-concat.allow-multiline = false;
              flake8-quotes = {
                inline-quotes = "double";
                multiline-quotes = "double";
                docstring-quotes = "double";
              };
              pycodestyle.max-line-length = 79;
            };
            format = {
              quote-style = "double";
              line-ending = "lf";
              skip-magic-trailing-comma = false;
              docstring-code-format = true;
            };
          };
        };
      };
    };
  };
}
