-- Commands that don't fall into any of the other categories go here

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"
vim.opt.cmdheight = 0

---------------------
-- SPELL & GRAMMAR --
---------------------
vim.opt.spelllang = "en_us"
vim.opt.spell = false

-------------
-- LUASNIP --
-------------

-- Snippets path
require("luasnip.loaders.from_lua").load {
  paths = { "~/.config/nvim/lua/luasnippets/", "~/.config/nvim/lua/luasnip-latex-snippets/" },
}

-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config { -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
}

---------------
-- TELESCOPE --
---------------
require("telescope").load_extension "luasnip"

-----------------------
-- REMOVE BACKGROUND --
-----------------------
vim.api.nvim_set_hl(0, "Normal", { guibg = nil, ctermbg = nil })
vim.t.is_transparent = 1
