return {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        transparent = true,
    },
    init = function()
        -- Load the colorscheme here.
        vim.cmd.colorscheme("eldritch")
    end,
}
