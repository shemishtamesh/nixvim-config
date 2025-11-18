{
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
        lualine_z = [
          "location"
          {
            __unkeyed-1 = {
              __raw = ''
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
                    return string.format(" /%s [?/??]", search_pat)
                  end

                  -- Handle maxcount exceeded
                  if result.incomplete == 2 then
                    local cur = result.current
                    local total = result.total
                    local maxc = result.maxcount

                    if total > maxc and cur > maxc then
                      return string.format(" /%s [>%d/>%d]", search_pat, cur, total)
                    elseif total > maxc then
                      return string.format(" /%s [%d/>%d]", search_pat, cur, total)
                    end
                  end

                  -- Normal display
                  return string.format(" /%s [%d/%d]", search_pat, result.current, result.total)
                end
              '';
            };
          }
        ];
      };
    };
  };
}
