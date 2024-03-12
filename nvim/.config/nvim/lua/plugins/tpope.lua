return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>Git<Cr>", {})
		end,
	},
	{
		"tpope/vim-surround",
	},
	{
		"tpope/vim-commentary",
	},
	-- {
	-- 	"tpope/vim-sleuth",
	-- },
}
