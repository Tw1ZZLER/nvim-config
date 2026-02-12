return {
  {
    "fzf-lua",
    cmd = "FzfLua",
    before = function() LZN.trigger_load "nvim-web-devicons" end,
    after = function()
      local fzf = require "fzf-lua"
      fzf.setup { "telescope" }
      fzf.register_ui_select()
    end,
    keys = {
      { "<leader><space>", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
      { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
      { "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Help tags" },
      { "<leader>fd", function() require("fzf-lua").diagnostics_document() end, desc = "Buffer diagnostics" },
      { "<leader>fD", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace diagnostics" },
      { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
      { "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Workspace symbols" },
    },
  },

  {
    "flash.nvim",
    event = "VeryLazy",
    after = function()
      require("flash").setup {}
    end,
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
      { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      { "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
      { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Treesitter Search" },
    },
  },

  {
    "todo-comments.nvim",
    event = "VeryLazy",
    before = function() LZN.trigger_load "plenary.nvim" end,
    after = function()
      require("todo-comments").setup {}
    end,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
  },

  {
    "conform.nvim",
    event = { "BufWritePre" },
    after = function()
      require("conform").setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          return { timeout_ms = 1000, lsp_format = "fallback", bufnr = bufnr }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          nix = { "nixfmt" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescriptreact = { "prettierd" },
          json = { "prettierd" },
          yaml = { "prettierd" },
          markdown = { "prettierd" },
        },
      }
    end,
    keys = {
      {
        "<leader>cf",
        function() require("conform").format { async = true, lsp_format = "fallback" } end,
        desc = "Format buffer",
      },
    },
  },

  {
    "persistence.nvim",
    event = "BufReadPre",
    after = function() require("persistence").setup {} end,
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
      { "<leader>ql", function() require("persistence").load { last = true } end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop session saving" },
    },
  },

  {
    "mini.nvim",
    event = "VeryLazy",
    after = function()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.icons").setup()
    end,
  },

  {
    "indent-blankline.nvim",
    event = "BufReadPost",
    after = function()
      require("ibl").setup {
        indent = { char = "│" },
        scope = { enabled = true },
      }
    end,
  },

  {
    "ts-comments.nvim",
    event = "VeryLazy",
    after = function()
      require("ts-comments").setup()
    end,
  },
}
