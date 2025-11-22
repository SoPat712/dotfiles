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
					-- Formatters
					"prettier",
					"stylua",
					"isort",
					"black",
					-- Linters
					"eslint_d",
					"pylint",
					-- LSP servers
					"vtsls", -- better TypeScript/JavaScript LSP (or use "typescript-language-server" for ts_ls)
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
			-- 1) Configure diagnostics
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

			-- 2) Set up capabilities
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- 3) Setup LSP servers using vim.lsp.config

			-- TypeScript/JavaScript (using vtsls for better refactoring support)
			vim.lsp.config("vtsls", {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})

			-- HTML
			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			-- Lua
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			-- Go
			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})

			-- Svelte
			vim.lsp.config("svelte", {
				capabilities = capabilities,
			})

			-- Python (Pyright)
			local function get_python_path(workspace)
				-- 1) Workspace-local venv: <workspace>/venv/bin/python
				if workspace and workspace ~= "" then
					local venv_path = vim.fs.joinpath(workspace, "venv", "bin", "python")
					if vim.fn.executable(venv_path) == 1 then
						return venv_path
					end
				end

				-- 2) Active virtualenv, if any
				if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
					local venv_python = vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
					if vim.fn.executable(venv_python) == 1 then
						return venv_python
					end
				end

				-- 3) Fallback to system python
				return "python3"
			end

			vim.lsp.config("pyright", {
				capabilities = capabilities,
				before_init = function(params, config)
					-- Try a few ways to get a sane workspace path
					local workspace = config.root_dir
						or (params.rootUri and vim.uri_to_fname(params.rootUri))
						or vim.loop.cwd()

					config.settings = config.settings or {}
					config.settings.python = config.settings.python or {}

					config.settings.python.analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
					}

					config.settings.python.pythonPath = get_python_path(workspace)
				end,
			})

			-- Rust
			vim.lsp.config("rust_analyzer", {
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {},
				},
			})

			-- C/C++ (clangd)
			vim.lsp.config("clangd", {
				capabilities = capabilities,
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
				root_markers = {
					"Makefile",
					"configure.ac",
					"configure.in",
					"config.h.in",
					"meson.build",
					"meson_options.txt",
					"build.ninja",
					"compile_commands.json",
					"compile_flags.txt",
					".git",
				},
				on_attach = function(client, bufnr)
					-- Optional: clangd extensions setup
					local ok, clangd_ext = pcall(require, "clangd_extensions.inlay_hints")
					if ok then
						clangd_ext.setup_autocmd()
						clangd_ext.set_inlay_hints()
					end
				end,
			})

			-- UFO setup
			require("ufo").setup()

			-- 4) Global LspAttach mappings
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }

					vim.keymap.set(
						"n",
						"<leader>e",
						vim.diagnostic.open_float,
						{ buffer = ev.buf, desc = "Open diagnostic float" }
					)
					vim.keymap.set(
						"n",
						"[d",
						vim.diagnostic.goto_prev,
						{ buffer = ev.buf, desc = "Go to previous diagnostic" }
					)
					vim.keymap.set(
						"n",
						"]d",
						vim.diagnostic.goto_next,
						{ buffer = ev.buf, desc = "Go to next diagnostic" }
					)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
					vim.keymap.set(
						"n",
						"gd",
						require("telescope.builtin").lsp_definitions,
						{ buffer = ev.buf, desc = "Go to definition" }
					)
					vim.keymap.set(
						"n",
						"gr",
						require("telescope.builtin").lsp_references,
						{ buffer = ev.buf, desc = "Go to references" }
					)
					vim.keymap.set(
						"n",
						"gi",
						require("telescope.builtin").lsp_implementations,
						{ buffer = ev.buf, desc = "Go to implementations" }
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
					vim.keymap.set(
						{ "n", "v" },
						"<leader>ca",
						require("actions-preview").code_actions,
						{ buffer = ev.buf, desc = "Code actions" }
					)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf, desc = "Format" })
				end,
			})
		end,
	},
}
