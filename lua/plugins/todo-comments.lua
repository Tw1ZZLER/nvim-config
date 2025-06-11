---@type LazySpec
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      TODO = { icon = " ", color = "info", alt = { "[ ]", "[x]", "[X]" } },
    },

    -- Custom patterns to match both regular keywords and checkboxes
    highlight = {
      pattern = [[.*<((KEYWORDS)\s*:|(\[[ xX]\]))]],
    },
    search = {
      pattern = [[\b((KEYWORDS):|(\[[ xX]\]))]],
    },
  },
}
