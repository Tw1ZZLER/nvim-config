return {
  "which-key.nvim",
  event = "VimEnter",
  after = function()
    local wk = require "which-key"
    wk.setup {
      preset = "helix",
      win = {
        border = "rounded",
        row = math.huge,
        col = math.huge,
        title = false,
      },
    }
    wk.add {
      {
        "<leader>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>dp", group = "profiler" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "hunks" },
      { "<leader>o", group = "overseer" },
      { "<leader>q", group = "quit/session" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "ui" },
      {
        "<leader>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "<leader><tab>", group = "tabs" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
    }

    vim.keymap.set(
      "n",
      "<leader>?",
      function() wk.show { global = false } end,
      { desc = "Buffer keymaps (which-key)" }
    )
    vim.keymap.set(
      "n",
      "<C-w><space>",
      function() wk.show { keys = "<c-w>", loop = true } end,
      { desc = "Window Hydra Mode (which-key)" }
    )
  end,
}
