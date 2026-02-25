return {
  "edgy.nvim",
  event = "VimEnter",
  after = function()
    require("edgy").setup {
      bottom = {
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        { ft = "help", size = { height = 20 } },
      },
    }
  end,
  keys = {
    { "<leader>ue", function() require("edgy").toggle() end, desc = "Edgy Toggle" },
    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
  },
}
