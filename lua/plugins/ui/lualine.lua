return {
  "lualine.nvim",
  event = "VimEnter",
  before = function() LZN.trigger_load "nvim-web-devicons" end,
  after = function()
    require("lualine").setup {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          { "filename", path = 1 },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "quickfix", "trouble" },
    }
  end,
}
