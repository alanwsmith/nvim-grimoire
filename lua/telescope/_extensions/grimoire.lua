local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"


local prepend_file = function(file_path, line)
  local tmp_path = file_path .. ".tmp"
  local file = io.open(file_path, 'r')
  local tmp = io.open(tmp_path, 'a')
  tmp:write(line .. "\n")
  for line in file:lines() do
    tmp:write(line)
    tmp:write("\n")
  end
  file:close()
  tmp:close()
  os.remove(file_path)
  os.rename(tmp_path, file_path)
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
        prepend_file(
          "/Users/alan/.config/grimoire-mode/search-history.txt",
          selection['value']
        )
        vim.api.nvim_command('edit ' .. selection['filename'])
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
