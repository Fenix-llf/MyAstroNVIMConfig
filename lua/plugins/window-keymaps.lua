local function focus_new_split(cmd)
  local previous_wins = {}

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    previous_wins[win] = true
  end

  vim.cmd(cmd)

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if not previous_wins[win] then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["<Leader><Left>"] = { "<C-w>h", desc = "Move to left window" },
        ["<Leader><Down>"] = { "<C-w>j", desc = "Move to lower window" },
        ["<Leader><Up>"] = { "<C-w>k", desc = "Move to upper window" },
        ["<Leader><Right>"] = { "<C-w>l", desc = "Move to right window" },
        ["s<Left>"] = { function() focus_new_split "leftabove vsplit" end, desc = "Split left" },
        ["s<Down>"] = { function() focus_new_split "rightbelow split" end, desc = "Split down" },
        ["s<Up>"] = { function() focus_new_split "leftabove split" end, desc = "Split up" },
        ["s<Right>"] = { function() focus_new_split "rightbelow vsplit" end, desc = "Split right" },
      },
    },
  },
}
