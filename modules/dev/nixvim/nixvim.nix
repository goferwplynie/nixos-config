{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    extraPackages = [pkgs.go];

    imports = [
      ./modules/colorschemes/catppuccin.nix

      ./modules/plugins/common.nix
      ./modules/plugins/presence.nix
      ./modules/plugins/treesitter.nix
      ./modules/plugins/blink.nix
      ./modules/plugins/conform.nix
      ./modules/plugins/lsp.nix
      ./modules/plugins/telescope.nix
      ./modules/plugins/trouble.nix

      ./modules/options.nix
      ./modules/keymaps.nix
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };

    clipboard = {
      providers = {
        wl-copy.enable = true;
      };

      register = "unnamedplus";
    };

    diagnostic = {
      virtual_lines = {
        current_line = true;
      };

      virtual_text = true;
    };
  };
}
