return {
	"andymass/vim-matchup",
	event = "BufReadPost",
	config = function()
		-- Enable match-up's matchparen module
		vim.g.matchup_matchparen_enabled = 1

		-- Configure offscreen match highlighting
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
}
