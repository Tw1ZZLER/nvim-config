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

-------------
-- LUASNIP --
-------------

-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/LuaSnip/" }

-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config { -- Setting LuaSnip config

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",
}
