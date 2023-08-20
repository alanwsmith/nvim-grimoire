local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local prepend_file = function(file_path, line)
  local tmp_path = file_path .. ".tmp"
  local file = io.open(file_path, 'r')
  local t = {}
  table.insert(t, line)
  for line_to_add in file:lines() do
    if not has_value(t, line_to_add) then
      table.insert(t, line_to_add)
    end
  end
  file:close()
  local tmp = io.open(tmp_path, 'a')
  for _, new_line in ipairs(t) do
    tmp:write(new_line)
    tmp:write("\n")
  end
  tmp:close()
  os.rename(tmp_path, file_path)


  -- local tmp = io.open(tmp_path, 'a')
  -- tmp:write(line .. "\n")
  -- for line in file:lines() do
  --   tmp:write(line)
  --   tmp:write("\n")
  -- end
  -- file:close()
  -- tmp:close()
  -- os.remove(file_path)
  -- os.rename(tmp_path, file_path)
end

local run_search = function()
  pickers.new({
    sorting_strategy = "ascending",
    initial_mode = 'insert',
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = "top",
      height = 0.96,
      width = 0.96,
      preview_cutoff = 1
    },
  }, {
    prompt_title = "grimoire",
    finder = finders.new_job(
      function(prompt)
        return { '/Users/alan/.cargo/bin/grimoire_search', prompt }
      end,
      function(entry)
        return {
          value    = entry,
          display  = entry,
          filename = '/Users/alan/Grimoire/' .. entry,
          ordinal  = entry,
        }
      end
    ),
    previewer = conf.file_previewer({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- require('notify')(selection['display'])
        -- TODO: Limit and dedupe this history file
        prepend_file(
          "/Users/alan/.config/grimoire-mode/search-history.txt",
          selection['value']
        )
        vim.api.nvim_command('tabedit ' .. selection['filename'])
      end
      )
      return true
    end,
  }):find()
end

return require("telescope").register_extension {
  exports = {
    grimoire = run_search
  },
}
