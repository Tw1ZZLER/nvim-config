return {
  "vim-illuminate",
  event = "VimEnter",
  after = function()
    require("illuminate").configure {}
    vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end, { desc = "Next Reference" })
    vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev Reference" })
    vim.keymap.set("n", "<A-n>", function() require("illuminate").goto_next_reference(false) end, { desc = "Next Reference" })
    vim.keymap.set("n", "<A-p>", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev Reference" })
  end,
}
