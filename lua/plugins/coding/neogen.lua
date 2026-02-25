return {
  "neogen",
  cmd = "Neogen",
  after = function()
    require("neogen").setup {}
  end,
  keys = {
    {
      "<leader>cn",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
}
