------------------------------------------------------------------------------------------
-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614 --
------------------------------------------------------------------------------------------

local wezterm = require("wezterm")
local Cells = require("utils.cells")
local utils = require("utils.utils")

local nf = wezterm.nerdfonts
local attr = Cells.attr

local GLYPH_SCIRCLE_LEFT = nf.ple_left_half_circle_thick --[[  ]]
local GLYPH_SCIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[  ]]
local GLYPH_CIRCLE = nf.fa_circle --[[  ]]
local GLYPH_ADMIN = nf.md_shield_half_full --[[ 󰞀 ]]
local GLYPH_LINUX = nf.cod_terminal_linux --[[  ]]
local GLYPH_DEBUG = nf.fa_bug --[[  ]]
-- local GLYPH_SEARCH = nf.fa_search --[[  ]]
local GLYPH_SEARCH = "🔭"

local TITLE_INSET = {
  DEFAULT = 6,
  ICON = 8,
}

local M = {}

local RENDER_VARIANTS = {
  { "scircle_left", "title", "padding", "scircle_right" },
  { "scircle_left", "title", "unseen_output", "padding", "scircle_right" },
  { "scircle_left", "admin", "title", "padding", "scircle_right" },
  { "scircle_left", "admin", "title", "unseen_output", "padding", "scircle_right" },
  { "scircle_left", "wsl", "title", "padding", "scircle_right" },
  { "scircle_left", "wsl", "title", "unseen_output", "padding", "scircle_right" },
}

local CONFIG = {
  padding = 1,
  use_icons = true,
  colorize_icons = false,
}

--- @type table<number, string>
local tab_icons = {}

local function ansi(c)
  return { AnsiColor = c }
end

local function css(c)
  return { Color = c }
end

local icon_variants = utils.map({
  { "cod_telescope", ansi("Teal") },
  { "dev_coda", css("#3A5F0B") },
  "dev_onedrive",
  "fa_bath",
  "fa_bug",
  "fa_eye",
  "fa_flask",
  "fa_fort_awesome",
  { "fa_magic", css("#7fcedc") },
  { "fa_magnet", ansi("Grey") },
  "fa_microchip",
  "fa_plane",
  { "fa_snowflake_o", css("#002553") },
  "fa_subway",
  { "fa_usd", css("#118C4F") },
  { "fae_apple_fruit", css("#4CBB17") },
  { "fae_biohazard", css("#EADF0C") },
  { "fae_carot", css("#F88017") },
  { "fae_cherry", ansi("Red") },
  { "fae_crown", css("#ffd700") },
  { "fae_comet", css("#61667D") },
  "fae_dna",
  { "fae_donut", css("#FAAFBE") },
  { "fae_ice_cream", css("#FDB6D0") },
  "fae_popcorn",
  "fae_poison",
  { "fae_planet", css("#A49B72") },
  { "fae_ruby", css("#E0115F") },
  { "fae_tooth", ansi("White") },
  { "linux_ferris", css("#F13408") },
  { "mdi_basketball", css("#F88158") },
  { "mdi_clover", css("#3EA055") },
  { "mdi_currency_eth", css("#7095F7") },
  { "mdi_ghost", ansi("White") },
}, function(i)
  if type(i) == "string" then
    return wezterm.nerdfonts[i]
  end

  if type(i) == "table" then
    if CONFIG.use_icon_colors then
      return wezterm.format({
        { Foreground = i[2] },
        { Text = wezterm.nerdfonts[i[1]] },
      })
    else
      return wezterm.nerdfonts[i[1]]
    end
  end

  error("unexpected type")
end)

---@type table<string, Cells.SegmentColors>
-- stylua: ignore
local colors = {
   text_default          = { bg = '#45475A', fg = '#1C1B19' },
   text_hover            = { bg = '#587D8C', fg = '#1C1B19' },
   text_active           = { bg = '#7FB4CA', fg = '#11111B' },

   unseen_output_default = { bg = '#45475A', fg = '#FFA066' },
   unseen_output_hover   = { bg = '#587D8C', fg = '#FFA066' },
   unseen_output_active  = { bg = '#7FB4CA', fg = '#FFA066' },

   scircle_default       = { bg = 'rgba(0, 0, 0, 0.4)', fg = '#45475A' },
   scircle_hover         = { bg = 'rgba(0, 0, 0, 0.4)', fg = '#587D8C' },
   scircle_active        = { bg = 'rgba(0, 0, 0, 0.4)', fg = '#7FB4CA' },
}

---@param proc string
local function clean_process_name(proc)
  local a = string.gsub(proc, "(.*[/\\])(.*)", "%2")
  return a:gsub("%.exe$", "")
end

---@param process_name string
---@param base_title string
---@param max_width number
---@param inset number
local function create_title(process_name, base_title, max_width, inset)
  local title

  if process_name:len() > 0 then
    title = process_name .. " ~ " .. base_title
  else
    title = base_title
  end

  if base_title == "Debug" then
    title = GLYPH_DEBUG .. " DEBUG"
    inset = inset - 2
  end

  if base_title:match("^InputSelector:") ~= nil then
    title = base_title:gsub("InputSelector:", GLYPH_SEARCH)
    inset = inset - 2
  end

  if title:len() > max_width - inset then
    local diff = title:len() - max_width + inset
    title = title:sub(1, title:len() - diff)
  else
    local padding = max_width - title:len() - inset
    title = title .. string.rep(" ", padding)
  end

  return title
end

---@class Tab
---@field title string
---@field cells Cells
---@field title_locked boolean
---@field is_wsl boolean
---@field is_admin boolean
---@field unseen_output boolean
---@field is_active boolean
local Tab = {}
Tab.__index = Tab

function Tab:new()
  local tab = {
    title = "",
    cells = Cells:new(),
    title_locked = false,
    is_wsl = false,
    is_admin = false,
    unseen_output = false,
  }
  return setmetatable(tab, self)
end

---@param pane any WezTerm https://wezfurlong.org/wezterm/config/lua/pane/index.html
function Tab:set_info(tab_idx, pane, max_width)
  local process_name = clean_process_name(pane.foreground_process_name)
  self.is_wsl = process_name:match("^wsl") ~= nil
  self.is_admin = (pane.title:match("^Administrator: ") or pane.title:match("(Admin)")) ~= nil
  self.unseen_output = pane.has_unseen_output

  if self.title_locked then
    return
  end
  local inset = (self.is_admin or self.is_wsl) and TITLE_INSET.ICON or TITLE_INSET.DEFAULT
  if self.unseen_output then
    inset = inset + 2
  end

  local id = tab_idx
  if tab_icons[id] == nil then
    tab_icons[id] = icon_variants[math.random(#icon_variants)]
  end

  local icon = tab_icons[id]

  -- process_name = icon .. " " .. tab_idx .. " " .. process_name
  -- process_name = icon .. " " .. process_name
  -- self.title = icon .. " " .. tab_idx .. " " .. create_title(process_name, pane.title, max_width, inset)
  self.title = icon .. " " .. create_title(tab_idx .. " " .. process_name, pane.title, max_width, inset)
end

function Tab:set_cells()
  self.cells
    :add_segment("scircle_left", GLYPH_SCIRCLE_LEFT)
    :add_segment("admin", " " .. GLYPH_ADMIN)
    :add_segment("wsl", " " .. GLYPH_LINUX)
    :add_segment("title", " ", nil, attr(attr.intensity("Bold")))
    :add_segment("unseen_output", " " .. GLYPH_CIRCLE)
    :add_segment("padding", " ")
    :add_segment("scircle_right", GLYPH_SCIRCLE_RIGHT)
end

---@param title string
function Tab:update_and_lock_title(title)
  self.title = title
  self.title_locked = true
end

---@param is_active boolean
---@param hover boolean
function Tab:update_cells(is_active, hover)
  local tab_state = "default"
  if is_active then
    tab_state = "active"
  elseif hover then
    tab_state = "hover"
  end

  self.cells:update_segment_text("title", " " .. self.title)
  self.cells
    :update_segment_colors("scircle_left", colors["scircle_" .. tab_state])
    :update_segment_colors("admin", colors["text_" .. tab_state])
    :update_segment_colors("wsl", colors["text_" .. tab_state])
    :update_segment_colors("title", colors["text_" .. tab_state])
    :update_segment_colors("unseen_output", colors["unseen_output_" .. tab_state])
    :update_segment_colors("padding", colors["text_" .. tab_state])
    :update_segment_colors("scircle_right", colors["scircle_" .. tab_state])
end

---@return FormatItem[] (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)
function Tab:render()
  local variant_idx = self.is_admin and 3 or 1
  if self.is_wsl then
    variant_idx = 5
  end

  if self.unseen_output then
    variant_idx = variant_idx + 1
  end
  return self.cells:render(RENDER_VARIANTS[variant_idx])
end

---@type Tab[]
local tab_list = {}

M.setup = function()
  local enable_tab_bar = true

  -- CUSTOM EVENT
  -- Event listener to manually update the tab name
  -- Tab name will remain locked until the `reset-tab-title` is triggered
  wezterm.on("tabs.manual-update-tab-title", function(window, pane)
    window:perform_action(
      wezterm.action.PromptInputLine({
        description = wezterm.format({
          { Foreground = { Color = "#FFFFFF" } },
          { Attribute = { Intensity = "Bold" } },
          { Text = "Enter new name for tab" },
        }),
        action = wezterm.action_callback(function(_window, _pane, line)
          if line ~= nil then
            local tab = window:active_tab()
            local id = tab:tab_id()
            tab_list[id]:update_and_lock_title(line)
          end
        end),
      }),
      pane
    )
  end)

  -- CUSTOM EVENT
  -- Event listener to unlock manually set tab name
  wezterm.on("tabs.reset-tab-title", function(window, _pane)
    local tab = window:active_tab()
    local id = tab:tab_id()
    tab_list[id].title_locked = false
  end)

  -- CUSTOM EVENT
  -- Event listener to manually update the tab name
  wezterm.on("tabs.toggle-tab-bar", function(window, _pane)
    enable_tab_bar = not enable_tab_bar
    window:set_config_overrides({ enable_tab_bar = enable_tab_bar })
  end)

  -- BUILTIN EVENT
  wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, max_width)
    local tab_idx = tab.tab_index + 1
    if not tab_list[tab.tab_id] then
      tab_list[tab.tab_id] = Tab:new()
      tab_list[tab.tab_id]:set_info(tab_idx, tab.active_pane, max_width)
      tab_list[tab.tab_id]:set_cells()
      return tab_list[tab.tab_id]:render()
    end

    tab_list[tab.tab_id]:set_info(tab_idx, tab.active_pane, max_width)
    tab_list[tab.tab_id]:update_cells(tab.is_active, hover)
    return tab_list[tab.tab_id]:render()
  end)
end

return M
