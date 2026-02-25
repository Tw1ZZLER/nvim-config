return {
  "indent-blankline.nvim",
  event = "BufReadPost",
  after = function()
    require("ibl").setup {
      indent = { char = "│" },
      scope = { enabled = true },
    }
  end,
}
