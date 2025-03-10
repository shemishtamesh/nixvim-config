{ pkgs, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  diagnostics.signs.text.__raw = # make space for git signs
    ''
      {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.WARN] = "",
      }
    '';
  plugins = {
    typescript-tools.enable = true;
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
              pycodestyle = {
                enabled = true;
                ignore = [
                  "E203" # space before ':'
                  "W503" # linebreak before binary operator
                ];
              };
              black = {
                enabled = true;
                line_length = 79;
              };
              pylsp_mypy = {
                enabled = true;
                overrides.__raw = # l ua
                  ''
                    (function ()
                        virtual_environment = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
                        if virtual_environment then
                            return { "--python-executable", virtual_environment .. "/bin/python3", true }
                        end
                        return 10
                    end)()
                  '';
              };
            };
          };
        };
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
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
          };
        };
      };
      postConfig = # lua
        ''
          -- ignore repeated erorr that should probably be ignored by the lsp client anyway
          for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
            local default_diagnostic_handler = vim.lsp.handlers[method]
            vim.lsp.handlers[method] = function(err, result, context, config)
              if err ~= nil and err.code == -32802 then
                return
              end
              return default_diagnostic_handler(err, result, context, config)
            end
          end
        '';
    };
  };
  keymaps = [
    # defined outside of lsp for whichkey
    (keymap "n" "<leader>la" "<cmd>lua vim.lsp.buf.code_action()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lf" "<cmd>lua vim.lsp.buf.format()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>ln" "<cmd>lua vim.lsp.buf.rename()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lm" "<cmd>lua vim.lsp.buf.implementation()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>li" "<cmd>lua vim.lsp.buf.incoming_calls()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lo" "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lr" "<cmd>lua vim.lsp.buf.references()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lh" "<cmd>lua vim.lsp.buf.signature_help()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lt" "<cmd>lua vim.lsp.buf.type_definition()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>lc" "<cmd>lua vim.lsp.buf.typehierarchy()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>ls" "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>ll"
      "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>"
      {
        silent = true;
      }
    )
    (keymap "n" "gd" "<cmd>lua vim.lsp.buf.definition()<CR>" { silent = true; })
    (keymap "n" "gD" "<cmd>lua vim.lsp.buf.declaration()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>ld" "<cmd>lua vim.diagnostic.setqflist()<CR>" {
      silent = true;
    })
    (keymap "n" "]d" "<cmd>lua vim.lsp.buf.goto_next()<CR>" { silent = true; })
    (keymap "n" "[d" "<cmd>lua vim.lsp.buf.goto_prev()<CR>" { silent = true; })
  ];
}
