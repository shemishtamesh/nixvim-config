require("silverbullet").setup({
  default_space = "personal",
  spaces = {
    personal = {
      url = "https://shenixtamesh.local:8443/",
      runtime = { enabled = true },
    },
  },
})

-- toggles a render of `${lua expression}`s
_G.SilverBulletPreview = (function()
  -- captures buffers state before rendering for restoring
  local rendered = {}

  -- scans for `${...}` directives, making sure `}` is in the correct depth to actually close.
  -- `\` escapes the next char
  local function scan(text)
    local directives, i, n = {}, 1, #text
    while i < n do
      if text:sub(i, i) == "\\" then
        i = i + 2
      elseif text:sub(i, i + 1) == "${" then
        local depth, j = 1, i + 2
        while j <= n and depth > 0 do
          local c = text:sub(j, j)
          if c == "{" then
            depth = depth + 1
          elseif c == "}" then
            depth = depth - 1
          end
          j = j + 1
        end
        if depth == 0 then
          table.insert(directives, { start = i, stop = j - 1, expr = text:sub(i + 2, j - 2) })
          i = j
        else
          i = i + 1
        end
      else
        i = i + 1
      end
    end
    return directives
  end

  local function unescape(s)
    return (s:gsub("\\(.)", "%1"))
  end

  local function is_string_array(t)
    local n = 0
    for k, v in pairs(t) do
      n = n + 1
      if type(k) ~= "number" or k ~= math.floor(k) or k < 1 or type(v) ~= "string" then
        return false
      end
    end
    return n > 0 and n == #t
  end

  local function format_value(ok, value)
    if not ok or type(value) ~= "table" then
      return tostring(value)
    end
    if is_string_array(value) then
      return table.concat(value)
    end
    return vim.inspect(value)
  end

  local function eval(space_name, expression)
    local config = require("silverbullet.config")
    local transport = require("silverbullet.transport.curl")
    local space = config.space(space_name)
    if not space.runtime.enabled then
      return nil, "Runtime API is disabled for this space"
    end
    local response, transport_err = transport.request(space, {
      method = "POST",
      url = space.url .. "/.runtime/lua",
      headers = { ["Content-Type"] = "text/plain; charset=utf-8" },
      body = expression,
    })
    if not response then
      return nil, transport_err
    end
    local decode_ok, decoded = pcall(vim.json.decode, response.body)
    local function body_error()
      if decode_ok and type(decoded) == "table" and decoded.error then
        return decoded.code and (decoded.error .. " (" .. decoded.code .. ")") or decoded.error
      end
      return response.body ~= "" and response.body or ("HTTP " .. response.status)
    end
    if response.status < 200 or response.status >= 300 then
      return nil, body_error()
    end
    if not decode_ok then
      return nil, body_error()
    end
    if type(decoded) ~= "table" then
      return decoded, nil
    end
    if decoded.error then
      return nil, decoded.code and (decoded.error .. " (" .. decoded.code .. ")") or decoded.error
    end
    local result = decoded.result
    if result == vim.NIL then
      return nil, nil
    end
    return result, nil
  end

  local function eval_all(space, directives)
    local results = {}
    for idx, directive in ipairs(directives) do
      if vim.trim(directive.expr) == "" then
        results[idx] = { ok = true, text = "" }
      else
        local value, err = eval(space, directive.expr)
        local ok = err == nil
        local shown
        if ok then
          shown = value
        else
          shown = err
        end
        results[idx] = { ok = ok, text = format_value(ok, shown) }
      end
    end
    return results
  end

  local function enter_render_mode(buf, buffer_state)
    local raw = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local text = table.concat(raw, "\n")
    local directives = scan(text)
    local results = eval_all(buffer_state.space, directives)

    local out, cursor = {}, 1
    for idx, directive in ipairs(directives) do
      table.insert(out, unescape(text:sub(cursor, directive.start - 1)))
      table.insert(out, results[idx].text)
      cursor = directive.stop + 1
    end
    table.insert(out, unescape(text:sub(cursor)))

    rendered[buf] = {
      lines = raw,
      modifiable = vim.bo[buf].modifiable,
      readonly = vim.bo[buf].readonly,
      modified = vim.bo[buf].modified,
    }
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(table.concat(out), "\n", { plain = true }))
    vim.bo[buf].readonly = true
    vim.bo[buf].modifiable = false
    vim.bo[buf].modified = false
  end

  local function exit_render_mode(buf)
    local saved = rendered[buf]
    rendered[buf] = nil
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, saved.lines)
    vim.bo[buf].readonly = saved.readonly
    vim.bo[buf].modifiable = saved.modifiable
    vim.bo[buf].modified = saved.modified
  end

  local function toggle(buf)
    buf = buf or vim.api.nvim_get_current_buf()
    if rendered[buf] then
      exit_render_mode(buf)
      return
    end
    local buffer_state = require("silverbullet.state").get(buf)
    if not buffer_state or not buffer_state.space then
      require("silverbullet.log").error("current buffer is not a SilverBullet page")
      return
    end
    enter_render_mode(buf, buffer_state)
  end

  local function reset(buf)
    rendered[buf] = nil
  end

  local function is_active(buf)
    return rendered[buf] ~= nil
  end

  return { toggle = toggle, reset = reset, is_active = is_active }
end)()

local silverbullet_preview_group = vim.api.nvim_create_augroup("SilverBulletPreview", { clear = true })

-- reload might replace buffer content out from under a pending
-- render-mode snapshot so drop it rather than risk restoring stale text.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = silverbullet_preview_group,
  pattern = "silverbullet://*",
  callback = function(args)
    SilverBulletPreview.reset(args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
  group = silverbullet_preview_group,
  pattern = "silverbullet://*",
  callback = function(args)
    SilverBulletPreview.reset(args.buf)
  end,
})

do
  local buffer = require("silverbullet.buffer")
  local reload = buffer.reload
  buffer.reload = function(buf, discard_changes)
    buf = buf or vim.api.nvim_get_current_buf()
    reload(buf, discard_changes)
    SilverBulletPreview.reset(buf)
  end
end

do
  local buffer = require("silverbullet.buffer")
  local write = buffer.write
  buffer.write = function(buf, opts)
    buf = buf or vim.api.nvim_get_current_buf()
    if SilverBulletPreview.is_active(buf) then
      require("silverbullet.log").error("cannot write while previewing rendered ${...} directives; toggle preview off first")
      return false
    end
    return write(buf, opts)
  end
end
