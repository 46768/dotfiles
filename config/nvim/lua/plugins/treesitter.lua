return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {"lua", "c", "java", "python"},
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
