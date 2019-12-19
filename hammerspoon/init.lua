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
--
-- Note: macOS custom bindings
--     hyper + D   Toggle Do Not Disturb
--     hyper + N   Toggle Notification Center
--

local hyper = {'cmd', 'alt', 'ctrl'}

hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

local focusKeys = {
  b      = 'com.google.chrome',
  m      = 'com.apple.iChat',
  s      = 'com.tinyspeck.slackmacgap',
  z      = 'us.zoom.xos',
  Return = 'com.googlecode.iterm2',
}

for key, id in pairs(focusKeys) do
  hs.hotkey.bind(hyper, key, hs.fnutils.partial(hs.application.launchOrFocusByBundleID, id))
end

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
Install:andUse("WindowHalfsAndThirds", {
    hotkeys = {
      left_half    = { {"ctrl", "cmd"}, "Left" },
      right_half   = { {"ctrl", "cmd"}, "Right" },
      top_half     = { {"ctrl", "cmd"}, "Up" },
      bottom_half  = { {"ctrl", "cmd"}, "Down" },

      top_left     = { hyper, "1" },
      top_right    = { hyper, "2" },
      bottom_left  = { hyper, "3" },
      bottom_right = { hyper, "4" },
      max_toggle   = { hyper, "f" },
      max          = { hyper, "5" },

      third_left   = { {"ctrl", "alt"}, "Left" },
      third_right  = { {"ctrl", "alt"}, "Right" },
      third_up     = { {"ctrl", "alt"}, "Up" },
      third_down   = { {"ctrl", "alt"}, "Down" },


      undo         = { {"alt", "cmd"}, "z" },
      center       = { {"alt", "cmd"}, "c" },
      larger       = { {"alt", "cmd", "shift"}, "Right" },
      smaller      = { {"alt", "cmd", "shift"}, "Left" },
    }
  })

-- http://www.hammerspoon.org/Spoons/WindowScreenLeftAndRight.html
Install:andUse("WindowScreenLeftAndRight", {
    hotkeys = {
      screen_left = { hyper, "Left" },
      screen_right= { hyper, "Right" },
    }
  })

-- http://www.hammerspoon.org/Spoons/ReloadConfiguration.html
Install:andUse("ReloadConfiguration", {
  start   = true,
})

--------------------------------------------------------------------------------

hs.alert.show('Config loaded')

log.i('----------------------------------------')
log.i('Config loaded')
log.i('----------------------------------------')
