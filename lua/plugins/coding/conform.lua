return {
  "conform.nvim",
  event = { "BufWritePre" },
  after = function()
    require("conform").setup {
      notify_on_error = false,
      format_on_save = function(bufnr) return { timeout_ms = 1000, lsp_format = "fallback", bufnr = bufnr } end,
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
      desc = "Format",
    },
  },
}
