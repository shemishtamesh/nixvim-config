{ pkgs, ... }:
{
  plugins.tmux-navigator.enable = true;
  extraPlugins = with pkgs.vimPlugins; [ vim-tpipeline ];
  extraConfigLua = ''
    if vim.env.TMUX then
      vim.api.nvim_create_autocmd({ "FocusGained", "ColorScheme" }, {
        callback = function()
          vim.defer_fn(function()
            vim.opt.laststatus = 1
          end, 100)
        end,
      })

      vim.o.laststatus = 1
    end
  '';
}
