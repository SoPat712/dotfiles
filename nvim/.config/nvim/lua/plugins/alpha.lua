return {
	"goolord/alpha-nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                                                                       ]],
			[[  ██████   █████                   █████   █████  ███                  ]],
			[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
			[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
			[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
			[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
			[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
			[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
			[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
			[[                                                                       ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", "<cmd>ene <CR>"),
			dashboard.button("SPC f f", "󰈞  Find file"),
			dashboard.button("SPC f b", "  File Browser"),
			dashboard.button("SPC o f", "󰊄  Recently opened files"),
			dashboard.button("SPC l g", "󰈬  Find word"),
			dashboard.button("SPC l a", "💤 Lazy", ":Lazy<CR>"),
			dashboard.button("SPC q a", "󰅚  Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
