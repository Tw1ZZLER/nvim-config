return {
  "clangd_extensions.nvim",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  after = function()
    require("clangd_extensions").setup {
      inlay_hints = {
        inline = true,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          statement = "",
          specifier = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    }
  end,
}
