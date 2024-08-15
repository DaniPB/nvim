vim.g.mapleader = " " -- easy to reach leader key
vim.keymap.set("n", "-", vim.cmd.Ex) -- need nvim 0.8+

vim.cmd [[command! -nargs=0 Nws %s/\s\+$//g]]
vim.cmd [[command! -nargs=0 Nwl g/^$/d]]
vim.cmd [[command! -nargs=0 Nai set noautoindent]]
vim.cmd [[command! -nargs=0 Removetabs %s/^I/  /g]]
vim.cmd [[command! -nargs=0 FormatJSON %!jq .]]

-- Define a function to get the current file path
function get_current_file_path()
    return vim.fn.expand('%:p')
end

-- Map a key to print and copy the current file path to the clipboard
vim.api.nvim_set_keymap('n', '<leader>fp', [[:lua print(get_current_file_path())<CR>:let @+=get_current_file_path()<CR>]], {noremap = true, silent = true})
