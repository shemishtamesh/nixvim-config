{ pkgs, ... }:
{
  extraFiles = {
    "ftplugin/nix.lua".text = # lua
      ''
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
      '';
    "ftplugin/man.lua".text = # lua
      ''
        local go_to_manpage = function()
          local word = vim.fn.expand('<cword>')
          vim.cmd('Man ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_manpage, { noremap = true, buffer = true })
      '';
    "ftplugin/help.lua".text = # lua
      ''
        local go_to_help = function()
          local line = vim.api.nvim_get_current_line()
          local word = line:match("|([^|]*)|")
          vim.cmd('help ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_help, { noremap = true, buffer = true })
      '';
    "ftplugin/markdown.lua".text = # lua
      ''
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.spell = true
      '';
    "ftplugin/gitcommit.lua".text = # lua
      "vim.opt.spell = true";
    "ftplugin/typst.lua".text =
      # not using normal string interpulation so that lua_ls wouldn't think there's a problem
      builtins.replaceStrings [ "nix_store_zathura_path" ] [ "${pkgs.zathura}/bin/zathura" ] # lua
        ''
          vim.opt.wrap = true
          vim.opt.linebreak = true
          vim.opt.spell = true

          local zathura_path = "nix_store_zathura_path"
          vim.keymap.set(
            'n',
            '<leader>lp',
            '<CMD>silent !' .. zathura_path .. ' target/%:.:r.pdf&<CR>',
            { noremap = true, buffer = true }
          )
        '';
    "ftplugin/c.lua".text = # lua
      ''
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
      '';
  };
}
