local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

map({ "n", "v" }, "<leader>w", "<cmd>w<cr>", vim.tbl_extend("force", default_opts, { desc = "Save file" }))
map("n", "<leader>q", "<cmd>confirm q<cr>", vim.tbl_extend("force", default_opts, { desc = "Quit window" }))
map("n", "<leader>Q", "<cmd>confirm qa<cr>", vim.tbl_extend("force", default_opts, { desc = "Quit Neovim" }))

map("n", "<leader>bo", "<cmd>enew<cr>", vim.tbl_extend("force", default_opts, { desc = "New buffer" }))
map("n", "<leader>bd", "<cmd>bd<cr>", vim.tbl_extend("force", default_opts, { desc = "Delete buffer" }))
map("n", "<leader>bp", "<cmd>bprevious<cr>", vim.tbl_extend("force", default_opts, { desc = "Previous buffer" }))
map("n", "<leader>bn", "<cmd>bnext<cr>", vim.tbl_extend("force", default_opts, { desc = "Next buffer" }))

map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

map("n", "<S-h>", "<cmd>bprevious<cr>", default_opts)
map("n", "<S-l>", "<cmd>bnext<cr>", default_opts)

map("n", "<leader>sv", "<cmd>vsplit<cr>", vim.tbl_extend("force", default_opts, { desc = "Vertical split" }))
map("n", "<leader>sh", "<cmd>split<cr>", vim.tbl_extend("force", default_opts, { desc = "Horizontal split" }))

map({ "n", "v" }, "<leader>y", '"+y', vim.tbl_extend("force", default_opts, { desc = "Yank to system" }))
map({ "n", "v" }, "<leader>d", '"_d', vim.tbl_extend("force", default_opts, { desc = "Delete without yank" }))

map("n", "<Esc>", "<cmd>noh<cr>", vim.tbl_extend("force", default_opts, { desc = "Clear highlights" }))

map("i", "kj", "<Esc>", vim.tbl_extend("force", default_opts, { desc = "Exit insert mode" }))

