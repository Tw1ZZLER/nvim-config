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

      vim.keymap.set("n", "]h", function() require("gitsigns").nav_hunk "next" end, { desc = "Next hunk" })
      vim.keymap.set("n", "[h", function() require("gitsigns").nav_hunk "prev" end, { desc = "Prev hunk" })
      vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { desc = "Stage hunk" })
      vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { desc = "Reset hunk" })
      vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { desc = "Stage buffer" })
      vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { desc = "Reset buffer" })
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "Preview hunk" })
      vim.keymap.set("n", "<leader>hb", function() require("gitsigns").blame_line { full = true } end, { desc = "Blame line" })
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
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
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
      local lspconfig = require "lspconfig"

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
        map("n", "gi", vim.lsp.buf.implementation, "Implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format")
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local servers = {
        clangd = {},
        nil_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        texlab = {},
        ltex = {
          settings = {
            ltex = {
              disabledRules = {
                ["en"] = { "MORFOLOGIK_RULE_EN" },
                ["en-AU"] = { "MORFOLOGIK_RULE_EN_AU" },
                ["en-CA"] = { "MORFOLOGIK_RULE_EN_CA" },
                ["en-GB"] = { "MORFOLOGIK_RULE_EN_GB" },
                ["en-NZ"] = { "MORFOLOGIK_RULE_EN_NZ" },
                ["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
                ["en-ZA"] = { "MORFOLOGIK_RULE_EN_ZA" },
                ["es"] = { "MORFOLOGIK_RULE_ES" },
                ["it"] = { "MORFOLOGIK_RULE_IT_IT" },
                ["de"] = { "MORFOLOGIK_RULE_DE_DE" },
              },
            },
          },
        },
      }

      for server, server_opts in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, server_opts))
      end
    end,
  },

  {
    "nvim-cmp",
    event = "InsertEnter",
    before = function()
      LZN.trigger_load "cmp-buffer"
      LZN.trigger_load "cmp-nvim-lsp"
      LZN.trigger_load "cmp-path"
      LZN.trigger_load "cmp_luasnip"
      LZN.trigger_load "luasnip"
    end,
    after = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      }
    end,
  },
}
