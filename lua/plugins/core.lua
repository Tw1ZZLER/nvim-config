return {
  {
    "which-key.nvim",
    event = "VimEnter",
    after = function()
      local wk = require "which-key"
      wk.setup {
        preset = "helix",
        win = {
          border = "rounded",
          row = math.huge,
          col = math.huge,
          title = false,
        },
      }
      wk.add {
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>q", group = "Session" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics/Lists" },
        { "<leader><tab>", group = "Tabs" },
      }

      vim.keymap.set("n", "<leader>?", function()
        wk.show { global = false }
      end, { desc = "Buffer keymaps (which-key)" })
      vim.keymap.set("n", "<C-w><space>", function()
        wk.show { keys = "<c-w>", loop = true }
      end, { desc = "Window Hydra Mode (which-key)" })
    end,
  },

  {
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
  },

  {
    "nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  {
    "trouble.nvim",
    cmd = "Trouble",
    before = function() LZN.trigger_load "nvim-web-devicons" end,
    after = function() require("trouble").setup {} end,
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "]q", function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            vim.cmd.cnext()
          end
        end, desc = "Next trouble/quickfix item" },
      { "[q", function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            vim.cmd.cprev()
          end
        end, desc = "Prev trouble/quickfix item" },
    },
  },

  {
    "nui.nvim",
  },
  {
    "nvim-notify",
    after = function()
      vim.notify = require "notify"
    end,
  },
  {
    "noice.nvim",
    event = "VimEnter",
    before = function()
      LZN.trigger_load "nui.nvim"
      LZN.trigger_load "nvim-notify"
    end,
    after = function()
      require("noice").setup {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      }
    end,
  },

  {
    "nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          },
        },
      }

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
        map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
        map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map({ "n", "x" }, "<leader>cf", function() vim.lsp.buf.format { async = true } end, "Format")
        map("n", "<leader>cc", vim.lsp.codelens.run, "Run codelens")
        map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh codelens")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_blink, blink = pcall(require, "blink.cmp")
      if ok_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      local servers = {
        nil_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      for server, server_opts in pairs(servers) do
        vim.lsp.config(server, vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, server_opts))
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "blink.cmp",
    event = "InsertEnter",
    after = function()
      require("blink.cmp").setup {
        keymap = { preset = "default" },
        completion = {
          accept = { auto_brackets = { enabled = true } },
          documentation = { auto_show = true },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
      }
    end,
  },
}
