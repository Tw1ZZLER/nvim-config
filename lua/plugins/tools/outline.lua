return {
  "outline.nvim",
  cmd = "Outline",
  keys = {
    { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  after = function()
    require("outline").setup {}
  end,
}
