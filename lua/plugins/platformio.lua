-- PlatformIO related plugins and config

---@type LazySpec
return {
  {
    "normen/vim-pio",
    ft = { "cpp", "h", "platformio.ini" },
    config = function() end,
  },
  {
    "coddingtonbear/neomake-platformio",
    ft = { "cpp", "h", "platformio.ini" },
    config = function() end,
  },
}
