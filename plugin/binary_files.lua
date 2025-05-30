-- Open binary files
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd("silent !okular " .. filename .. " &")
    vim.cmd "let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted"
  end,
})

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd("silent !gwenview " .. filename .. " &")
    vim.cmd "let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted"
  end,
})
