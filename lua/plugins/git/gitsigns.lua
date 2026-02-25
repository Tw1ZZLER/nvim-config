return {
  "gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  after = function()
    require("gitsigns").setup {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = false,
    }

    local gs = require "gitsigns"
    vim.keymap.set("n", "]h", function() gs.nav_hunk "next" end, { desc = "Next hunk" })
    vim.keymap.set("n", "[h", function() gs.nav_hunk "prev" end, { desc = "Prev hunk" })
    vim.keymap.set("n", "]H", function() gs.nav_hunk "last" end, { desc = "Last hunk" })
    vim.keymap.set("n", "[H", function() gs.nav_hunk "first" end, { desc = "First hunk" })
    vim.keymap.set({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
    vim.keymap.set({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
    vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
    vim.keymap.set("n", "<leader>ghb", function() gs.blame_line { full = true } end, { desc = "Blame line" })
    vim.keymap.set("n", "<leader>ghB", gs.blame, { desc = "Blame buffer" })
    vim.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
    vim.keymap.set("n", "<leader>ghD", function() gs.diffthis "~" end, { desc = "Diff this ~" })
    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
  end,
}
