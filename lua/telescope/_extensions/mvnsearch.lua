local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error "This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)"
end

local pythonImported = false
local cfg = nil

local supportedFormats = {
  'maven', 'gradle', 'sbt', 'leiningen'
}

local setupPython = function()
  if pythonImported then
    return
  end

  vim.cmd[[py3 from mvnrepository import api as mvnrepository_api]]
  pythonImported = true
end

local setup = function(config)
  cfg = config
  setupPython()
end

local telescopeMvnSearch = function(opts)
  opts = vim.tbl_extend("keep", opts or {}, cfg)

  if opts.query == nil then
    vim.notify(
      'You must supply a query like "Telescope mvnsearch query=..."',
      vim.log.levels.ERROR
    )
    return
  end

  opts.format = opts.format or 'maven';
  if not vim.tbl_contains(supportedFormats, opts.format) then
    vim.notify('Format not supported: ' .. opts.format, vim.log.levels.ERROR);
    return
  end

  require('telescope._extensions.mvnsearch.pickers').deps(opts);
end

return telescope.register_extension {
  setup = setup,
  exports = {
    mvnsearch = telescopeMvnSearch
  }
}
