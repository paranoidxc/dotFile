return {
	{
		"williamboman/mason.nvim",

		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",

		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},

				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.intelephense.setup({
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
			})

			local mason_registry = require("mason-registry")
			local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"

			-- local lspconfig = require("lspconfig")
			-- local servers = { "tailwindcss", "jsonls", "eslint" }
			-- local servers = { "jsonls", "eslint" }
			-- for _, lsp in pairs(servers) do
			-- 	lspconfig[lsp].setup({
			-- 		-- on_attach = on_attach,
			-- 		capabilites = capabilities,
			-- 	})
			-- end

			lspconfig.ts_ls.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			lspconfig.volar.setup({
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "json" },
			})

			-- lspconfig.volar.setup({
			-- 	filetypes = { "typescript", "javascript", "vue" },
			-- 	capabilities = capabilities,
			-- })

			-- lspconfig.vtsls.setup({
			-- 	capabilities = capabilities,
			-- })

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})
		end,
	},
}
