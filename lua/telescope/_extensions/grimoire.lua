local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local Job = require 'plenary.job'

local msearch = function()
	-- local msg = require('notify')
	-- local window_list = vim.api.nvim_list_wins()
	-- for i = 1, #window_list do
	--    msg(vim.win_getid(window_list[i]))
	--end
	-- return vim.api.nvim_list_bufs()
	--  ?
	-- require('notify')(vim.api.nvim_list_wins())

	--
	--
	return { "a", "b", "c" }
end

local run_search = function()
	local auth_key = ""

	Job:new({
		-- command = 'date',
		 command = 'security',
		args = { 'find-generic-password', '-w', '-a', 'alan', '-s', 'test--example--key' },
		on_exit = function(job, return_val)
			-- msg('alfa')
			--run_query(job:result(), query_string)
			--return { "e", "q" }--
			--auth_key = job:result()
		        auth_key = job:result()[1]
			-- auth_key = 'asdfasdfasdf'
			print('asdfasdfasdfsdf')
			--require('notify')('asdf')
			-- require('notify')(job:result())
		end
	}):sync()

	pickers.new({}, {
		prompt_title = "grimoire",
		finder = finders.new_job(function(prompt)
			return { 'echo', auth_key }
		end
		)
		-- sorter = sorters.highlighter_only(opts),
		--   --results = { "red", "green", "blue" }
		-- results = msearch()
		-- finder = finders.new_table {
		-- 	--   --results = { "red", "green", "blue" }
		-- 	results = msearch()
		-- }
		-- finder = finders.new_oneshot_job({ 'date' }, opts)
		-- finder = finders.new_oneshot_job({ 'echo' }, opts)
	}):find()
end

return require("telescope").register_extension {
	exports = {
		grimoire = run_search
	},
}
