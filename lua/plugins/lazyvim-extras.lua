return {
  {
    "bufferline.nvim",
    event = "VimEnter",
    before = function() LZN.trigger_load "nvim-web-devicons" end,
    after = function()
      require("bufferline").setup {}
    end,
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
  },

  {
    "grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    before = function() LZN.trigger_load "plenary.nvim" end,
    after = function()
      require("grug-far").setup { headerMaxWidth = 80 }
    end,
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "x" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "yanky.nvim",
    event = "VimEnter",
    after = function()
      require("yanky").setup {
        system_clipboard = {
          sync_with_ring = not vim.env.SSH_CONNECTION,
        },
      }
    end,
    keys = {
      { "<leader>p", function() Snacks.picker.yanky() end, mode = { "n", "x" }, desc = "Open Yank History" },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
    },
  },

  {
    "dial-nvim",
    event = "VimEnter",
    after = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
        },
      }
    end,
    keys = {
      { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, mode = "n", desc = "Increment" },
      { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v", desc = "Increment" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, mode = "n", desc = "Decrement" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, mode = "n", desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, mode = "n", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "x", desc = "Increment" },
      { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "x", desc = "Decrement" },
    },
  },

  {
    "harpoon2",
    event = "VimEnter",
    after = function()
      require("harpoon"):setup {
        settings = { save_on_toggle = true },
      }
    end,
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require "harpoon"
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }
      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },

  {
    "vim-illuminate",
    event = "VimEnter",
    after = function()
      require("illuminate").configure {}
      vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end, { desc = "Next Reference" })
      vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev Reference" })
      vim.keymap.set("n", "<A-n>", function() require("illuminate").goto_next_reference(false) end, { desc = "Next Reference" })
      vim.keymap.set("n", "<A-p>", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev Reference" })
    end,
  },

  {
    "mini-diff",
    event = "VimEnter",
    after = function()
      require("mini.diff").setup {
        view = {
          style = "sign",
          signs = { add = "▎", change = "▎", delete = "" },
        },
      }
    end,
    keys = {
      {
        "<leader>go",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
  },

  {
    "mini-files",
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    after = function()
      require("mini.files").setup {
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 30,
        },
      }
    end,
  },

  {
    "outline-nvim",
    cmd = "Outline",
    keys = {
      { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
    after = function()
      require("outline").setup {}
    end,
  },

  {
    "overseer-nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    after = function()
      require("overseer").setup {
        dap = false,
      }
    end,
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
    },
  },

  {
    "refactoring-nvim",
    event = "VimEnter",
    before = function()
      LZN.trigger_load "plenary.nvim"
      LZN.trigger_load "nvim-treesitter"
    end,
    after = function()
      require("refactoring").setup {}
    end,
    keys = {
      { "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },
      { "<leader>rb", function() require("refactoring").refactor "Extract Block" end, mode = { "n", "x" }, desc = "Extract Block" },
      { "<leader>rf", function() require("refactoring").refactor "Extract Function" end, mode = { "n", "x" }, desc = "Extract Function" },
      { "<leader>rF", function() require("refactoring").refactor "Extract Function To File" end, mode = { "n", "x" }, desc = "Extract Function To File" },
      { "<leader>ri", function() require("refactoring").refactor "Inline Variable" end, mode = { "n", "x" }, desc = "Inline Variable" },
      { "<leader>rx", function() require("refactoring").refactor "Extract Variable" end, mode = { "n", "x" }, desc = "Extract Variable" },
      { "<leader>rs", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Refactor" },
      { "<leader>rp", function() require("refactoring").debug.printf { below = false } end, mode = { "n", "x" }, desc = "Debug Print Variable" },
      { "<leader>rP", function() require("refactoring").debug.print_var {} end, desc = "Debug Print" },
      { "<leader>rc", function() require("refactoring").debug.cleanup {} end, desc = "Debug Cleanup" },
    },
  },

  {
    "neogen",
    cmd = "Neogen",
    after = function()
      require("neogen").setup {}
    end,
    keys = {
      {
        "<leader>cn",
        function()
          require("neogen").generate()
        end,
        desc = "Generate Annotations (Neogen)",
      },
    },
  },

  {
    "nvim-dap",
    event = "VimEnter",
    keys = {
      {
        "<leader>da",
        function()
          local args = vim.fn.input "Run with args: "
          require("dap").continue { before = function() return vim.split(args, " +") end }
        end,
        desc = "Run with Args",
      },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end, desc = "Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },

  {
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
  },


  {
    "edgy-nvim",
    event = "VimEnter",
    after = function()
      require("edgy").setup {
        bottom = {
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          { ft = "help", size = { height = 20 } },
        },
      }
    end,
    keys = {
      { "<leader>ue", function() require("edgy").toggle() end, desc = "Edgy Toggle" },
      { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
  },

  {
    "litee-nvim",
    lazy = true,
  },
  {
    "gh-nvim",
    cmd = { "GHOpenPR", "GHOpenIssue", "GHCloseReview", "LTPanel" },
    before = function() LZN.trigger_load "litee-nvim" end,
    after = function()
      require("litee.lib").setup()
      require("litee.gh").setup {}
    end,
    keys = {
      { "<leader>G", "", desc = "+Github" },
      { "<leader>Gc", "", desc = "+Commits" },
      { "<leader>Gi", "", desc = "+Issues" },
      { "<leader>Gl", "", desc = "+Litee" },
      { "<leader>Gp", "", desc = "+Pull Request" },
      { "<leader>Gr", "", desc = "+Review" },
      { "<leader>Gt", "", desc = "+Threads" },
      { "<leader>Glt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
    },
  },

}
