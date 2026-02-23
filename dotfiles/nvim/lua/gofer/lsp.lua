local servers = {
	"lua_ls",
	"nixd"
}

for _, server in ipairs(servers) do
	vim.lsp.config[server] = {
		capabilities = capabilities
	}
end

vim.lsp.enable(servers)
