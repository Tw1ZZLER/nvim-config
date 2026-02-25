local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.debug.nvim-dap")
add(require "plugins.debug.nvim-dap-ui")

return specs
