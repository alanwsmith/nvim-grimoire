local pickers = require "telescope.pickers"
local finders = require "telescope.finders"

local run_search = function(opts)
  opts = opts or {}
  if next(opts) == nil then
    -- TODO: Figure out how to do a "not" check
  else
   require('notify')(opts)
  end

  pickers.new(opts, {
    prompt_title = "grimoire",
    finder = finders.new_table {
      results = { "red", "green", "blue" }
    },
  }):find()
end


-- local run_search = function(query_string)
--   local Job = require 'plenary.job'
--   local msg = require 'notify'
--   Job:new({
--     command = 'security',
--     args = { 'find-generic-password', '-w', '-a', 'alan', '-s', 'alan--meilisearch--scratchpad--test-key' },
--     on_exit = function(job, return_val)
--       --run_query(job:result(), query_string)
--       -- msg(job:result())
--       -- msg(query_string)
--     end,
--   }):start()
-- end
--
--
return require("telescope").register_extension {
  exports = {
    grimoire = run_search
  },
}
