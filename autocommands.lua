local api = vim.api

api.nvim_create_autocmd({ "UIEnter" }, {
  pattern = "*",
  group = api.nvim_create_augroup("firenvim_open", { clear = true }),
  callback = function()
    vim.o.showtabline = 0
    vim.o.lines = math.max(vim.o.lines, 20)
  end,
})
