return {
  "refactoring-nvim",
  event = "VimEnter",
  before = function()
    LZN.trigger_load "plenary.nvim"
    LZN.trigger_load "nvim-treesitter"
  end,
  after = function()
    require("refactoring").setup {}
  end,
  keys = {
    { "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },
    { "<leader>rb", function() require("refactoring").refactor "Extract Block" end, mode = { "n", "x" }, desc = "Extract Block" },
    { "<leader>rf", function() require("refactoring").refactor "Extract Function" end, mode = { "n", "x" }, desc = "Extract Function" },
    { "<leader>rF", function() require("refactoring").refactor "Extract Function To File" end, mode = { "n", "x" }, desc = "Extract Function To File" },
    { "<leader>ri", function() require("refactoring").refactor "Inline Variable" end, mode = { "n", "x" }, desc = "Inline Variable" },
    { "<leader>rx", function() require("refactoring").refactor "Extract Variable" end, mode = { "n", "x" }, desc = "Extract Variable" },
    { "<leader>rs", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Refactor" },
    { "<leader>rp", function() require("refactoring").debug.printf { below = false } end, mode = { "n", "x" }, desc = "Debug Print Variable" },
    { "<leader>rP", function() require("refactoring").debug.print_var {} end, desc = "Debug Print" },
    { "<leader>rc", function() require("refactoring").debug.cleanup {} end, desc = "Debug Cleanup" },
  },
}
