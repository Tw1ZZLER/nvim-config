return {
  "blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  before = function()
    LZN.trigger_load "luasnip"
  end,
  after = function()
    require("blink.cmp").setup {
      keymap = {
        preset = "enter",
        ["<C-y>"] = { "select_and_accept" },
      },
      snippets = {
        preset = "luasnip",
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
            end,
          },
          ghost_text = { enabled = true },
        },
      },
    }
  end,
}
