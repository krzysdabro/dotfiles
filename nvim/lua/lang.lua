function setTabSize(tabsize, expand)
  vim.bo[0].tabstop = tabsize
  vim.bo[0].softtabstop = tabsize
  vim.bo[0].shiftwidth = tabsize
  vim.bo[0].expandtab = expand
end
