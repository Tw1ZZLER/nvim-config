return {
  "blink.cmp",
  event = "InsertEnter",
  after = function()
    require("blink.cmp").setup {
      keymap = { preset = "default" },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    }
  end,
}
