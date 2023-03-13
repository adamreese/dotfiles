-- luacheck: globals hs spoon

local log = hs.logger.new('[init]', 'debug')

log.i('----------------------------------------')

-- disable animations
hs.window.animationDuration = 0

-- lower logging level for hotkeys
hs.hotkey.setLogLevel('warning')

-- console
hs.console.toolbar(nil)
hs.console.alpha(1)
_G.i = hs.inspect

--------------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------------

local hyper = { 'cmd', 'alt', 'ctrl', 'shift' }

hs.hotkey.bind(hyper, 'c', function()
  hs.toggleConsole()
  local win = hs.window.frontmostWindow()
  if win then win:raise():focus() end
end)

local focusKeys = {
  b      = 'com.brave.Browser',
  m      = 'com.apple.MobileSMS',
  s      = 'com.tinyspeck.slackmacgap',
  z      = 'us.zoom.xos',
  d      = 'com.hnc.Discord',
  -- Return = 'com.googlecode.iterm2',
  Return = 'net.kovidgoyal.kitty',
}

for key, id in pairs(focusKeys) do
  hs.hotkey.bind(hyper, key, hs.fnutils.partial(hs.application.launchOrFocusByBundleID, id))
end

-- use key strokes for paste
hs.hotkey.bind({ 'cmd', 'ctrl' }, 'V', function()
  log.df('force paste len: %d', string.len(hs.pasteboard.getContents()))
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- toggle dark mode
hs.hotkey.bind(hyper, 'D', function()
  log.i('setting dark mode')
  hs.osascript.applescript(
    'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode')
end)

--------------------------------------------------------------------------------
-- Spoon Configuration
--------------------------------------------------------------------------------

hs.loadSpoon('SpoonInstall')
local Install = spoon.SpoonInstall

-- http://www.hammerspoon.org/Spoons/WindowHalfsAndThirds.html
Install:andUse('WindowHalfsAndThirds', {
  hotkeys = {
    top_left     = { hyper, '1' },
    top_right    = { hyper, '2' },
    bottom_left  = { hyper, '3' },
    bottom_right = { hyper, '4' },
    max          = { hyper, '5' },
    max_toggle   = { hyper, 'f' },

    left_half    = { { 'ctrl', 'cmd' }, 'Left' },
    right_half   = { { 'ctrl', 'cmd' }, 'Right' },
    top_half     = { { 'ctrl', 'cmd' }, 'Up' },
    bottom_half  = { { 'ctrl', 'cmd' }, 'Down' },
    undo         = { { 'ctrl', 'cmd' }, 'z' },
    center       = { { 'ctrl', 'cmd' }, 'c' },
  }
})

-- http://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
Install:andUse('WindowScreenLeftAndRight', {
  config = {
    animationDuration = 0
  },
  hotkeys = 'default',
})

-- http://www.hammerspoon.org/Spoons/ReloadConfiguration.html
Install:andUse('ReloadConfiguration', {
  start = true,
})

-- http://www.hammerspoon.org/Spoons/Caffeine.html
Install:andUse('Caffeine', {
  hotkeys = {
    toggle = { hyper, 'a' }
  },
  start = true
})

pcall(dofile, hs.configdir .. '/local.lua')

--------------------------------------------------------------------------------

hs.alert.show('Config loaded')

log.i('----------------------------------------')
log.i('Config loaded')
log.i('----------------------------------------')
