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
    if ok_blink and blink.get_lsp_capabilities then capabilities = blink.get_lsp_capabilities(capabilities) end

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
