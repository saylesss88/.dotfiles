local wezterm = require('wezterm')
local launch_menu = require('config.launch').launch_menu
local domains = require('config.domains')
local Cells = require('utils.cells')

local nf = wezterm.nerdfonts
local act = wezterm.action
local attr = Cells.attr

local M = {}

local colors = {
   label_text = { fg = '#CDD6F4' },
   icon_unix = { fg = '#CBA6F7' },
}

local cells = Cells:new()
   :add_segment('icon_unix', ' ' .. nf.dev_gnu .. ' ', colors.icon_unix)
   :add_segment('label_text', '', colors.label_text, attr(attr.intensity('Bold')))

local function build_choices()
   local choices = {}
   local choices_data = {}
   local idx = 1

   for _, v in ipairs(domains.unix_domains) do
      cells:update_segment_text('label_text', v.name)
      table.insert(choices, {
         id = tostring(idx),
         label = wezterm.format(cells:render({ 'icon_unix', 'label_text' })),
      })
      table.insert(choices_data, {
         domain = { DomainName = v.name },
      })
      idx = idx + 1
   end

   return choices, choices_data
end

local choices, choices_data = build_choices()

M.setup = function()
   wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
      if default_action and button == 'Left' then
         window:perform_action(default_action, pane)
      end

      if default_action and button == 'Right' then
         window:perform_action(
            act.InputSelector({
               title = 'InputSelector: Launch Menu',
               choices = choices,
               fuzzy = true,
               fuzzy_description = nf.md_rocket .. ' Select a lauch item: ',
               action = wezterm.action_callback(function(_window, _pane, id, label)
                  if not id and not label then
                     return
                  else
                     wezterm.log_info('you selected ', id, label)
                     wezterm.log_info(choices_data[tonumber(id)])
                     window:perform_action(
                        act.SpawnCommandInNewTab(choices_data[tonumber(id)]),
                        pane
                     )
                  end
               end),
            }),
            pane
         )
      end
      return false
   end)
end

return M
