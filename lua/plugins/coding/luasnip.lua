return {
  "luasnip",
  event = "InsertEnter",
  before = function() LZN.trigger_load "friendly-snippets" end,
  after = function()
    local luasnip = require "luasnip"
    luasnip.filetype_extend("javascript", { "javascriptreact" })

    local snippet_paths = vim.api.nvim_get_runtime_file("lua/luasnippets", true)
    require("luasnip.loaders.from_lua").load {
      paths = snippet_paths,
    }

    luasnip.config.set_config {
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    }
  end,
}
