{
  pkgs,
  utils,
  ...
}:

{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "tiny-code-action.nvim";
      version = "latest";
      src = fetchFromGitHub {
      owner = "rachartier";
        repo = "tiny-code-action.nvim";
        rev = "main";
        sha256 = "sha256-PLGomUsZt5KPabBtl1xof83sOxI7bv7DkHKjOnf8+/Q=";
      };
      nvimSkipModule = [ "tiny-code-action.previewers.snacks" ];
    })
  ];

  extraConfigLua = # lua
    ''
      -- use existing telescope config instead of tiny-code-action's one
      require("tiny-code-action.config").picker_config.telescope = {}

      -- syntax highlighting in diff preview
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function()
          local lang = _G.__tca_src_lang
          if lang and lang ~= "" then
            local buf = vim.api.nvim_get_current_buf()
            if vim.bo[buf].filetype == "diff" then
              vim.bo[buf].filetype = lang
            end
          end
        end,
      })

      require("tiny-code-action").setup({
        backend = "vim",
        picker = "telescope",
        notify = {
          enabled = true,
          on_empty = true,
        },
      })
    '';

  keymaps = [
    (utils.map ["n" "x"] "<leader>la" {
      __raw = ''
        function()
          _G.__tca_src_lang = vim.bo[vim.api.nvim_get_current_buf()].filetype
          require("tiny-code-action").code_action()
        end
      '';
    } {
      desc = "Code action";
      silent = true;
      noremap = true;
    })
  ];
}
