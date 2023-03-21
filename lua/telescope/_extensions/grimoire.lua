local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local run_search = function()
	pickers.new({}, {
		prompt_title = "grimoire",
		finder = finders.new_job(

			function(prompt)
				return { '/Users/alan/.cargo/bin/grimoire_search', prompt }
			end,

 	function(entry)
 		return {
 			value    = entry,
 			-- value    = entry,
 			display  = 't ' .. entry,
 			-- display  = entry,
 			-- This filename didn't work
			filename = '/Users/alan/Desktop/' .. entry,
 			ordinal  = entry,
 		}
 	end
			 -- '_' ,

			 -- '/Users/alan/Desktop'


		),
	}):find()
end

return require("telescope").register_extension {
	exports = {
		grimoire = run_search
	},
}
--
--
-- {
-- 	entry_maker = function(entry)
-- 		return {
-- 			value    = 'z' .. entry[1],
-- 			-- value    = entry,
-- 			display  = 'x' .. entry[1],
-- 			-- display  = entry,
-- 			-- This filename didn't work
-- 			filename = '/Users/alan/Desktop/' .. entry[1],
-- 			ordinal  = entry,
-- 		}
-- 	end
-- }
