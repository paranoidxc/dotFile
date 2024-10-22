local Config = require("config")

-- 原始版本 有问题
require("events.right-status").setup()
require("events.tab-title-round").setup()
require("events.new-tab-button").setup()

local session_manager = require("session.mgr")

-- local keys = require("config.keys")
-- local M = {}
-- keys.set(M)

local wezterm = require("wezterm")

wezterm.on("save_session", function(window)
  session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
  session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
  session_manager.restore_state(window)
end)

return Config:init()
  :append(require("config.appearance"))
  :append(require("config.bindings"))
  :append(require("events-tab.tab"))
  :append(require("config.domains"))
  :append(require("config.fonts"))
  :append(require("config.general"))
  :append(require("config.launch")).options
