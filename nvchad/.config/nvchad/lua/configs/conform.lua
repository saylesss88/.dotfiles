local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc', 'inject' },
    sh = { 'shfmt' },
    go = { 'goimports', 'gofmt' },
    -- css = { "prettier" },
    -- html = { "prettier" },
 -- You can use a function here to determine the formatters dynamically
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
  },

   format_on_save = {
     -- These options will be passed to conform.format()
     timeout_ms = 500,
     lsp_fallback = true,
   },
}

require("conform").setup(options)
