{
  extraFiles = {
    "ftplugin/man.lua".text = # lua
      ''
        local go_to_manpage = function()
          local word = vim.fn.expand('<cword>')
          vim.cmd('Man ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_manpage, { noremap = true })
      '';
    "ftplugin/hlep.lua".text = # lua
      ''
        local go_to_help = function()
        local line = vim.api.nvim_get_current_line()
        local word = line:match("|([^|]*)|")
          vim.cmd('help ' .. word)
        end
        vim.keymap.set('n', 'gd', go_to_help, { noremap = true })
      '';
    "ftplugin/markdown.lua".text = # lua
      ''
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.spell = true
      '';
    "ftplugin/gitcommit.lua".text = # lua
      "vim.opt.spell = true";
  };
}
