-- PlatformIO related plugins
return {
  {
    "normen/vim-pio",
    ft = { "cpp", "h", "ini" },
    cond = function() return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1 end,
    config = function() end,
  },
  {
    "coddingtonbear/neomake-platformio",
    ft = { "cpp", "h", "ini" },
    cond = function() return vim.fn.filereadable(vim.fn.getcwd() .. "/platformio.ini") == 1 end,
    config = function() end,
  },
}
