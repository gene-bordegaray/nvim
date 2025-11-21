local group = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  desc = "Format Rust and Lua buffers via Conform",
  pattern = { "*.rs", "*.lua" },
  callback = function(args)
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({
        bufnr = args.buf,
        lsp_fallback = true,
      })
    end
  end,
})

