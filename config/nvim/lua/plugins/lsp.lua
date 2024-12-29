return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v4.x',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/nvim-cmp',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
	},
	config = function()
		local lspZero = require("lsp-zero")
		local cmp = require("cmp")
		local lspconfig = require("lspconfig")
		local lspAttach = function(client, bufnr)
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "ec", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
		end

		lspZero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lspAttach,
			--capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {'lua_ls', 'clangd', 'ts_ls', 'pylsp', 'volar',},
			handlers = {
				function(serverName)
					if serverName == 'ts_ls' then
						local mason_registry = require('mason-registry')
						local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
						lspconfig.ts_ls.setup({
							init_options = {
								plugins = {
									{
										name = '@vue/typescript-plugin',
										location = vue_language_server_path,
										languages = { 'vue' },
									},
								},
							},
							filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
						})
						return
					end
					if serverName == 'jdtls' then
						return
					end
					lspconfig[serverName].setup({})
				end
			}
		})

		cmp.setup({
			sources = {
				{name = 'nvim_lsp'},
				{name = 'buffer'},
			},
			mapping = cmp.mapping.preset.insert({
				['<C-c>'] = cmp.mapping.confirm({select = true}),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
			})
		})
	end,
}
