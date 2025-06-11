return {
  "folke/todo-comments.nvim",
  opts = {
    keywords = {
      CHECKBOX = { icon = "☐", color = "info" },
    }, -- Custom patterns to match both regular keywords and checkboxes
    highlight = {
      pattern = [[.*<((KEYWORDS)\s*:|(\[[ xX]\]))]],
    },
    search = {
      pattern = [[\b((KEYWORDS):|(\[[ xX]\]))]],
    },
  },
}
