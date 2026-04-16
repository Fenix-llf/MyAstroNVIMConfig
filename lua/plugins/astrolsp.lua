-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = function(_, opts)
    local astrocore = require "astrocore"

    opts.servers = vim.tbl_filter(function(server) return server ~= "clangd" end, opts.servers or {})
    opts.servers = astrocore.list_insert_unique(opts.servers, { "pyright" })

    if vim.fn.executable "clangd" == 1 then opts.servers = astrocore.list_insert_unique(opts.servers, { "clangd" }) end

    opts.formatting = opts.formatting or {}
    opts.formatting.format_on_save = { enabled = false }
  end,
}
