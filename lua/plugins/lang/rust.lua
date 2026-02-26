-- rustaceanvim manages rust-analyzer directly.
-- Do NOT add rust_analyzer to lspconfig — it would conflict.
return {
  {
    "rustaceanvim",
    ft = { "rust" },
    before = function()
      -- Ensure blink.cmp is loaded for capabilities
      LZN.trigger_load "blink.cmp"
    end,
    after = function()
      local ok_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if ok_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      vim.g.rustaceanvim = {
        server = {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            map({ "n", "x" }, "<leader>cR", function()
              vim.cmd.RustLsp "codeAction"
            end, "Code Action (Rust)")
            map("n", "<leader>dr", function()
              vim.cmd.RustLsp "debuggables"
            end, "Debuggables (Rust)")
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
              },
              checkOnSave = true,
              check = {
                command = "clippy",
                features = "all",
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "crates.nvim",
    event = { "BufRead Cargo.toml" },
    after = function()
      require("crates").setup {
        completion = {
          crates = { enabled = true },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
  },
}
