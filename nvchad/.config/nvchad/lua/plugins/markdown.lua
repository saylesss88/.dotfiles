return {
  {
    'MeanderingProgrammer/markdown.nvim',
    event = 'VeryLazy',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- Mandatory
      'nvim-tree/nvim-web-devicons', -- Optional but recommended
    },
    config = function()
      require('render-markdown').setup {}
    end,
  },
  { 'ellisonleao/glow.nvim', config = true, cmd = 'Glow' },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    opts = {
      on_attach = function(bufnr)
        local function toggle(key)
          return "<Esc>gv<Cmd>lua require'markdown.inline'" .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
        end

        vim.keymap.set('x', '<C-b>', toggle 'b', { buffer = bufnr })
        vim.keymap.set('x', '<C-i>', toggle 'i', { buffer = bufnr })
      end,
    },
  },
}
