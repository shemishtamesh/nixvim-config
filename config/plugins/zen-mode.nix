{ lib, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.zen-mode = {
    enable = true;
    settings = {
      window = {
        backdrop = 0;
        width = 80;
        height = 1;
        options = {
          signcolumn = "no";
          colorcolumn = "0";
          number = false;
          relativenumber = false;
          foldcolumn = "0";
          list = false;
        };
      };
      plugins = {
        options = {
          enabled = true;
          ruler = false;
          showcmd = false;
          laststatus = 0;
        };
        tmux.enabled = true;
        kitty = {
          enabled = true;
          font = "+4";
        };
      };
    };
  };
  plugins.twilight.enable = true;
  keymaps = [
    (keymap "n" "<leader>z" (lib.concatStrings [
      "<cmd> lua "
      " vim.cmd('ZenMode');"
      " vim.cmd('IBLToggle');"
      " vim.cmd('GitBlameToggle');"
      " vim.diagnostic.enable(not vim.diagnostic.is_enabled());"
      " vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());"
      "<CR>"
    ]) { silent = true; })
  ];
}
