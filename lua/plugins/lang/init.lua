local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.lang.clangd")
add(require "plugins.lang.haskell")
add(require "plugins.lang.java")
add(require "plugins.lang.lazydev")
add(require "plugins.lang.rust")

return specs
