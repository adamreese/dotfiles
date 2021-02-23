-- luacheck: globals hs spoon

local log = hs.logger.new('[init]', 'debug')

log.i('----------------------------------------')

-- command line interface
require('hs.ipc')
hs.ipc.cliInstall()

-- disable animations
hs.window.animationDuration = 0

-- lower logging level for hotkeys
hs.hotkey.setLogLevel('warning')

-- no toolbar
hs.console.toolbar(nil)

--------------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------------

local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

local focusKeys = {
  b      = 'com.brave.Browser',
  m      = 'com.apple.MobileSMS',
  s      = 'com.tinyspeck.slackmacgap',
  z      = 'us.zoom.xos',
  Return = 'com.googlecode.iterm2',
}

for key, id in pairs(focusKeys) do
  hs.hotkey.bind(hyper, key, hs.fnutils.partial(hs.application.launchOrFocusByBundleID, id))
end

-- use key strokes for paste
hs.hotkey.bind({'cmd', 'ctrl'}, 'V', function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- toggle dark mode
hs.hotkey.bind(hyper, 'D', function()
  hs.osascript.applescript('tell application "System Events" to tell appearance preferences to set dark mode to not dark mode')
end)

--------------------------------------------------------------------------------
-- Spoon Configuration
--------------------------------------------------------------------------------

hs.loadSpoon('SpoonInstall')
local Install = spoon.SpoonInstall

-- http://www.hammerspoon.org/Spoons/KSheet.html
Install:andUse('KSheet', {
    hotkeys = { toggle = {hyper, 'K'} }
})

-- http://www.hammerspoon.org/Spoons/WindowHalfsAndThirds.html
Install:andUse('WindowHalfsAndThirds', {
    hotkeys = {
      top_left     = { hyper, '1' },
      top_right    = { hyper, '2' },
      bottom_left  = { hyper, '3' },
      bottom_right = { hyper, '4' },
      max          = { hyper, '5' },
      max_toggle   = { hyper, 'f' },

      left_half    = { {'ctrl', 'cmd'}, 'Left' },
      right_half   = { {'ctrl', 'cmd'}, 'Right' },
      top_half     = { {'ctrl', 'cmd'}, 'Up' },
      bottom_half  = { {'ctrl', 'cmd'}, 'Down' },
      undo         = { {'ctrl', 'cmd'}, 'z' },
      center       = { {'ctrl', 'cmd'}, 'c' },
    }
  })

-- http://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
Install:andUse('WindowScreenLeftAndRight', {
    hotkeys = {
      screen_left = { hyper, 'Left' },
      screen_right= { hyper, 'Right' },
    }
  })

-- http://www.hammerspoon.org/Spoons/ReloadConfiguration.html
Install:andUse('ReloadConfiguration', {
  start   = true,
})

--------------------------------------------------------------------------------

hs.alert.show('Config loaded')

log.i('----------------------------------------')
log.i('Config loaded')
log.i('----------------------------------------')
