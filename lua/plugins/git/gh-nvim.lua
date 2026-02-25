return {
  {
    "litee-nvim",
    lazy = true,
  },
  {
    "gh-nvim",
    cmd = { "GHOpenPR", "GHOpenIssue", "GHCloseReview", "LTPanel" },
    before = function() LZN.trigger_load "litee-nvim" end,
    after = function()
      require("litee.lib").setup()
      require("litee.gh").setup {}
    end,
    keys = {
      { "<leader>G", "", desc = "+Github" },
      { "<leader>Gc", "", desc = "+Commits" },
      { "<leader>Gi", "", desc = "+Issues" },
      { "<leader>Gl", "", desc = "+Litee" },
      { "<leader>Gp", "", desc = "+Pull Request" },
      { "<leader>Gr", "", desc = "+Review" },
      { "<leader>Gt", "", desc = "+Threads" },
      { "<leader>Glt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
    },
  },
}
