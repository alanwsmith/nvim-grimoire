local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local search_grimoire = function()
  pickers.new({}, {
    prompt_title = "grimoire",
    finder = finders.new_table {
      results = { "red", "green", "blue" }
    },
  }):find()
end

return require("telescope").register_extension {
  exports = {
    grimoire = search_grimoire
  },
}
