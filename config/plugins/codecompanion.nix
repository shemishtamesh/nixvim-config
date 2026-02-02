{ lib, ... }:
let
  keymap = (import ../nix_functions.nix).keymap;
in
{
  plugins.codecompanion = {
    enable = true;
    settings = {
      opts.completion_provider = "cmp";
      interactions = lib.genAttrs [ "chat" "inline" "background" "cmd" ] (_: {
        adapter = {
          name = "ollama";
          model = "qwen3-coder";
        };
      });
      display = {
        action_palette.provider = "telescope";
        chat.start_in_insert_mode = true;
      };
    };
  };
  keymaps = [
    (keymap [ "n" "v" ] "<M-a>" "<cmd>CodeCompanion<cr>" { })
    (keymap [ "n" "v" ] "<leader>A" "<cmd>CodeCompanionActions<cr>" { })
    (keymap "n" "<leader>a" "<cmd>CodeCompanionChat Toggle<cr>" { })
    (keymap "v" "<leader>a" "<cmd>CodeCompanionChat Add<cr>" { })
    (keymap "ca" "CC" "CodeCompanion" { })
  ];
  extraConfigLua = ''
      local codecompanion_extmarks_default_opts = {
        unique_line_sign_text = "",
        first_line_sign_text = "┌",
        last_line_sign_text = "└",
        extmark = {
          sign_hl_group = "DiagnosticWarn",
          sign_text = "│",
          priority = 1000,
        },
      }

      local function codecompanion_extmarks_set_line_extmark(bufnr, ns_id, line_num, opts, sign_type)
        vim.api.nvim_buf_set_extmark(
          bufnr,
          ns_id,
          line_num - 1,
          0,
          vim.tbl_deep_extend("force", opts.extmark or {}, {
            sign_text = opts[sign_type] or opts.extmark.sign_text,
          })
        )
      end

      local function codecompanion_extmarks_create_extmarks(opts, data, ns_id)
        local context = data.buffer_context

        if context.start_line == context.end_line then
          codecompanion_extmarks_set_line_extmark(context.bufnr, ns_id, context.start_line, opts, "unique_line_sign_text")
          return
        end

        codecompanion_extmarks_set_line_extmark(context.bufnr, ns_id, context.start_line, opts, "first_line_sign_text")

        for i = context.start_line + 1, context.end_line - 1 do
          local middle = context.start_line + math.floor((context.end_line - context.start_line) / 2)
          if i == middle then
            codecompanion_extmarks_set_line_extmark(context.bufnr, ns_id, i, opts, "unique_line_sign_text")
          else
            vim.api.nvim_buf_set_extmark(context.bufnr, ns_id, i - 1, 0, opts.extmark)
          end
        end

        if context.end_line > context.start_line then
          codecompanion_extmarks_set_line_extmark(context.bufnr, ns_id, context.end_line, opts, "last_line_sign_text")
        end
      end

      local function codecompanion_extmarks_create_autocmds(opts)
        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = { "CodeCompanionRequest*" },
          callback = function(event)
            local data = event.data or {}
            local context = data.buffer_context or {}

            if vim.tbl_isempty(context) and data.interaction ~= "inline" then
              return
            end

            local ns_id = vim.api.nvim_create_namespace("CodeCompanionInline_" .. data.id)

            if event.match:find("Started") then
              codecompanion_extmarks_create_extmarks(opts, data, ns_id)
            elseif event.match:find("Finished") then
              vim.api.nvim_buf_clear_namespace(context.bufnr, ns_id, 0, -1)
            end
          end,
        })
      end

    codecompanion_extmarks_create_autocmds(vim.tbl_deep_extend("force", codecompanion_extmarks_default_opts, {}))
  '';
}
