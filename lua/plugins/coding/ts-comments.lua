return {
  "ts-comments.nvim",
  event = "VimEnter",
  after = function() require("ts-comments").setup() end,
}
