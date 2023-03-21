local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local Job = require 'plenary.job'

-- local make_url = function(query_string)
-- 	-- TODO: escape the query_string for urls
-- 	local url = 'http://127.0.0.1:7700/indexes/set-1/search?q=' .. query_string
-- 	return url
-- end
--
local run_search = function()
	-- local auth_string = ""
	-- local call_string =

	-- Job:new({
	-- 	command = 'security',
	-- 	args = { 'find-generic-password', '-w', '-a', 'alan', '-s', 'alan--meilisearch--scratchpad--test-key' },
	-- 	on_exit = function(job)
	-- 		auth_string = 'Authorization: Bearer ' .. job:result()[1]
	-- 	end
	-- }):sync()
	--
	pickers.new({}, {
		prompt_title = "grimoire",
		finder = finders.new_job(function(prompt)
			local auth_string = ""
			Job:new({
				command = 'security',
				args = { 'find-generic-password', '-w', '-a', 'alan', '-s',
					'alan--meilisearch--scratchpad--test-key' },
				on_exit = function(job)
					auth_string = job:result()[1]
				end
			}):sync()
			local cmd = 'curl -s -X GET "http://127.0.0.1:7700/indexes/set-1/search?q=fox" -H "Authorization: Bearer ' .. auth_string .. '"; echo ""'
			return { 'bash', '-c', cmd }
			-- return { 'bash', '/Users/alan/Desktop/msearch.bash' }
			-- return flatten { 'curl', 'http://www.example.com/' }
			-- return flatten { 'curl', '-s', '-X', 'GET', 'http://127.0.0.1:7700/indexes/set-1/search?q=fox', '-H', 'Authorization: Bearer cajun-viscus-chariot-lambskin-gobbet-distal-BESTRODE-A1' }

			-- return { 'curl', '-s', '-X',  'GET', '"http://127.0.0.1:7700/indexes/set-1/search?q=fox"', '-H', '"Authorization: Bearer cajun-viscus-chariot-lambskin-gobbet-distal-BESTRODE-A1"' }
			--return { 'curl', '-s', '-X',  'GET', '"http://127.0.0.1:7700/indexes/set-1/search?q=fox"', '-H', '"Authorization: Bearer cajun-viscus-chariot-lambskin-gobbet-distal-BESTRODE-A1"' }

			--local args =
			-- return { 'curl', 'https://www.example.com?asdf'}
			-- return {'curl', '-s', '-X', 'GET', make_url(prompt) }
			-- make_url(prompt)
			--local url = 'http://127.0.0.1:7700/indexes/set-1/search?q=j' .. prompt
			--return { 'curl', '-s', '-X', 'GET', 'http://127.0.0.1:7700/indexes/set-1/search', '-H', auth_string}
			--return { 'curl', '-s', '-X', 'GET', 'https://www.example.com/', '>&2'}
			--return { 'curl', '-s', '-X', 'GET', 'https://www.example.com/', '>&2'}
			-- return {
			-- 	'curl',
			-- 	'-s', '-X', 'GET', make_url(prompt), '-H', auth_string
			-- }
			--
		end
		)
	}):find()
end

return require("telescope").register_extension {
	exports = {
		grimoire = run_search
	},
}
