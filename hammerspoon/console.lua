require('hs.ipc')

local function unique_history(raw)
  local hashed, history = {}, {}
  for i = #raw, 1, -1 do
    local key = hs.hash.MD5(raw[i])
    if not hashed[key] then
      table.insert(history, 1, raw[i])
      hashed[key] = true
    end
  end
  return history
end

local save_label = 'console_history'
local max_length = 100

local function save_history()
  local hist, save = hs.console.getHistory(), {}
  if #hist > max_length then
    table.move(hist, #hist - max_length, #hist, 1, save)
  else
    save = hist
  end
  -- save only the unique lines
  hs.settings.set(save_label, unique_history(save))
end

-- persist console history across launches
hs.shutdownCallback = function()
  save_history()
end
hs.console.setHistory(hs.settings.get(save_label) or {})

hs.console.toolbar(nil)

_G.windows = function()
  hs.fnutils.each(hs.window.allWindows(), function(win)
    print(hs.inspect({
      id      = win:id(),
      title   = win:title(),
      app     = win:application():name(),
      role    = win:role(),
      subrole = win:subrole(),
      frame   = win:frame(),
    }))
  end)
end

_G.screens = function()
  hs.fnutils.each(hs.screen.allScreens(), function(s)
    print(hs.inspect({
      id       = s:id(),
      position = s:position(),
      frame    = s:frame(),
      name     = s:name(),
    }))
  end)
end

_G.timestamp = function(date)
  date = date or hs.timer.secondsSinceEpoch()
  return os.date('%F %T' .. ((tostring(date):match('(%.%d+)$')) or ''), math.floor(date))
end
