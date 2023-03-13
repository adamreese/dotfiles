require('hs.ipc')

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
