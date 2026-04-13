---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        markdown_local_settings = {
          {
            event = "FileType",
            pattern = "markdown",
            desc = "Markdown editing experience",
            callback = function(args)
              local opt = vim.opt_local
              opt.wrap = true
              opt.linebreak = true
              opt.spell = true
              opt.conceallevel = 2
              opt.textwidth = 0

              vim.keymap.set("n", "<Leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", {
                buffer = args.buf,
                desc = "Toggle Markdown browser preview",
              })
              vim.keymap.set("n", "<Leader>mr", "<Cmd>RenderMarkdown buf_toggle<CR>", {
                buffer = args.buf,
                desc = "Toggle Markdown render",
              })
            end,
          },
        },
      },
      mappings = {
        n = {
          ["<Leader>m"] = { desc = "Markdown" },
        },
      },
    },
  },
}
