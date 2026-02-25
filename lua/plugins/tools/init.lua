local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.tools.fzf-lua")
add(require "plugins.tools.grug-far")
add(require "plugins.tools.obsidian")
add(require "plugins.tools.outline")
add(require "plugins.tools.overseer")
add(require "plugins.tools.tex")
add(require "plugins.tools.trouble")

return specs
