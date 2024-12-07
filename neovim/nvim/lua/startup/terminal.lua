local fn = require('fn')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
local terminal_bufnr = nil
local terminal_winid = nil

function ToggleTerminal()
    if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
        if terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
            vim.api.nvim_win_hide(terminal_winid)
            terminal_winid = nil
        else
            vim.cmd("split")
            terminal_winid = vim.api.nvim_get_current_win()
            vim.api.nvim_win_set_buf(terminal_winid, terminal_bufnr)
        end
    else
		if fn.OS == "Windows_NT" then
			vim.cmd("split | term powershell")
		else
			vim.cmd("split | term bash")
		end
        terminal_bufnr = vim.api.nvim_get_current_buf()
        terminal_winid = vim.api.nvim_get_current_win()
    end
end

vim.api.nvim_set_keymap('n', '<leader>t', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
