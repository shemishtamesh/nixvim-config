{ utils, ... }:
let
  restart_session = "/tmp/current_nvim_session_for_restart.vim";
in
{
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
  };

  extraConfigLua = ''
    ---@param relative boolean
    function CopyLocation(relative)
      local file = relative and vim.fn.expand("%:~:.") or vim.fn.expand("%:p")
      if file == "" then file = "[No Name]" end
      local loc = string.format("%s:%d:%d", file, vim.fn.line("."), vim.fn.col("."))
      vim.fn.setreg("+", loc)
      vim.fn.setreg("*", loc)
      vim.notify("Copied: " .. loc)
    end

    ---@param relative boolean
    function CopyVisualLocation(relative)
      local file = relative and vim.fn.expand("%:~:.") or vim.fn.expand("%:p")
      if file == "" then file = "[No Name]" end
      local loc = string.format("%s:%d:%d", file, vim.fn.line("v"), vim.fn.col("v"))
      vim.cmd('normal! "+y')
      local text = vim.fn.getreg("+")
      local ft = vim.bo.filetype
      local fence = ft ~= "" and ("```" .. ft) or "```"
      local result = string.format("%s\n%s\n%s\n```", loc, fence, text)
      vim.fn.setreg("+", result)
      vim.fn.setreg("*", result)
      vim.notify("Copied location + code block")
    end
  '';

  keymaps = [
    # restart session (reload config)
    (utils.map "n" "<leader><M-r>"
      "<cmd>mksession! ${restart_session} | restart source ${restart_session}<cr>"
      { desc = "Restart Neovim (save session)"; }
    )

    # system clipboard
    (utils.map "n" "<leader>y" ''"+y'' { silent = true; desc = "Yank to clipboard"; })
    (utils.map "v" "<leader>y" ''"+y:let @*=@+<cr>'' { silent = true; desc = "Yank selection to clipboard"; })
    (utils.map "n" "<leader>Y" ''"+y$:let @*=@+<cr>'' { silent = true; desc = "Yank line to clipboard"; })
    (utils.map "v" "<leader>Y" ''"+yy:let @*=@+<cr>'' { silent = true; desc = "Yank line to clipboard (visual)"; })
    (utils.map [ "n" "v" ] "<leader>p" ''"+p'' { silent = true; desc = "Paste from clipboard"; })
    (utils.map [ "n" "v" ] "<leader>P" ''"+P'' { silent = true; desc = "Paste from clipboard (before cursor)"; })
    (utils.map [ "n" "v" ] "<M-p>" ''"0p'' { silent = true; desc = "Paste from register 0"; })
    (utils.map [ "n" "v" ] "<M-P>" ''"0P'' { silent = true; desc = "Paste from register 0 (before cursor)"; })

    # location list navigation
    (utils.map "n" "<leader>jj" "<cmd>lnext<cr>" { silent = true; desc = "Jump to next location"; })
    (utils.map "n" "<leader>jk" "<cmd>lprev<cr>" { silent = true; desc = "Jump to previous location"; })

    # replace current word
    (utils.map "n" "<leader>rw" ":%s/<C-r><C-w>/t/gI<Left><Left><Left><BackSpace>" { desc = "Replace word under cursor"; })

    # make current file executable
    (utils.map "n" "<leader>mx" "<cmd>!chmod +x %<cr>" { silent = true; desc = "Make file executable"; })
    (utils.map "n" "<leader>mX" "<cmd>!chmod -x %<cr>" { silent = true; desc = "Make file non-executable"; })

    # toggle spell check
    (utils.map "n" "<leader>ts" "<cmd>setlocal spell! spelllang=en_us<cr>" { silent = true; desc = "Toggle spell check"; })

    # toggle search highlighting
    (utils.map "n" "<leader>th" "<cmd>set hlsearch!<cr>" { silent = true; desc = "Toggle search highlight"; })

    # faster exit
    (utils.map "n" "Q" "<cmd>qa<cr>" { silent = true; desc = "Quit all" ; })
    (utils.map "n" "<leader>Q" "<cmd>qa!<cr>" { silent = true; desc = "Force quit all"; })

    # alternative alternative file binding
    (utils.map "n" "<M-6>" "<C-^>" { silent = true; desc = "Toggle alternate file"; })

    # select last pasted text
    (utils.map "n" "gp"
      ''<cmd>lua vim.api.nvim_feedkeys("`[" .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. "`]", "n", false)<cr>''
      { silent = true; desc = "Select last pasted text"; }
    )

    # copy file location to clipboard
    {
      mode = "n";
      key = "<leader>yC";
      action.__raw = "function() CopyLocation(false) end";
      options = { silent = true; desc = "Copy cursor location (absolute path)"; };
    }
    {
      mode = "n";
      key = "<leader>yc";
      action.__raw = "function() CopyLocation(true) end";
      options = { silent = true; desc = "Copy cursor location (relative path)"; };
    }
    {
      mode = "v";
      key = "<leader>yC";
      action.__raw = "function() CopyVisualLocation(false) end";
      options = { silent = true; desc = "Copy cursor location + code block (absolute)"; };
    }
    {
      mode = "v";
      key = "<leader>yc";
      action.__raw = "function() CopyVisualLocation(true) end";
      options = { silent = true; desc = "Copy cursor location + code block (relative)"; };
    }

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
