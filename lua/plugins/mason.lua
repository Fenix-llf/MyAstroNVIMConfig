-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "clangd",

        "stylua",
        "debugpy",
        "tree-sitter-cli",
      },
    },
  },
}
