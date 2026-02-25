return {
  {
    "nui.nvim",
  },
  {
    "nvim-notify",
    after = function() vim.notify = require "notify" end,
  },
  {
    "noice.nvim",
    event = "VimEnter",
    before = function()
      LZN.trigger_load "nui.nvim"
      LZN.trigger_load "nvim-notify"
    end,
    after = function()
      require("noice").setup {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      }
    end,
  },
}
