return {
	"mistricky/codesnap.nvim",
	lazy = "true",
	build = "make",
	cmd = "CodeSnapPreviewOn",
	config = function()
		require("codesnap").setup({
			mac_window_bar = true, -- (Optional) MacOS style title bar switch
			opacity = true, -- (Optional) The code snap has some opacity by default, set it to false for 100% opacity
			watermark = "joshp", -- (Optional) you can custom your own watermark, but if you don't like it, just set it to ""
			preview_title = "CodeSnap.nvim", -- (Optional) preview page title
			bg_theme = "summer",
			has_line_number = true,
		})
	end,
}
