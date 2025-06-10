local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Everforest Dark (Hard)'
config.colors = {
  tab_bar = {
    background = '#1e2326',
    active_tab = {
      bg_color = '#414B50',
      fg_color = '#d3c6aa',
      intensity = 'Bold',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = '#2e383c',
      fg_color = '#7a8478',
    },
    inactive_tab_hover = {
      bg_color = '#2e383c',
      fg_color = '#7a8478',
    },
    new_tab = {
      bg_color = '#1e2326',
      fg_color = '#7a8478',
    },
    new_tab_hover = {
      bg_color = '#414B50',
      fg_color = '#d3c6aa',
      intensity = 'Bold',
    },
  },
}
config.font = wezterm.font 'BerkeleyMono Nerd Font'

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Leader key
config.leader = { key = 'g', mods = 'CTRL', timeout_milliseconds = 1000 }

-- Direct key mappings (outside key tables)
config.keys = {
  -- Tab switching
  { key = 'j', mods = 'ALT',    action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'y', mods = 'ALT',    action = wezterm.action.ActivateTabRelative(1) },

  -- -- Pane switching
  { key = 'm', mods = 'ALT',    action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'i', mods = 'ALT',    action = wezterm.action.ActivatePaneDirection('Right') },
  { key = 'n', mods = 'ALT',    action = wezterm.action.ActivatePaneDirection('Down') },
  { key = 'e', mods = 'ALT',    action = wezterm.action.ActivatePaneDirection('Up') },

  -- -- Direct tab jumps
  { key = 'h', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
  { key = ',', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
  { key = '.', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
  { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
  { key = 'e', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },
  { key = 'i', mods = 'LEADER', action = wezterm.action.ActivateTab(5) },

  -- Key tables
  { key = 't', mods = 'LEADER', action = wezterm.action.ActivateKeyTable { name = 'TAB', one_shot = true } },
  { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateKeyTable { name = 'PANE', one_shot = true } },
  { key = 'c', mods = 'LEADER', action = wezterm.action.ActivateCopyMode },
  {
    key = '^',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'o',
    mods = 'LEADER',
    action = wezterm.action.QuickSelectArgs {
      -- label = 'open blah',
      -- skip_action_on_paste = true, -- will want to enable this once it's
      -- available...
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    },
  },
}

-- Key tables
config.key_tables = {
  TAB = {
    { key = 'n',      action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    {
      key = 'r',
      action = wezterm.action.PromptInputLine {
        description = 'Rename Tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }
    },
    { key = 'x',      action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = 'g',      action = wezterm.action.ShowTabNavigator },
    { key = 'f',      action = wezterm.action.MoveTabRelative(1) },
    { key = 'b',      action = wezterm.action.MoveTabRelative(-1) },
    { key = 'Escape', action = wezterm.action.PopKeyTable },
  },

  PANE = {
    { key = 'n',      action = wezterm.action.SplitHorizontal },
    { key = 'x',      action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = 'Escape', action = wezterm.action.PopKeyTable },
  },
}

wezterm.on('update-status', function(window, pane)
  local current_mode = window:active_key_table() or ""
  if current_mode == 'copy_mode' then
    current_mode = "COPY"
  end
  window:set_right_status(current_mode)
end)

config.quick_select_patterns = {
  [[(?:[.\w\-@~]+)?(?:\/+[.\w\-@]+)+(?:[:]\d+)?]],
}

config.use_ime = false

return config
