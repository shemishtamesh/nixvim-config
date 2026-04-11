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
      { }
    )

    # system clipboard
    (utils.map "n" "<leader>y" ''"+y'' { silent = true; })
    (utils.map "v" "<leader>y" ''"+y:let @*=@+<cr>'' { silent = true; })
    (utils.map "n" "<leader>Y" ''"+y$:let @*=@+<cr>'' { silent = true; })
    (utils.map "v" "<leader>Y" ''"+yy:let @*=@+<cr>'' { silent = true; })
    (utils.map [ "n" "v" ] "<leader>p" ''"+p'' { silent = true; })
    (utils.map [ "n" "v" ] "<leader>P" ''"+P'' { silent = true; })
    (utils.map [ "n" "v" ] "<M-p>" ''"0p'' { silent = true; })
    (utils.map [ "n" "v" ] "<M-P>" ''"0P'' { silent = true; })

    # quickfix list navigation
    (utils.map "n" "<M-o>" "<cmd>cprev<cr>" { silent = true; })
    (utils.map "n" "<M-i>" "<cmd>cnext<cr>" { silent = true; })
    (utils.map "n" "<leader>k" "<cmd>lprev<cr>" { silent = true; })
    (utils.map "n" "<leader>j" "<cmd>lnext<cr>" { silent = true; })

    # replace current word
    (utils.map "n" "<leader>rw" ":%s/<C-r><C-w>/t/gI<Left><Left><Left><BackSpace>" { })

    # make current file executable
    (utils.map "n" "<leader>x" "<cmd>!chmod +x %<cr>" { silent = true; })
    (utils.map "n" "<leader>X" "<cmd>!chmod -x %<cr>" { silent = true; })

    # toggle spell check
    (utils.map "n" "<leader>sc" "<cmd>setlocal spell! spelllang=en_us<cr>" { silent = true; })

    # toggle search highlighting highlighting
    (utils.map "n" "<leader>h" "<cmd>set hlsearch!<cr>" { silent = true; })

    # faster exit
    (utils.map "n" "Q" "<cmd>qa<cr>" { silent = true; })
    (utils.map "n" "<leader>Q" "<cmd>qa!<cr>" { silent = true; })

    # alternative alternative file binding
    (utils.map "n" "<M-6>" "<C-^>" { silent = true; })

    # select last pasted text
    (utils.map "n" "gp"
      ''<cmd>lua vim.api.nvim_feedkeys("`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]", "n", false)<cr>''
      { silent = true; }
    )

    # return to normal mode in terminal
    (utils.map "t" "<A-Esc>" "<C-\\><C-n>" { })

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
