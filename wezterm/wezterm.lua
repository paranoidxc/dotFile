local Config = require("config")

-- 原始版本 有问题
-- require("events.right-status").setup()
-- require("events.tab-title").setup()
-- require("events.new-tab-button").setup()
--

return Config
  :init()
  :append(require("config.appearance"))
  -- :append(require("config.bindings"))
  :append(require("events-tab.tab"))
  :append(require("config.domains"))
  :append(require("config.fonts"))
  :append(require("config.general"))
  :append(require("config.launch"))
  .options
