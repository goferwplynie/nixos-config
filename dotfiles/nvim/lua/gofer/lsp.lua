local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
	"lua_ls",
	"nixd",
	"gopls"
}

for _, server in ipairs(servers) do
	vim.lsp.config[server] = {
		capabilities = capabilities
	}
end

vim.lsp.enable(servers)
