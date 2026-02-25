return {
  "fzf-lua",
  cmd = "FzfLua",
  before = function() LZN.trigger_load "nvim-web-devicons" end,
  after = function()
    local fzf = require "fzf-lua"
    fzf.setup { "telescope" }
    fzf.register_ui_select()
  end,
  keys = {
    { "<leader><space>", function() require("fzf-lua").files() end, desc = "Find files" },
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files" },
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live grep" },
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent files" },
    { "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Help tags" },
    { "<leader>fd", function() require("fzf-lua").diagnostics_document() end, desc = "Buffer diagnostics" },
    { "<leader>fD", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace diagnostics" },
    { "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document symbols" },
    { "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "Workspace symbols" },
  },
}
