---@type vim.lsp.Config
return {
	cmd = { "nixd" },
	root_markers = { "flake.nix", ".git" },
	filetypes = { "nix" },
	settings = {
    	nixd = {
      		formatting = {
        		command = { "nixfmt" },
      		},
      		options = {
        	nixos = {
            		expr = '(builtins.getFlake "/home/gofer/dotfiles").nixosConfigurations.nixos.options',
        	},
        	home_manager = {
            		expr = '(builtins.getFlake "/home/gofer/dotfiles").homeConfigurations."gofer".options',
        	},
      },
    },
  },
}
