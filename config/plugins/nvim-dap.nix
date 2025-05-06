let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    dap-python.enable = true;
    dap-go.enable = true;
  };
  keymaps = [
    (keymap "n" "<leader>db" "<cmd>lua require('dap').toggle_breakpoint()<CR>" { })
    (keymap "n" "<leader>dc" "<cmd>lua require('dap').continue()<CR>" { })
    (keymap "n" "<leader>ds" "<cmd>lua require('dap').run_to_cursor()<CR>" { })
    (keymap "n" "<leader>di" "<cmd>lua require('dap').step_into()<CR>" { })
    (keymap "n" "<leader>do" "<cmd>lua require('dap').step_over()<CR>" { })
    (keymap "n" "<leader>du" "<cmd>lua require('dap').step_out()<CR>" { })
    (keymap "n" "<leader>da" "<cmd>lua require('dap').step_back()<CR>" { })
    (keymap "n" "<leader>dr" "<cmd>lua require('dap').restart()<CR>" { })
    (keymap "n" "<leader>dt" "<cmd>lua require('dap').terminate()<CR>" { })
    (keymap "n" "<leader>dk" "<cmd>lua require('dapui').eval(nil, {enter = true})<CR>" { })
  ];
  extraConfigLua = ''
    require('dap').listeners.before.attach.dapui_config = function()
      require('dapui').open()
    end
    require('dap').listeners.before.launch.dapui_config = function()
      require('dapui').open()
    end
    require('dap').listeners.before.event_terminated.dapui_config = function()
      require('dapui').close()
    end
    require('dap').listeners.before.event_exited.dapui_config = function()
      require('dapui').close()
    end
  '';
}
