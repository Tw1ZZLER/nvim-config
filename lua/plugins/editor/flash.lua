return {
  "flash.nvim",
  event = "VimEnter",
  after = function() require("flash").setup {} end,
  keys = {
    { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
    { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    { "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
    { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Treesitter Search" },
    { "<C-s>", function() require("flash").toggle() end, mode = "c", desc = "Toggle Flash Search" },
    {
      "<C-space>",
      function()
        require("flash").treesitter {
          actions = {
            ["<C-space>"] = "next",
            ["<BS>"] = "prev",
          },
        }
      end,
      mode = { "n", "o", "x" },
      desc = "Treesitter Incremental Selection",
    },
  },
}
