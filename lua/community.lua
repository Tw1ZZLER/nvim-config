-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  -- { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  -- { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  -- { import = "astrocommunity.recipes.neovide" },
}
