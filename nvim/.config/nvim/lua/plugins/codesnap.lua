return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	lazy = false,
	config = function()
		require("codesnap").setup({
			mac_window_bar = true, -- macOS-style title bar
			watermark = "", -- no watermark
			has_line_number = true, -- show line numbers
			has_breadcrumbs = false, -- disable breadcrumbs
			show_workspace = false, -- disable workspace name
			bg_theme = "sea", -- background theme
			code_font_family = "SauceCodePro Nerd Font", -- your preferred font
			save_path = "~/Pictures", -- save directory
		})
	end,
}
