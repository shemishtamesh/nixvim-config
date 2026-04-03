{ pkgs, utils, ... }:
{
  extraConfigLua = utils.filetype_configs {
    nix = # lua
      ''
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
      '';

    man = # lua
      ''
        local go_to_manpage = function()
          local word = vim.fn.expand('<cword>')
          vim.cmd('Man ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_manpage, { noremap = true, buffer = true })
      '';

    help = # lua
      ''
        local go_to_help = function()
          local line = vim.api.nvim_get_current_line()
          local word = line:match("|([^|]*)|")
          vim.cmd('help ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_help, { noremap = true, buffer = true })
        vim.keymap.set('n', 'q', "<cmd>q<cr>", { noremap = true, buffer = true })
      '';

    markdown = # lua
      ''
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
      '';

    gitcommit = # lua
      "vim.opt_local.spell = true";

    typst =
      # not using normal string interpulation so that lua_ls wouldn't think there's a problem
      builtins.replaceStrings [ "nix_store_zathura_path" ] [ "${pkgs.zathura}/bin/zathura" ] # lua
        ''
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.spell = true

          local zathura_path = "nix_store_zathura_path"
          vim.keymap.set(
            'n',
            '<leader>lp',
            '<cmd>silent !' .. zathura_path .. ' target/%:.:r.pdf&<cr>',
            { noremap = true, buffer = true }
          )
        '';

    c = # lua
      ''
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
      '';
  };
}
