return {
  "catppuccin-nvim",
  lazy = false,
  after = function()
    require("catppuccin").setup {
      flavour = "frappe",
      background = { light = "latte", dark = "frappe" },
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        lsp_trouble = true,
        markdown = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        noice = true,
        notify = true,
        snacks = true,
        treesitter = true,
        which_key = true,
      },
    }

    vim.cmd.colorscheme "catppuccin-frappe"
  end,
}
