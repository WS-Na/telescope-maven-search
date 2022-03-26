local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local deps = function(opts)
  return pickers.new(opts, {
    prompt_title = 'Search Maven Central',
    finder = finders.new_table {
      results = vim.fn.py3eval(
        string.format("mvnrepository_api.searchDeps('%s', '%s')", opts.query, opts.format)
      ),
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local choice = action_state.get_selected_entry()[1]
        if choice then
          vim.fn.setreg('+', choice)
          vim.notify(string.format('%s copied to clipboard', choice));
        end
      end)
      return true
    end
  }):find()
end

return {
  deps = deps
}
