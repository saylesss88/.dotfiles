return {
	"nvim-lua/plenary.nvim",

	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
	},

	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	"nvchad/volt",
	"nvchad/minty",
	"nvchad/menu",

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},
	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },

	{
		"nvimdev/dashboard-nvim",
		lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
		opts = function()
			local logo = [[
⠀⠀⠀⠀⠀⠀⠀⣠⡤⠶⡄⠀⠀⠀⠀⠀⠀⠀⢠⠶⣦⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣴⣿⡟⠀⠈⣀⣾⣝⣯⣿⣛⣷⣦⡀⠀⠈⢿⣿⣦⡀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣿⣿⡇⠀⢼⣿⣽⣿⢻⣿⣻⣿⣟⣷⡄⠀⢸⣿⣿⣾⣄⠀⠀⠀
⠀⠀⣞⣿⣿⣿⣿⣷⣤⣸⣟⣿⣿⣻⣯⣿⣿⣿⣿⣀⣴⣿⣿⣿⣿⣯⣆⠀⠀
⠀⡼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣜⡆⠀
⢠⣟⣯⣿⣿⣿⣷⢿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣟⠿⣿⣿⣿⣿⡷⣾⠀
⢸⣯⣿⣿⡏⠙⡇⣾⣟⣿⡿⢿⣿⣿⣿⣿⣿⢿⣟⡿⣿⠀⡟⠉⢹⣿⣿⢿⡄
⢸⣯⡿⢿⠀⠀⠱⢈⣿⢿⣿⡿⣏⣿⣿⣿⣿⣿⣿⣿⣿⣀⠃⠀⢸⡿⣿⣿⡇
⢸⣿⣇⠈⢃⣴⠟⠛⢉⣸⣇⣹⣿⣿⠚⡿⣿⣉⣿⠃⠈⠙⢻⡄⠎⠀⣿⡷⠃
⠈⡇⣿⠀⠀⠻⣤⠠⣿⠉⢻⡟⢷⣝⣷⠉⣿⢿⡻⣃⢀⢤⢀⡏⠀⢠⡏⡼⠀
⠀⠘⠘⡅⠀⣔⠚⢀⣉⣻⡾⢡⡾⣻⣧⡾⢃⣈⣳⢧⡘⠤⠞⠁⠀⡼⠁⠀⠀
⠀⠀⠀⠸⡀⠀⢠⡎⣝⠉⢰⠾⠿⢯⡘⢧⡧⠄⠀⡄⢻⠀⠀⠀⢰⠁⠀⠀⠀
⠀⠀⠀⠀⠁⠀⠈⢧⣈⠀⠘⢦⠀⣀⠇⣼⠃⠰⣄⣡⠞⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢤⠼⠁⠀⠀⠳⣤⡼⠀⠀⠀⠀⠀⠀
    ]]

			logo = string.rep("\n", 2) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
					center = {
						{
							action = "Telescope find_files",
							desc = " Find File",
							icon = " ",
							key = "f",
						},
						{
							action = "ene | startinsert",
							desc = " New File",
							icon = " ",
							key = "n",
						},
						{
							action = "Telescope oldfiles",
							desc = " Recent Files",
							icon = " ",
							key = "r",
						},
						{
							action = "Telescope live_grep",
							desc = " Find Text",
							icon = " ",
							key = "g",
						},
						{
							action = "Telescope find_files cwd=~/.config/nvim",
							desc = " Config",
							icon = " ",
							key = "c",
						},
						{
							action = 'lua require("persistence").load()',
							desc = " Restore Session",
							icon = " ",
							key = "s",
						},
						{ action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
						{ action = "Mason", desc = " Mason", icon = "M ", key = "m" },
						{
							action = function()
								vim.api.nvim_input("<cmd>qa<cr>")
							end,
							desc = " Quit",
							icon = " ",
							key = "q",
						},
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}

			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end

			if vim.o.filetype == "lazy" then
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					once = true,
					callback = function()
						vim.schedule(function()
							vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
						end)
					end,
				})
			end

			return opts
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		event = { "BufReadPre", "BufNewFile" },
		branch = "0.10",
		enabled = true,
		init = function()
			vim.opt.number = true
			vim.opt.relativenumber = true
		end,
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				setopt = true,
				relculright = true,
				ft_ignore = {
					"aerial",
					"neo-tree",
					"undotree",
				},
				bt_ignore = {
					"terminal",
				},
				segments = {
					{
						sign = {
							namespace = { ".*" },
							name = { ".*" },
						},
						condition = { is_not_neominimap },
					},
					{
						text = {
							builtin.lnumfunc,
							" ",
							builtin.foldfunc,
						},
						condition = { is_not_neominimap },
					},
					{
						sign = {
							namespace = { "gitsigns_" },
						},
						condition = { is_not_neominimap },
					},
					{
						sign = {
							namespace = { "neominimap_search", "neominimap_mark" },
							-- name = { ".*" },
							maxwidth = 1,
							colwidth = 1,
						},
						condition = { is_neominimap },
					},
					{
						sign = {
							namespace = { "neominimap_git" },
							maxwidth = 1,
							colwidth = 2,
						},
						condition = { is_neominimap },
					},
				},
			}
		end,
	},
	{
		"stevearc/dressing.nvim",
		enabled = true,
		event = "VeryLazy",
		config = function()
			require("plugins.configs.dressing")
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		version = ">=1.0.0",
		config = function()
			require("smart-splits").setup()
		end,
	},
	{
		"kwkarlwang/bufresize.nvim",
		event = "UiEnter",
		config = function()
			require("plugins.configs.bufresize")
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		enabled = true,
		event = "VimEnter",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("ufo").setup()
		end,
	},
	{
		"folke/zen-mode.nvim",
		enabled = true,
		cmd = "ZenMode",
		config = function()
			require("plugins.configs.zenmode")
		end,
	},
	{
		"folke/twilight.nvim",
		enabled = true,
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		config = function()
			require("plugins.configs.twilight")
		end,
	},
	{ "Bekaboo/deadcolumn.nvim", lazy = false },
}
