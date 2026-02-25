local specs = {}

local function add(spec)
  if type(spec[1]) == "string" then
    specs[#specs + 1] = spec
  else
    vim.list_extend(specs, spec)
  end
end

add(require "plugins.coding.blink-cmp")
add(require "plugins.coding.conform")
add(require "plugins.coding.lspconfig")
add(require "plugins.coding.luasnip")
add(require "plugins.coding.neogen")
add(require "plugins.coding.nvim-lint")
add(require "plugins.coding.refactoring")
add(require "plugins.coding.treesitter")
add(require "plugins.coding.ts-comments")

return specs
