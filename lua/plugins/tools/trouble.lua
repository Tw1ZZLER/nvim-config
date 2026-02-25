return {
  "trouble.nvim",
  cmd = "Trouble",
  before = function() LZN.trigger_load "nvim-web-devicons" end,
  after = function() require("trouble").setup {} end,
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>cS",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP references/definitions/... (Trouble)",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next { skip_groups = true, jump = true }
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next trouble/quickfix item",
    },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev { skip_groups = true, jump = true }
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Prev trouble/quickfix item",
    },
  },
}
