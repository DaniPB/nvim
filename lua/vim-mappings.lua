vim.g.mapleader = " " -- easy to reach leader key
vim.keymap.set("n", "-", vim.cmd.Ex) -- need nvim 0.8+

vim.cmd [[command! -nargs=0 Nws %s/\s\+$//g]]
vim.cmd [[command! -nargs=0 Nwl g/^$/d]]
vim.cmd [[command! -nargs=0 Nai set noautoindent]]
vim.cmd [[command! -nargs=0 Removetabs %s/^I/  /g]]
vim.cmd [[command! -nargs=0 FormatJSON %!jq .]]

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand("%"))
end, { desc = "Copy current file path to clipboard" })

vim.keymap.set('n', '<leader>cl', function()
  vim.fn.setreg('+', vim.fn.expand("%") .. ":" .. vim.fn.line("."))
end, { desc = "Copy current file path with line number to clipboard" })

-- JBuilder files sintaxt highlighting
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.jbuilder",
  command = "set filetype=ruby",
})
