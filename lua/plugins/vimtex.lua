---@type LazySpec
return {
  "lervag/vimtex",
  config = function()
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    vim.g.tex_flavor = "latex"

    -- The last two lines configure the concealment. This is a feature where LaTeX
    -- code is replaced or made invisible when your cursor is not on that line. By
    -- making \[, \], $ invisible, they’re less obtrusive which gives you a better
    -- overview of the document. This feature also replaces \bigcap by by ∩,
    -- \in by ∈ etc.
    vim.g.tex_conceal = "abdmg"
    vim.opt.conceallevel = 1
    -- Don't open QuickFix for warning messages if no errors are present
    vim.g.vimtex_quickfix_open_on_warning = 0

    -- Filter out some compilation warning messages from QuickFix display
    vim.g.vimtex_quickfix_ignore_filters = {
      "Underfull \\hbox",
      "Overfull \\hbox",
      "LaTeX Warning: .+ float specifier changed to",
      "LaTeX hooks Warning",
      'Package siunitx Warning: Detected the "physics" package:',
      "Package hyperref Warning: Token not allowed in a PDF string'",
    }
  end,
  opts = {
    autocmds = {
      vimtex_mapping_descriptions = {
        {
          event = "FileType",
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
        },
      },
    },
  },
}
