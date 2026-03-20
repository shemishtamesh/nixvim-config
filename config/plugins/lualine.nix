{
  opts = {
    cmdheight = 0;
    showcmdloc = "statusline";
  };
  plugins = {
    lualine = {
      enable = true;
      settings.sections = {
        lualine_a = [
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                  local reg = vim.fn.reg_recording()
                  if reg == "" then return "" end
                  return "@" .. reg
                end
              '';
            };
          }
          "mode"
        ];
        lualine_y = [
          # "%S"
          {
            __unkeyed-1.__raw = ''
              -- Returns the size of the current visual selection for lualine
              --  - 'v' (characterwise selection): returns total characters (UTF-8 aware)
              --  - 'V' (linewise selection: returns number of lines
              --  - '\22' (blockwise selection): returns rows x columns
              function()
                -- Get current mode
                local mode = vim.fn.mode()

                -- Only proceed if in a visual mode
                if not mode:match("[vV\22]") then
                  return ""
                end

                -- Get the start of the visual selection ('v' mark)
                local vstart = vim.fn.getpos("v")
                -- Get current cursor position
                local cur = vim.api.nvim_win_get_cursor(0)

                local s_line, s_col = vstart[2], vstart[3]
                local e_line, e_col = cur[1], cur[2] + 1  -- cursor is 0-based

                -- Normalize start/end positions so start <= end
                if s_line > e_line or (s_line == e_line and s_col > e_col) then
                  s_line, e_line = e_line, s_line
                  s_col, e_col = e_col, s_col
                end

                local line_count = e_line - s_line + 1

                -- Visual line mode → just number of lines
                if mode == "V" then
                  return tostring(line_count)
                end

                -- Visual block mode → rows x columns
                if mode == "\22" then
                  local width = math.abs(e_col - s_col) + 1
                  return string.format("%dx%d", line_count, width)
                end

                -- Characterwise visual mode, sum characters across all selected lines
                if mode == "v" then
                  local total = 0

                  for l = s_line, e_line do
                    local line = vim.fn.getline(l)
                    local len = vim.fn.strchars(line)  -- UTF-8 character count

                    local start_idx = 1
                    local end_idx = len

                    -- Adjust start/end for first/last lines
                    if l == s_line then start_idx = math.min(s_col, len) end
                    if l == e_line then end_idx = math.min(e_col, len) end

                    if end_idx >= start_idx then
                      total = total + (end_idx - start_idx + 1)
                    end
                  end

                  return tostring(total)
                end

                return ""
              end
            '';
          }
          "progress"
        ];
        lualine_z = [
          "location"
          {
            __unkeyed-1.__raw = ''
              function()
                -- Early return when no search highlighting
                if vim.v.hlsearch == 0 then return "" end

                -- Get the last search count without recomputation
                local result = vim.fn.searchcount({ recompute = 1 })

                if not result or vim.tbl_isempty(result) then
                  return ""
                end

                local search_pat = vim.fn.getreg("/")
                if search_pat == "" then
                  return ""
                end

                -- Handle timeouts
                if result.incomplete == 1 then
                  return string.format("%s [?/??]", search_pat)
                end

                -- Handle maxcount exceeded
                if result.incomplete == 2 then
                  local cur = result.current
                  local total = result.total
                  local maxc = result.maxcount

                  if total > maxc and cur > maxc then
                    return string.format("%s [>%d/>%d]", search_pat, cur, total)
                  elseif total > maxc then
                    return string.format("%s [%d/>%d]", search_pat, cur, total)
                  end
                end

                -- Normal display
                return string.format("%s [%d/%d]", search_pat, result.current, result.total)
              end
            '';
          }
        ];
      };
    };
  };
}
