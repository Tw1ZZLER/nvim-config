---@type LazySpec
return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })

      -- Snippets path
      require("luasnip.loaders.from_lua").load {
        paths = { "~/.config/nvim/lua/luasnippets/", "~/.config/nvim/lua/luasnip-latex-snippets/" },
      }

      -- Setting LuaSnip config
      require("luasnip").config.set_config {

        -- Enable autotriggered snippets
        enable_autosnippets = true,

        -- Use Tab (or some other key if you prefer) to trigger visual selection
        store_selection_keys = "<Tab>",
      }
    end,
  },
}
