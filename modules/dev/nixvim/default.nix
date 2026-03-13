{inputs, ... }: 
let
  flakePath = "/home/gofer/.config/home-manager";
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim	
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin.enable = true;

    globals.mapleader = " ";

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      oil.enable = true;
      
      blink-cmp = {
        enable = true;
        settings.sources.default = [ "lsp" "path" "snippets" "buffer" ];
      };

      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          gopls.enable = true;
          jdtls.enable = true;
          nixd = {
            enable = true;
            settings.options = {
              nixos.expr = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.szkolny.options";
              home_manager.expr = "(builtins.getFlake \"${flakePath}\").homeConfigurations.gofer.options";
              nixvim.expr = "(builtins.getFlake \"${flakePath}\").homeConfigurations.gofer.options.programs.nixvim";
            };
          };
        };
      };
    };
  };
}
