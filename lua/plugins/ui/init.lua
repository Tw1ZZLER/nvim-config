local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.ui.bufferline")
add(require "plugins.ui.catppuccin")
add(require "plugins.ui.edgy")
add(require "plugins.ui.indent-blankline")
add(require "plugins.ui.lualine")
add(require "plugins.ui.noice")
add(require "plugins.ui.snacks")
add(require "plugins.ui.which-key")

return specs
