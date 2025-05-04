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
  };
}
