return {
  capabilities = capabilities,
  cmd = { "gopls" },
  root_markers = { "go.work", "go.mod", ".git" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      usePlaceholders = true,
      gofumpt = true,
    }
  }
}
