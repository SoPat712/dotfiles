return {
	"leafOfTree/vim-svelte-plugin",
	ft = "svelte",
	config = function()
		-- Enable TypeScript support within Svelte files
		vim.g.vim_svelte_plugin_use_typescript = 1
		-- Enable folding based on syntax
		vim.g.vim_svelte_plugin_use_foldexpr = 1
	end,
}
