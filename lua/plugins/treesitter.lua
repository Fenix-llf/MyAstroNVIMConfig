local parser_install_dir = vim.fn.stdpath "config" .. "/.treesitter"

local function tree_sitter_cli_works()
  local exe = vim.fn.exepath "tree-sitter"
  if exe == "" then return false end

  local ok, result = pcall(function() return vim.system({ exe, "--version" }, { text = true }):wait(1000) end)
  return ok and result and result.code == 0
end

local core_parsers = {
  "bash",
  "c",
  "html",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "vim",
  "vimdoc",
}

local function prepend_path(path)
  if not vim.uv.fs_stat(path) then return end
  local path_separator = package.config:sub(1, 1) == "\\" and ";" or ":"
  local current_path = vim.env.PATH or ""
  if not vim.list_contains(vim.split(current_path, path_separator, { plain = true }), path) then
    vim.env.PATH = path .. path_separator .. current_path
  end
end

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if vim.uv.fs_stat(parser_install_dir) then opts.install_dir = parser_install_dir end
    end,
  },
  {
    "AstroNvim/astrocore",
    init = function() prepend_path(vim.fn.stdpath "data" .. "/mason/bin") end,
    ---@param opts AstroCoreOpts
    opts = function(_, opts)
      local cli_ok = tree_sitter_cli_works()

      opts.treesitter = opts.treesitter or {}
      opts.treesitter.highlight = true
      opts.treesitter.indent = true
      opts.treesitter.auto_install = cli_ok
      opts.treesitter.ensure_installed = cli_ok and core_parsers or {}
    end,
  },
}
