local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.editor.dial")
add(require "plugins.editor.flash")
add(require "plugins.editor.harpoon")
add(require "plugins.editor.illuminate")
add(require "plugins.editor.mini")
add(require "plugins.editor.mini-diff")
add(require "plugins.editor.mini-files")
add(require "plugins.editor.persistence")
add(require "plugins.editor.todo-comments")
add(require "plugins.editor.yanky")

return specs
