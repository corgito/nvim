vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>rc', ':vsplit ~/.config/nvim<CR>',{noremap = true})

vim.keymap.set('n', '<leader>r', ':setlocal spell! spelllang=en_us<CR>',{noremap = true})

vim.keymap.set('n', '<leader>g', ':Goyo<cr>')
