local kmap = vim.keymap

kmap.set("n", "<leader>sv", "<CMD>vsplit<CR>", { desc = "vertical split" })
kmap.set("n", "<leader>sh", "<CMD>split<CR>", { desc = "horizontal split" })

kmap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format" })
kmap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" })
kmap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "rename" })

kmap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

kmap.set("n", "<leader>q", vim.diagnostic.open_float, { desc = "open diagnostics" })
