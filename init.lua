require('mason')
require('plugins')

-- configs do editor
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }

vim.g.mapleader = '\\'
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
