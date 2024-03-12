return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		local config = require("nvim-ts-autotag")
		config.setup({
			filetypes = {
				"html",
				"xml",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
				"vue",
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
