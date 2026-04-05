{ utils, pkgs, ... }:
{
  plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;

    dap-python.enable = true;
    dap-go.enable = true;
  };
  keymaps = [
    (utils.map "n" "<leader>db" "<cmd>lua require('dap').toggle_breakpoint()<cr>" { })
    (utils.map "n" "<leader>dc" "<cmd>lua require('dap').continue()<cr>" { })
    (utils.map "n" "<leader>ds" "<cmd>lua require('dap').run_to_cursor()<cr>" { })
    (utils.map "n" "<leader>di" "<cmd>lua require('dap').step_into()<cr>" { })
    (utils.map "n" "<leader>do" "<cmd>lua require('dap').step_over()<cr>" { })
    (utils.map "n" "<leader>du" "<cmd>lua require('dap').step_out()<cr>" { })
    (utils.map "n" "<leader>da" "<cmd>lua require('dap').step_back()<cr>" { })
    (utils.map "n" "<leader>dr" "<cmd>lua require('dap').restart()<cr>" { })
    (utils.map "n" "<leader>dt" "<cmd>lua require('dap').terminate()<cr>" { })
    (utils.map "n" "<leader>dk" "<cmd>lua require('dapui').eval(nil, {enter = true})<cr>" { })
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
  extraPackages = with pkgs; [
    lldb
  ];
}
