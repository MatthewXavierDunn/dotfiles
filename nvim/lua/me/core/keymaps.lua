-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- general key maps

-- remove highlighting for search
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- number increment
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- window managament
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")
keymap.set("n", "<leader>w", "<C-w>w")

-- tab management
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- plugin key maps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- easy-align
keymap.set("x", "ga", "<Plug>(EasyAlign)")
keymap.set("n", "ga", "<Plug>(EasyAlign)")

-- buffer key maps
keymap.set("n", "<leader>d", ":bd<CR>")
keymap.set("n", "<leader>[", "[b")
keymap.set("n", "<leader>]", "]b")
