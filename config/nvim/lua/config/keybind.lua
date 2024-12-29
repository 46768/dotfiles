vim.keymap.set("n", "<Leader>pv", vim.cmd.Neotree)
vim.keymap.set("n", "<Leader>qq", "<cmd>q<cr>")
vim.keymap.set("n", "<Leader>ww", "<cmd>w<cr>")
vim.keymap.set("n", "<Leader>gs", "<cmd>Git<cr>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
