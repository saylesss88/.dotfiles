return {
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- Mandatory
      "nvim-tree/nvim-web-devicons", -- Optional but recommended
    },
    config = function()
      require("render-markdown").setup({})
    end,
  },

  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      on_attach = function(bufnr)
        local function toggle(key)
          return "<Esc>gv<Cmd>lua require'markdown.inline'"
            .. ".toggle_emphasis_visual'"
            .. key
            .. "'<CR>"
        end

        vim.keymap.set("x", "<C-b>", toggle("b"), { buffer = bufnr })
        vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
        vim.keymap.set("x", "<C-c>", toggle("c"), { buffer = bufnr })
        vim.keymap.set("x", "<C-t>", toggle("s"), { buffer = bufnr })
      end,
    },
  },
  {
    "Kicamon/markdown-table-mode.nvim",
    ft = { "markdown" },
    config = function()
      require("markdown-table-mode").setup()
    end,
  },

  { "ellisonleao/glow.nvim", ft = "markdown", config = true, cmd = "Glow" },
  {

    "dhananjaylatkar/notes.nvim",
    cmd = { "NotesNew", "NotesFind", "NotesGrep" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      root = vim.fn.expand("$HOME/notes/2nd_brain"),
    },
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    config = function()
      require("mkdnflow").setup({
        -- Config goes here; leave blank for defaults
        mappings = {
          MkdnGoBack = { "n", "<leader>b" },
          -- MkdnGoForward = false,
        },
        foldtext = {
          title_transformer = function()
            local function my_title_transformer(text)
              local updated_title = text:gsub("%b{}", "")
              updated_title = updated_title:gsub("^%s*", "")
              updated_title = updated_title:gsub("%s*$", "")
              updated_title = updated_title:gsub("^######", "░░░░░▓")
              updated_title = updated_title:gsub("^#####", "░░░░▓▓")
              updated_title = updated_title:gsub("^####", "░░░▓▓▓")
              updated_title = updated_title:gsub("^###", "░░▓▓▓▓")
              updated_title = updated_title:gsub("^##", "░▓▓▓▓▓")
              updated_title = updated_title:gsub("^#", "▓▓▓▓▓▓")
              return updated_title
            end
            return my_title_transformer
          end,
          object_count_icon_set = "nerdfont", -- Use/fall back on the nerdfont icon set
          object_count_opts = function()
            local opts = {
              link = false, -- Prevent links from being counted
              blockquote = { -- Count block quotes (these aren't counted by default)
                icon = " ",
                count_method = {
                  pattern = { "^>.+$" },
                  tally = "blocks",
                },
              },
              fncblk = {
                -- Override the icon for fenced code blocks with 
                icon = " ",
              },
            }
            return opts
          end,
          line_count = false, -- Prevent lines from being counted
          word_count = true, -- Count the words in the section
          fill_chars = {
            left_edge = "╾─🖿 ─",
            right_edge = "──╼",
            item_separator = " · ",
            section_separator = " // ",
            left_inside = " ┝",
            right_inside = "┥ ",
            middle = "─",
          },
        },
        -- Other config options
      })
    end,
  },
}
