return {

	-- measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 100
		end,
	},

	-- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      -- restore the session for the current directory
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      -- restore the last session
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      -- stop Persistence => session won't be saved on exit
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},

	-- library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },
}
