-- Customize Mason

---@type LazySpec
return {
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = false,
  },
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua-language-server",
        "pyright",
        "debugpy",
      }

      opts.auto_update = false
      opts.run_on_start = false
    end,
  },
}
