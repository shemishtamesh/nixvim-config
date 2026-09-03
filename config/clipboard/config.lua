-- OSC52 fallback for remote/restricted environments
local osc52 = require("vim.ui.clipboard.osc52")
local is_mac = vim.fn.has("mac") == 1
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

local split_lines = function(text)
  return vim.split(text:gsub("\r", ""):gsub("\n$", ""), "\n", { plain = true })
end

local native_copy = function(cmd)
  return function(lines)
    local payload = table.concat(lines, "\n")
    if #payload > 0 then payload = payload .. "\n" end
    local code = vim.fn.system(cmd, payload)
    if type(code) == "number" and code ~= 0 then
      error("native clipboard failed: " .. code)
    end
  end
end

local native_paste = function(cmd)
  return function()
    if is_mac then
      return vim.fn.systemlist(cmd)
    end
    if is_windows then
      return split_lines(vim.fn.system(cmd))
    end
    return split_lines(vim.fn.system(cmd .. " --no-newline"))
  end
end

local copy_wrap = function(native, oscfn)
  return function(lines)
    local ok = pcall(native, lines)
    if not ok then oscfn(lines) end
  end
end

local paste_wrap = function(native, oscfn)
  return function()
    local ok, res = pcall(native)
    if ok and res and #res > 0 then return res end
    return oscfn()
  end
end

local copy_cmd = is_mac and { "pbcopy" }
  or is_windows and { "clip.exe" }
  or { "wl-copy" }

local paste_cmd = is_mac and "pbpaste"
  or is_windows and "powershell.exe -NoProfile -Command Get-Clipboard -Raw"
  or "wl-paste"

vim.g.clipboard = {
  name = "native+OSC52",
  copy = {
    ["+"] = copy_wrap(native_copy(copy_cmd), osc52.copy("+")),
    ["*"] = copy_wrap(native_copy(copy_cmd), osc52.copy("*")),
  },
  paste = {
    ["+"] = paste_wrap(native_paste(paste_cmd), osc52.paste("+")),
    ["*"] = paste_wrap(native_paste(paste_cmd), osc52.paste("*")),
  },
  cache_enabled = 0,
}

-- copy file location helpers
function CopyLocation(relative)
  local file = relative and vim.fn.expand("%:~:.") or vim.fn.expand("%:p")
  if file == "" then file = "[No Name]" end
  local loc = string.format("%s:%d:%d", file, vim.fn.line("."), vim.fn.col("."))
  vim.fn.setreg("+", loc)
  vim.fn.setreg("*", loc)
  vim.notify("Copied: " .. loc)
end

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
