return {
	{
		"aznhe21/actions-preview.nvim",
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			local fb_actions = require("telescope._extensions.file_browser.actions")

			require("telescope").setup({
				vim.keymap.set("n", "<leader>sn", function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" }),
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						mappings = {
							["i"] = {
								["<A-c>"] = fb_actions.create,
								["<S-CR>"] = fb_actions.create_from_prompt,
								["<A-r>"] = fb_actions.rename,
								["<A-m>"] = fb_actions.move,
								["<A-y>"] = fb_actions.copy,
								["<A-d>"] = fb_actions.remove,
								["<A-o>"] = fb_actions.open,
								["<A-p>"] = fb_actions.goto_parent_dir,
								["<A-w>"] = fb_actions.goto_cwd,
								["<A-t>"] = fb_actions.change_cwd,
								["<A-f>"] = fb_actions.toggle_browser,
								["<A-h>"] = fb_actions.toggle_hidden,
								["<A-s>"] = fb_actions.toggle_all,
								["<bs>"] = fb_actions.backspace,
							},
							["n"] = {
								["c"] = fb_actions.create,
								["r"] = fb_actions.rename,
								["m"] = fb_actions.move,
								["y"] = fb_actions.copy,
								["d"] = fb_actions.remove,
								["o"] = fb_actions.open,
								["g"] = fb_actions.goto_parent_dir,
								["e"] = fb_actions.goto_home_dir,
								["w"] = fb_actions.goto_cwd,
								["t"] = fb_actions.change_cwd,
								["f"] = fb_actions.toggle_browser,
								["h"] = fb_actions.toggle_hidden,
								["s"] = fb_actions.toggle_all,
							},
						},
					},
					undo = {
						side_by_side = true,
						diff_context_lines = 8,
						layout_strategy = "horizontal",
						layout_config = {
							preview_width = 0.65,
							preview_cutoff = 0,
						},
						mappings = {
							i = {
								["<C-y>a"] = function(prompt_bufnr)
									local base = require("telescope-undo.actions").yank_additions(prompt_bufnr)
									local function with_notif()
										res = base()
										notif({ "Copied " .. #res .. " lines to the clipboard" })
									end
									return with_notif
								end,
								["<C-y>d"] = function(prompt_bufnr)
									local base = require("telescope-undo.actions").yank_deletions(prompt_bufnr)
									local function with_notif()
										res = base()
										notif({ "Copied " .. #res .. " lines to the clipboard" })
									end
									return with_notif
								end,
								["<C-r>"] = require("telescope-undo.actions").restore,
							},
							n = {
								["A"] = require("telescope-undo.actions").yank_additions,
								["D"] = require("telescope-undo.actions").yank_deletions,
								["<CR>"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
			})
			require("telescope").load_extension("ui-select")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {})
			vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<CR>", {})
			vim.keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<CR>", {})
			vim.keymap.set("n", "<leader>ls", "<cmd>Telescope grep_string<CR>", {})
			vim.keymap.set("n", "<leader>of", "<cmd>Telescope oldfiles<CR>", {})
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", {})
			vim.keymap.set("n", "<leader>ut", "<cmd>Telescope undo<CR>", {})
		end,
	},
}
