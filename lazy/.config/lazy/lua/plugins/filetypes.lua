local kitty = {
	{ "fladson/vim-kitty", ft = { "kitty" } },
}

local log = {
	{ "mtdl9/vim-log-highlighting", ft = { "log" } },
}

local markdown = {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			local home = os.getenv("HOME")
			vim.g.mkdp_markdown_css = home .. "/.config/nvim/style/markdown.css"
			vim.g.mkdp_highlight_css = home .. "/.config/nvim/style/highlight.css"
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_auto_close = 1
		end,
	},
	{
		"Kicamon/markdown-table-mode.nvim",
		ft = { "markdown" },
		config = function()
			require("markdown-table-mode").setup()
		end,
	},
}

local yaml = {
	"cuducos/yaml.nvim",
	ft = { "yaml" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
	},
}
local kitty_nav = {
	"knubie/vim-kitty-navigator",
	ft = { "kitty" },
	init = function()
		vim.g.kitty_navigator_no_mappings = 1
	end,
}

local help_view = {
	"OXY2DEV/helpview.nvim",
	-- lazy = false, -- Recommended

	-- In case you still want to lazy load
	ft = "help",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}

local scrollback = {
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = true,
	lazy = true,
	cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
	event = { "User KittyScrollbackLaunch" },
	-- version = '*', -- latest stable version, may have breaking changes if major version changed
	-- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
	config = function()
		require("kitty-scrollback").setup()
	end,
}

return {
	kitty,
	kitty_nav,
	scrollback,
	-- typst,
	log,
	pkl,
	markdown,
	yaml,
	help_view,
}
