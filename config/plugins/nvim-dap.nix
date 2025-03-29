let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap-python.enable = true;
  };
  keymaps = [
    (keymap "n" "<leader>db" "<cmd>lua require('dap').toggle_breakpoint()<CR>" {
      silent = true;
    })
    (keymap "n" "<leader>dc" "<cmd>lua require('dap').continue()<CR>" {
      silent = true;
    })
  ];
}
