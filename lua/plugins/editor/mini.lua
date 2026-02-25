return {
  "mini.nvim",
  event = "VimEnter",
  after = function()
    require("mini.ai").setup()
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.icons").setup()
  end,
}
