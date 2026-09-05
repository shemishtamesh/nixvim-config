{ utils, ... }:
let
  restart_session = "/tmp/current_nvim_session_for_restart.vim";
in
{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
  };

  keymaps = [
    # restart session (reload config)
    (utils.map "n" "<leader><M-r>"
      "<cmd>mksession! ${restart_session} | restart source ${restart_session}<cr>"
      { desc = "Restart Neovim (save session)"; }
    )

    # location list navigation
    (utils.map "n" "<leader>jj" "<cmd>lnext<cr>" { silent = true; desc = "Jump to next location"; })
    (utils.map "n" "<leader>jk" "<cmd>lprev<cr>" { silent = true; desc = "Jump to previous location"; })

    # replace current word
    (utils.map "n" "<leader>rw" ":%s/<C-r><C-w>/t/gI<Left><Left><Left><BackSpace>" { desc = "Replace word under cursor"; })

    # toggle file executable
    {
      mode = "n";
      key = "<leader>tx";
      action.__raw = ''
        function()
          local f = vim.fn.expand("%")
          local p = vim.fn.getfperm(f)
          if p:sub(3, 3) == "x" then
            vim.fn.setfperm(f, p:sub(1, 2) .. "-" .. p:sub(4))
            vim.notify("Removed executable")
          else
            vim.fn.setfperm(f, p:sub(1, 2) .. "x" .. p:sub(4))
            vim.notify("Made executable")
          end
        end
      '';
      options = { silent = true; desc = "Toggle file execute permission"; };
    }

    # toggle spell check
    (utils.map "n" "<leader>ts" "<cmd>setlocal spell! spelllang=en_us<cr>" { silent = true; desc = "Toggle spell check"; })

    # toggle search highlighting
    (utils.map "n" "<leader>th" "<cmd>set hlsearch!<cr>" { silent = true; desc = "Toggle search highlight"; })

    # faster exit
    (utils.map "n" "<leader>Q" "<cmd>qa<cr>" { silent = true; desc = "Quit all" ; })

    # alternative alternative file binding
    (utils.map "n" "<M-6>" "<C-^>" { silent = true; desc = "Toggle alternate file"; })

    # select last pasted text
    (utils.map "n" "gp"
      ''<cmd>lua vim.api.nvim_feedkeys("`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]", "n", false)<cr>''
      { silent = true; desc = "Select last pasted text"; }
    )

    # return to normal mode in terminal
    (utils.map "t" "<A-Esc>" "<C-\\><C-n>" { desc = "Terminal normal mode"; })

    # make gf :edit file when so it can be written if doesn't exist
    {
      mode = "";
      key = "gf";
      action.__raw = ''
        function()
          local raw = vim.fn.expand("<cfile>")
          if raw == "" then
            return
          end

          local bufname = vim.api.nvim_buf_get_name(0)

          local base_dir
          if bufname ~= "" then
            base_dir = vim.fn.fnamemodify(bufname, ":p:h")
          else
            base_dir = vim.fn.getcwd()
          end

          local target
          if vim.fn.fnamemodify(raw, ":p") == raw then
            target = raw
          else
            target = vim.fs.normalize(base_dir .. "/" .. raw)
          end

          vim.cmd.edit(vim.fn.fnameescape(target))
        end
      '';
      options = {
        desc = "[g]o to [f]ile";
      };
    }
  ];
  userCommands = {
    W = {
      command = "wa";
    };
    Q = {
      command = "qa";
    };
    Qw = {
      command = "wqa";
    };
    QW = {
      command = "wqa";
    };
    Wq = {
      command = "wqa";
    };
    WQ = {
      command = "wqa";
    };
  };
}
