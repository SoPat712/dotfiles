vim.g.mapleader = " "

-- Visual mode mappings
-- move line up and done, and reformat while moving
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })
--jk to escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
--cool search and replace
vim.keymap.set("n", "<Leader>sr", [[:%s/<C-r><C-w>//g<Left><Left>]], { desc = "[S]earch and [R]eplace" })
--center searches when forward and reverse searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--stop Q from taking over
vim.keymap.set("n", "Q", "<nop>")
--clear search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "[H]ide Search" })
