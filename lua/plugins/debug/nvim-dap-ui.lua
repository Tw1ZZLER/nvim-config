return {
  "nvim-dap-ui",
  before = function()
    LZN.trigger_load "nvim-dap"
    LZN.trigger_load "nvim-nio"
  end,
  after = function()
    require("dapui").setup {}
    require("dap").listeners.after.event_initialized.dapui_config = function()
      require("dapui").open {}
    end
    require("dap").listeners.before.event_terminated.dapui_config = function()
      require("dapui").close {}
    end
    require("dap").listeners.before.event_exited.dapui_config = function()
      require("dapui").close {}
    end
  end,
  keys = {
    { "<leader>du", function() require("dapui").toggle {} end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Eval" },
  },
}
