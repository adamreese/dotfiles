local log = hs.logger.new('[readline]', 'debug')

local readlineKeys = hs.hotkey.modal.new()
local readlineKeyBindings = {
  { { 'ctrl' }, 'w', { 'alt' }, 'delete' },
  { { 'ctrl' }, 'y', { 'cmd' }, 'v' },

  { { 'ctrl' }, 'u', { 'cmd' }, 'delete' },

  { { 'ctrl' }, 'v', {},        'pagedown' },
  { { 'alt' },  'v', {},        'pageup' },

  { { 'ctrl' }, 'a', { 'cmd' }, 'left' },
  { { 'ctrl' }, 'e', { 'cmd' }, 'right' },
  { { 'alt' },  'f', { 'alt' }, 'right' },
  { { 'alt' },  'b', { 'alt' }, 'left' },
  { { 'ctrl' }, 'f', {},        'right' },
  { { 'ctrl' }, 'b', {},        'left' },
  { { 'ctrl' }, 'n', {},        'down' },
  { { 'ctrl' }, 'p', {},        'up' },

  { { 'ctrl' }, 'g', {},        'escape' },
}

local ignoredApps = {
  'Terminal',
  'iTerm2',
  'kitty',
}

for _, binding in ipairs(readlineKeyBindings) do
  local stroke = function()
    log.df('sending keystroke: %s + %q', hs.inspect(binding[1]), binding[4])
    hs.eventtap.keyStroke(binding[3], binding[4], 0)
  end
  readlineKeys:bind(binding[1], binding[2], stroke, nil, stroke)
end

local function applicationWatcher(appName, eventType)
  if eventType == hs.application.watcher.activated then
    if hs.fnutils.contains(ignoredApps, appName) then
      readlineKeys:exit()
    else
      readlineKeys:enter()
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
