-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name) return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true }) end

-- Add VimTeX Which-Key descriptions
autocmd("FileType", {
  group = augroup "vimtex_which_key",
  desc = "Set up VimTex Which-Key descriptions",
  pattern = "tex",
  callback = function(event)
    local wk_avail, wk = pcall(require, "which-key")
    if not wk_avail then return end
    wk.add {
      buffer = event.buf,
      {
        mode = "n",
        { "<localleader>l", group = "VimTeX" },
        { "<localleader>la", desc = "Show Context Menu" },
        { "<localleader>lC", desc = "Full Clean" },
        { "<localleader>lc", desc = "Clean" },
        { "<localleader>le", desc = "Show Errors" },
        { "<localleader>lG", desc = "Show Status for All" },
        { "<localleader>lg", desc = "Show Status" },
        { "<localleader>li", desc = "Show Info" },
        { "<localleader>lI", desc = "Show Full Info" },
        { "<localleader>lk", desc = "Stop VimTeX" },
        { "<localleader>lK", desc = "Stop All VimTeX" },
        { "<localleader>lL", desc = "Compile Selection" },
        { "<localleader>ll", desc = "Compile" },
        { "<localleader>lm", desc = "Show Imaps" },
        { "<localleader>lo", desc = "Show Compiler Output" },
        { "<localleader>lq", desc = "Show VimTeX Log" },
        { "<localleader>ls", desc = "Toggle Main" },
        { "<localleader>lt", desc = "Open Table of Contents" },
        { "<localleader>lT", desc = "Toggle Table of Contents" },
        { "<localleader>lv", desc = "View Compiled Document" },
        { "<localleader>lX", desc = "Reload VimTeX State" },
        { "<localleader>lx", desc = "Reload VimTeX" },
        { "ts", group = "VimTeX Toggles & Cycles" },
        { "ts$", desc = "Cycle inline, display & numbered equation" },
        { "tsc", desc = "Toggle star of command" },
        { "tsd", desc = "Cycle (), \\left(\\right) [,...]" },
        { "tsD", desc = "Reverse Cycle (), \\left(\\right) [, ...]" },
        { "tse", desc = "Toggle star of environment" },
        { "tsf", desc = "Toggle a/b vs \\frac{a}{b}" },
        { "[/", desc = "Previous start of a LaTeX comment" },
        { "[*", desc = "Previous end of a LaTeX comment" },
        { "[[", desc = "Previous beginning of a section" },
        { "[]", desc = "Previous end of a section" },
        { "[m", desc = "Previous \\begin" },
        { "[M", desc = "Previous \\end" },
        { "[n", desc = "Previous start of a math zone" },
        { "[N", desc = "Previous end of a math zone" },
        { "[r", desc = "Previous \\begin{frame}" },
        { "[R", desc = "Previous \\end{frame}" },
        { "]/", desc = "Next start of a LaTeX comment %" },
        { "]*", desc = "Next end of a LaTeX comment %" },
        { "][", desc = "Next beginning of a section" },
        { "]]", desc = "Next end of a section" },
        { "]m", desc = "Next \\begin" },
        { "]M", desc = "Next \\end" },
        { "]n", desc = "Next start of a math zone" },
        { "]N", desc = "Next end of a math zone" },
        { "]r", desc = "Next \\begin{frame}" },
        { "]R", desc = "Next \\end{frame}" },
        { "csc", desc = "Change surrounding command" },
        { "cse", desc = "Change surrounding environment" },
        { "cs$", desc = "Change surrounding math zone" },
        { "csd", desc = "Change surrounding delimiter" },
        { "dsc", desc = "Delete surrounding command" },
        { "dse", desc = "Delete surrounding environment" },
        { "ds$", desc = "Delete surrounding math zone" },
        { "dsd", desc = "Delete surrounding delimiter" },
      },
      {
        mode = "o",
        { "ic", desc = "LaTeX Command" },
        { "ac", desc = "LaTeX Command" },
        { "id", desc = "LaTeX Math Delimiter" },
        { "ad", desc = "LaTeX Math Delimiter" },
        { "ie", desc = "LaTeX Environment" },
        { "ae", desc = "LaTeX Environment" },
        { "i$", desc = "LaTeX Math Zone" },
        { "a$", desc = "LaTeX Math Zone" },
        { "iP", desc = "LaTeX Section, Paragraph, ..." },
        { "aP", desc = "LaTeX Section, Paragraph, ..." },
        { "im", desc = "LaTeX Item" },
        { "am", desc = "LaTeX Item" },
      },
    }
  end,
})
