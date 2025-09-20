{ pkgs, config, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;

  telescope_commands = (
    if config.plugins.telescope.enable then
      {
        workspace_symbols = "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>";
        document_symbols = "<cmd>Telescope lsp_document_symbols<cr>";
        type_definitions = "<cmd>Telescope lsp_type_definitions<cr>";
        references = "<cmd>Telescope lsp_references<cr>";
        implementations = "<cmd>Telescope lsp_implementations<cr>";
        incoming_calls = "<cmd>Telescope lsp_incoming_calls<cr>";
        outgoing_calls = "<cmd>Telescope lsp_outgoing_calls<cr>";
        definitions = "<cmd>Telescope lsp_definitions<cr>";
        declarations = "<cmd>Telescope lsp_declarations<cr>";
        diagnostics = "<cmd>Telescope diagnostics<cr>";
      }
    else
      {
        workspace_symbols = "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>";
        document_symbols = "<cmd>lua vim.lsp.buf.document_symbol()<cr>";
        type_definitions = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        references = "<cmd>lua vim.lsp.buf.references()<cr>";
        implementations = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        incoming_calls = "<cmd>lua vim.lsp.buf.incoming_calls()<cr>";
        outgoing_calls = "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>";
        definitions = "<cmd>lua vim.lsp.buf.definition()<cr>";
        declarations = "<cmd>lua vim.lsp.buf.declaration()<cr>";
        diagnostics = "<cmd>lua vim.diagnostic.setqflist()<cr>";
      }
  );
in
{
  diagnostic.settings = {
    signs = false;
    underline = true;
    virtual_text = true;
    severity_sort = true;
    update_in_insert = true;
  };
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        nixd = {
          enable = true;
          settings.formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
        };
        pylsp = {
          enable = true;
          settings = {
            plugins = {
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
                  "FIX"
                  "ISC"
                  "D414"
                  "D417"
                  "D419"
                ];
                lineLength = 79;
                config = builtins.toString (
                  (pkgs.formats.toml { }).generate "ruff.toml" {
                    lint.flake8-implicit-str-concat.allow-multiline = false;
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
        };
        lua_ls = {
          enable = true;
          settings = {
            telemetry.enable = false;
            diagnostics.globals = [
              "vim"
              "love"
            ];
            workspace = {
              library = [
                "${pkgs.neovim}/share/nvim/runtime"
                "\${3rd}/love2d/library"
              ];
              checkThirdParty = false;
            };
            Lua = {
              hint = {
                enable = true;
                arrayIndex = "Enable";
                setType = true;
                paramName = "All";
                paramType = true;
              };
            };
          };
        };
        gopls = {
          enable = true;
          settings = {
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              compositeLiteralTypes = true;
              constantValues = true;
              functionTypeParameters = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };
        };
        tinymist = {
          enable = true;
          settings = {
            formatterMode = "typstyle";
            exportPdf = "onType";
            outputPath = "$root/target/$name";
          };
        };
        qmlls = {
          enable = true;
          cmd = [
            "qmlls"
            "-E"
          ];
        };
        clangd.enable = true;
        java_language_server.enable = true;
        sqls.enable = true;
        bashls.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        openscad_lsp.enable = true;
      };
    };
    rustaceanvim.enable = true;
    typescript-tools.enable = true;
    lean.enable = true;
  };
  keymaps = [
    # defined outside of lsp for whichkey
    (keymap "n" "<leader>la" "<cmd>lua vim.lsp.buf.code_action()<cr>" { silent = true; })
    (keymap "n" "<leader>lf" "<cmd>lua vim.lsp.buf.format()<cr>" { silent = true; })
    (keymap "n" "<leader>ln" "<cmd>lua vim.lsp.buf.rename()<cr>" { silent = true; })
    (keymap "n" "<leader>lh" "<cmd>lua vim.lsp.buf.signature_help()<cr>" { silent = true; })
    (keymap "n" "<leader>lc" "<cmd>lua vim.lsp.buf.typehierarchy()<cr>" { silent = true; })
    (keymap "n" "<leader>ll"
      "<cmd>lua vim.diagnostic.config({virtual_lines = not vim.diagnostic.config().virtual_lines, virtual_text = not vim.diagnostic.config().virtual_text})<cr>"
      {
        silent = true;
      }
    )
    (keymap "n" "<leader>ld" telescope_commands.diagnostics { silent = true; })
    (keymap "n" "<leader>lm" telescope_commands.implementations { silent = true; })
    (keymap "n" "<leader>li" telescope_commands.incoming_calls { silent = true; })
    (keymap "n" "<leader>lo" telescope_commands.outgoing_calls { silent = true; })
    (keymap "n" "<leader>lr" telescope_commands.references { silent = true; })
    (keymap "n" "<leader>lt" telescope_commands.type_definitions { silent = true; })
    (keymap "n" "<leader>ls" telescope_commands.workspace_symbols { silent = true; })
    (keymap "n" "<leader>lO" telescope_commands.document_symbols { silent = true; })
    (keymap "n" "gD" telescope_commands.declarations { silent = true; })
    (keymap "n" "gd" telescope_commands.definitions { silent = true; })
    (keymap "n" "]d" "<cmd>lua vim.diagnostic.goto_next()<cr>" { silent = true; })
    (keymap "n" "[d" "<cmd>lua vim.diagnostic.goto_prev()<cr>" { silent = true; })
  ];
  extraPackages = with pkgs; [
    cargo
    rustc
    lldb
    typescript # tsserver
  ];
}
