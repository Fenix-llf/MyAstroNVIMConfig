---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      features = {
        autopairs = false,
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    enabled = false,
  },
}
