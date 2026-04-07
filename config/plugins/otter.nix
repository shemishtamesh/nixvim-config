{ utils, ... }:
{
  plugins.otter = {
    enable = true;
    settings.buffers.ignore_pattern = {
      python = "(^ *$|^(%s*[%%!].*))";
      lua = "^ *$";
    };
  };
  extraConfigLua = /* lua */ ''
    ${
      utils.filetype_configs {
        markdown = /* lua */ ''
          require("otter").activate()
        '';
      }
    }

    local function is_otter_buffer(bufnr)
      if not bufnr or bufnr == 0 then return false end
      local ok, name = pcall(vim.api.nvim_buf_get_name, bufnr)
      if not ok or not name or name == "" then return false end
      local result = name:match("%.otter%.[^.]+$") ~= nil
      return result
    end

    local function filter_diagnostics(diagnostics)
      local filtered = {}
      for _, d in ipairs(diagnostics or {}) do
        if not is_otter_buffer(d.bufnr) then
          table.insert(filtered, d)
        end
      end
      return filtered
    end

    local original_setqflist = vim.diagnostic.setqflist

    ---@diagnostic disable: duplicate-set-field
    vim.diagnostic.setqflist = function(opts)
      opts = opts or {}
      local bufnr = opts.bufnr

      if not bufnr then
        local all_diagnostics = filter_diagnostics(vim.diagnostic.get())
        ---@diagnostic disable: inject-field
        opts.bufnr = nil
        opts.diagnostics = all_diagnostics
      elseif is_otter_buffer(bufnr) then
        return
      end

      original_setqflist(opts)
    end

    local original_get = vim.diagnostic.get

    vim.diagnostic.get = function(bufnr, opts)
      if bufnr and is_otter_buffer(bufnr) then
        return {}
      end
      local result = original_get(bufnr, opts)
      if not bufnr then
        return filter_diagnostics(result)
      end
      return result
    end

    local original_open = vim.diagnostic.open_float

    vim.diagnostic.open_float = function(bufnr, opts)
      if bufnr and is_otter_buffer(bufnr) then
        return nil
      end
      return original_open(bufnr, opts)
    end
  '';
}
