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
}
