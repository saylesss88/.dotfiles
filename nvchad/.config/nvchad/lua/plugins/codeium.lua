local codeium = {
	"Exafunction/codeium.vim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		vim.keymap.set("i", "<C-;>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true, noremap = true })
		vim.keymap.set("i", "<c-,>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true, noremap = true })
		vim.keymap.set("i", "<c-.>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true, noremap = true })
		vim.keymap.set("i", "<c-'>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true, noremap = true })
		vim.api.nvim_create_user_command("CodeiumChat", function(opts)
			vim.fn["codeium#Chat"]()
		end, { nargs = "*", desc = "Codeium Chat" })
	end,
}

local neoCodeium = {
	"monkoose/neocodeium",
	event = "VeryLazy",
	enabled = true,
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup({
			enabled = true,
			show_label = true,
			manual = false,
			debounce = true,
			silent = true,
			filetypes = {
				help = false,
				gitcommit = false,
				gitrebase = false,
				["."] = false,
			},
		})
		vim.keymap.set("i", "<c-;>", neocodeium.accept)
		-- vim.keymap.set("i", "<c-'>", neocodeium.cleareium").accept_word()
		-- end)
		vim.keymap.set("i", "<c-l>", neocodeium.accept_line)
		vim.keymap.set("i", "<c-.>", neocodeium.cycle_or_complete)
		vim.keymap.set("i", "<c-,>", function()
			neocodeium.cycle_or_complete(-1)
		end)
		vim.keymap.set("i", "<c-'>", neocodeium.clear)
	end,
}

return {
	codeium,
	neoCodeium,
}
