-- haskell-tools.nvim manages HLS (Haskell Language Server) directly.
-- Do NOT add hls to lspconfig — it would conflict.
return {
  {
    "haskell-tools.nvim",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    after = function()
      local ok_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if ok_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      local ht = require "haskell-tools"

      vim.g.haskell_tools = {
        hls = {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            -- Haskell-specific keymaps (using localleader = ,)
            map("n", "<localleader>e", function() ht.lsp.buf_eval_all() end, "Evaluate All")
            map("n", "<localleader>h", function() ht.hoogle.hoogle_signature() end, "Hoogle Signature")
            map("n", "<localleader>r", function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, "REPL (Buffer)")
            map("n", "<localleader>R", function() ht.repl.toggle() end, "REPL (Package)")
          end,
        },
      }
    end,
  },
  {
    "haskell-snippets.nvim",
    ft = { "haskell", "lhaskell" },
    before = function()
      LZN.trigger_load "luasnip"
    end,
    after = function()
      local ok, haskell_snippets = pcall(require, "haskell-snippets")
      if ok then
        local ls = require "luasnip"
        ls.add_snippets("haskell", haskell_snippets.all, { key = "haskell" })
      end
    end,
  },
}
