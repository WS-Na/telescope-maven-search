local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

local MavenArtifact = require'telescope._extensions.mvnsearch.artifact'
local formatters = require'telescope._extensions.mvnsearch.formatters'

-- Get a list of {artifact, format} objects
-- @param query: string - The query string to submit to mvnrepository
-- @param format: string - The desired output format
local getArtifacts = function(query, format)
  format = format or 'maven'

  local artifacts = vim.fn.py3eval(
    string.format("mvnrepository_api.searchDeps('%s')", query)
  )

  return vim.tbl_map(function(artifact)
    local parts = vim.fn.split(artifact, ":")
    local groupId, artifactId, latestVersion = parts[1], parts[2], parts[3]
    local artifact = MavenArtifact(groupId, artifactId, latestVersion)
    return {
      artifact = artifact,
      format = formatters[format](artifact)
    }
  end, artifacts)
end

local deps = function(opts)
  return pickers.new(opts, {
    prompt_title = 'Search Maven Central',
    finder = finders.new_table {
      results = getArtifacts(opts.query, opts.format),
      entry_maker = function(entry)
        local artifact = entry.artifact
        return {
          value = entry,
          display = string.format(
            'group: %s, id: %s, version: %s',
            artifact.groupId, artifact.artifactId, artifact.latestVersion
          ),
          ordinal = artifact.artifactId
        }
      end
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local bufnr = self.state.bufnr
        local winid = self.state.winid

        vim.api.nvim_win_set_option(winid, 'wrap', true)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, entry.value.format)
      end
    }),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local choice = action_state.get_selected_entry().value
        if choice then
          vim.fn.setreg('+', choice.format)
          vim.notify(string.format('%s\ncopied to clipboard', vim.fn.join(choice.format, '\n')), "info", {
            title = 'Maven Search'
          });
        end
      end)
      return true
    end
  }):find()
end

return {
  deps = deps
}
