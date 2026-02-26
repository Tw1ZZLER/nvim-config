return {
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
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = " ",
          [vim.diagnostic.severity.HINT] = " ",
        },
      },
    }

    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Navigation
      map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
      map("n", "gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")

      -- Hover / Signature
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
      map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

      -- Code actions & refactoring
      map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
      map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
      map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>cA", function()
        vim.lsp.buf.code_action {
          context = { only = { "source" }, diagnostics = {} },
        }
      end, "Source Action")
      map("n", "<leader>cR", function()
        Snacks.rename.rename_file()
      end, "Rename File")

      -- Codelens
      map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, "Run Codelens")
      map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")

      -- Ruff-specific: disable hover in favor of basedpyright, add organize imports
      if client.name == "ruff" then
        client.server_capabilities.hoverProvider = false
        map("n", "<leader>co", function()
          vim.lsp.buf.code_action {
            apply = true,
            context = { only = { "source.organizeImports" }, diagnostics = {} },
          }
        end, "Organize Imports")
      end

      -- Clangd-specific: switch source/header
      if client.name == "clangd" then
        map("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source/Header (C/C++)")
      end
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
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
          },
        },
      },
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
      },
      clangd = {
        root_markers = {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
      },
    }

    for server, server_opts in pairs(servers) do
      vim.lsp.config(
        server,
        vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
        }, server_opts)
      )
      vim.lsp.enable(server)
    end
  end,
}
