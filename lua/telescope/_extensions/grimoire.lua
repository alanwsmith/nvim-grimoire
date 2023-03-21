local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local run_search = function()
	pickers.new({
		layout_strategy = 'vertical',
		layout_config = {
			prompt_position = "top",
			height = 0.55
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
					filename = '/Users/alan/Desktop/' .. entry,
					ordinal  = entry,
				}
			end
		),
	}):find()
end

return require("telescope").register_extension {
	exports = {
		grimoire = run_search
	},
}
