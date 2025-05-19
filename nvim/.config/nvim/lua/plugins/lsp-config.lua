return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter
					"isort", -- python formatter
					"black", -- python formatter
					"pylint", -- python linter
					"eslint_d", -- js linter
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		-- This table is used in the config function (below) for vim.diagnostic.config()
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = false,
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "✖ ",
						[vim.diagnostic.severity.WARN] = "⚠ ",
						[vim.diagnostic.severity.HINT] = "➤ ",
						[vim.diagnostic.severity.INFO] = "ℹ ",
					},
				},
			},
			inlay_hints = {
				enabled = true,
			},
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
		},
		config = function(_, opts)
			-- 1) Use opts.diagnostics to configure diagnostic signs
			local diag = opts.diagnostics or {}
			if diag.signs and diag.signs.text then
				local sign_config = {}
				for severity, icon_text in pairs(diag.signs.text) do
					sign_config[severity] = { text = icon_text }
				end
				vim.diagnostic.config({
					signs = { severity = sign_config },
					virtual_text = diag.virtual_text,
					underline = diag.underline,
					severity_sort = diag.severity_sort,
					update_in_insert = diag.update_in_insert,
				})
			end

			-- 2) Set up capabilities and each LSP
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			local lspconfig = require("lspconfig")

			-- Example LSPs
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.svelte.setup({
				capabilities = capabilities,
			})

			-- Python example
			local function get_python_path(workspace)
				-- Use a pattern to find the venv path in the workspace directory
				local venv_path = lspconfig.util.path.join(workspace, "venv", "bin", "python")
				return venv_path
			end
			lspconfig.pyright.setup({
				capabilities = capabilities,
				before_init = function(_, config)
					config.settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
							pythonPath = get_python_path(config.root_dir),
						},
					}
				end,
				on_attach = function(client, bufnr)
					-- Optional: additional setup such as key mappings, etc.
				end,
			})

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {},
				},
			})

			-- C/C++ (clangd)
			lspconfig.clangd.setup({
				capabilities = capabilities,
				init_options = {
					clangdFileStatus = true,
					usePlaceholders = true,
					completeUnimported = true,
					semanticHighlighting = true,
				},
				on_attach = function(client, bufnr)
					require("clangd_extensions.inlay_hints").setup_autocmd()
					require("clangd_extensions.inlay_hints").set_inlay_hints()
				end,
				cmd = {
					"clangd",
					"--background-index",
					"--pch-storage=memory",
					"--clang-tidy",
					"--all-scopes-completion",
					"--pretty",
					"--header-insertion=iwyu",
					"--fallback-style={ BasedOnStyle: Google, ColumnLimit: 0 }",
					"-j=12",
					"--header-insertion-decorators",
				},
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern(
						"Makefile",
						"configure.ac",
						"configure.in",
						"config.h.in",
						"meson.build",
						"meson_options.txt",
						"build.ninja"
					)(fname) or require("lspconfig.util").root_pattern(
						"compile_commands.json",
						"compile_flags.txt"
					)(fname) or require("lspconfig.util").find_git_ancestor(fname)
				end,
			})

			-- UFO setup
			require("ufo").setup()

			-- 3) Global LspAttach mappings
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = "Go to declaration" })
					vim.keymap.set(
						"n",
						"gd",
						require("telescope.builtin").lsp_definitions,
						opts,
						{ desc = "Go to definition" }
					)
					vim.keymap.set(
						"n",
						"gr",
						require("telescope.builtin").lsp_references,
						opts,
						{ desc = "Go to references" }
					)
					vim.keymap.set(
						"n",
						"gi",
						require("telescope.builtin").lsp_implementations,
						opts,
						{ desc = "Go to implementations" }
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = "Rename" })
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						require("actions-preview").code_actions,
						opts,
						{ desc = "Code actions" }
					)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts, { desc = "Format" })
				end,
			})
		end,
	},
}
