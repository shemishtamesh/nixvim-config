{
  autoCmd = [
    {
      event = [ "BufWritePre" ];
      callback.__raw = ''
        function(args)
          local file = vim.api.nvim_buf_get_name(args.buf)
          if file == "" then
            return
          end

          if file:match("^%w%w+://") then
            return
          end

          local dir = vim.fn.fnamemodify(file, ":p:h")
          if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
          end
        end
      '';
    }
  ];
}
