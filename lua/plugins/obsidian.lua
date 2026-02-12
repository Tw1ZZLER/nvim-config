return {
  "obsidian.nvim",
  ft = "markdown",
  before = function() LZN.trigger_load "plenary.nvim" end,
  after = function()
    require("obsidian").setup {
      workspaces = {
        {
          name = "EpicVault",
          path = "~/vaults/EpicVault",
        },
      },
    }
  end,
}
