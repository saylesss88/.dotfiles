return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {
      columns = { "icon" },
      skip_confirm_for_simple_edits = true,
      float = {
        border = "none",
      },
      keymaps = {
        ["<C-v>"] = "actions.select_split",
        ["q"] = "actions.close",
        ["<C-y>"] = "actions.copy_entry_path",
      },
      view_options = {
        show_hidden = true,
      },
    }

    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>")

    -- Open parent directory in floating window
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
  end,
}
