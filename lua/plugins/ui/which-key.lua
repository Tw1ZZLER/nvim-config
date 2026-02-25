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
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>o", group = "Overseer" },
      { "<leader>q", group = "Session" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
      { "<leader>x", group = "Diagnostics/Lists" },
      { "<leader><tab>", group = "Tabs" },
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
