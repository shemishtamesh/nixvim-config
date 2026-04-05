{
  pkgs,
  config,
  utils,
  ...
}:
let
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
  toggle_diagnostics_on_separate_lines.__raw = ''
    function()
      local cfg = vim.diagnostic.config()
      vim.diagnostic.config({
        virtual_lines = not cfg.virtual_lines,
        virtual_text = not cfg.virtual_text,
      })
    end
  '';
  keymap = key: action: {
    mode = "n";
    inherit key action;
  };
in
{
  lsp.keymaps = [
    (keymap "<leader>la" "<cmd>lua vim.lsp.buf.code_action()<cr>")
    (keymap "<leader>lf" "<cmd>lua vim.lsp.buf.format()<cr>")
    (keymap "<leader>ln" "<cmd>lua vim.lsp.buf.rename()<cr>")
    (keymap "<leader>lh" "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    (keymap "<leader>lc" "<cmd>lua vim.lsp.buf.typehierarchy()<cr>")
    (keymap "<leader>ll" toggle_diagnostics_on_separate_lines)
    (keymap "<leader>ld" telescope_commands.diagnostics)
    (keymap "<leader>lm" telescope_commands.implementations)
    (keymap "<leader>li" telescope_commands.incoming_calls)
    (keymap "<leader>lo" telescope_commands.outgoing_calls)
    (keymap "<leader>lr" telescope_commands.references)
    (keymap "<leader>lt" telescope_commands.type_definitions)
    (keymap "<leader>ls" telescope_commands.workspace_symbols)
    (keymap "<leader>lO" telescope_commands.document_symbols)
    (keymap "gD" telescope_commands.declarations)
    (keymap "gd" telescope_commands.definitions)
    (keymap "]d" "<cmd>lua vim.diagnostic.goto_next()<cr>")
    (keymap "[d" "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    (keymap "<M-d>" "<cmd>lua vim.diagnostic.open_float()<cr>")
  ];
}
