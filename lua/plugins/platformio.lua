-- PlatformIO related plugins and config

---@type LazySpec
return {
  {
    "normen/vim-pio",
    lazy = false,
    config = function() end,
  },
  {
    "coddingtonbear/neomake-platformio",
    lazy = false,
    config = function() end,
  },
}
