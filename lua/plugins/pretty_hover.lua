---@type LazySpec
return {
  "Fildo7525/pretty_hover",
  event = "LspAttach",
  config = function()
    require("pretty_hover").setup {
      border = "rounded",
      max_width = 80,
      title = true,
      style = "default", -- or "default", "compact"
    }
  end,
}
