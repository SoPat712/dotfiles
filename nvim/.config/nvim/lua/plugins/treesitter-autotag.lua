return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
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
