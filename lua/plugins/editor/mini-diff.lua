return {
  "mini-diff",
  event = "VimEnter",
  after = function()
    require("mini.diff").setup {
      view = {
        style = "sign",
        signs = { add = "▎", change = "▎", delete = "" },
      },
    }
  end,
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },
}
