return {
  "todo-comments.nvim",
  event = "VimEnter",
  before = function() LZN.trigger_load "plenary.nvim" end,
  after = function() require("todo-comments").setup {} end,
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    {
      "<leader>xT",
      function() require("trouble").toggle("todo", { filter = { any = { { tag = { "TODO", "FIX", "FIXME" } } } } }) end,
      desc = "Todo/Fix/Fixme (Trouble)",
    },
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    {
      "<leader>sT",
      function() Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } } end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
