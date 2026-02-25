return {
  "nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  after = function()
    -- nvim 0.11+ handles treesitter highlight/indent natively
    -- grammars are installed via nvim-treesitter.withAllGrammars in start plugins
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  end,
}
