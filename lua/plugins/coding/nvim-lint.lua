return {
  "nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  after = function()
    local lint = require "lint"
    local cfg = vim.api.nvim_get_runtime_file("lua/config/linters/global.markdownlint-cli2.yaml", false)[1]

    lint.linters_by_ft = {
      markdown = { "markdownlint-cli2" },
    }

    if cfg and lint.linters["markdownlint-cli2"] then
      lint.linters["markdownlint-cli2"].args = {
        "--config",
        cfg,
        "--",
      }
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function() lint.try_lint() end,
    })
  end,
}
