{ utils, ... }:
{
  plugins.otter = {
    enable = true;
    settings.buffers.preambles = 
      let
        sh_diagnostic_disables = ''
          # shellcheck disable=SC1009,SC1039,SC1056,SC1072,SC1073,SC1078,SC1079,SC1089,SC140,SC2027,SC2034,SC2068,SC2086,SC2140,SC2145,SC2154,SC2171,SC2284,SC2288,SC2289'';
      in
      {
      sh = [ sh_diagnostic_disables ];
      bash = [ sh_diagnostic_disables ];
      zsh = [ sh_diagnostic_disables ];
      lua = [
        "---@diagnostic disable: duplicate-set-field, exp-in-action, inject-field, miss-name, miss-sep-in-table, miss-symbol, undefined-global, trailing-space, unreachable-code, unused-local"
      ];
    };
  };
  extraConfigLua = /* lua */ ''
    ${utils.filetype_configs {
      markdown = /* lua */ ''
        require("otter").activate()
      '';
    }}

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

    vim.diagnostic.setqflist = function(opts)
      opts = opts or {}
      local bufnr = opts.bufnr

      if not bufnr then
        local all_diagnostics = filter_diagnostics(vim.diagnostic.get())
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
