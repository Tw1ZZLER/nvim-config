-- nvim-jdtls manages jdtls directly.
-- Do NOT add jdtls to lspconfig — it would conflict.
return {
  "nvim-jdtls",
  ft = "java",
  after = function()
    local ok_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if ok_blink and blink.get_lsp_capabilities then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    -- Workspace directory per-project (based on project root)
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath "data" .. "/jdtls-workspace/" .. project_name

    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Java-specific extract refactoring
      map("n", "<leader>cxv", function()
        require("jdtls").extract_variable()
      end, "Extract Variable")
      map("x", "<leader>cxv", function()
        require("jdtls").extract_variable(true)
      end, "Extract Variable")
      map("n", "<leader>cxc", function()
        require("jdtls").extract_constant()
      end, "Extract Constant")
      map("x", "<leader>cxc", function()
        require("jdtls").extract_constant(true)
      end, "Extract Constant")
      map("x", "<leader>cxm", function()
        require("jdtls").extract_method(true)
      end, "Extract Method")

      -- Java-specific goto
      map("n", "<leader>cgs", function()
        require("jdtls").super_implementation()
      end, "Goto Super")

      -- Organize imports
      map("n", "<leader>co", function()
        require("jdtls").organize_imports()
      end, "Organize Imports")
    end

    -- Configure jdtls via autocmd (attaches when Java buffer opens)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        require("jdtls").start_or_attach {
          cmd = { "jdtls", "-data", workspace_dir },
          root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
          capabilities = capabilities,
          on_attach = on_attach,
          settings = {
            java = {
              inlayHints = { parameterNames = { enabled = "all" } },
              referencesCodeLens = { enabled = true },
              implementationsCodeLens = { enabled = true },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
        }
      end,
    })
  end,
}
