{pkgs, ...}: let
  flakePath = "/home/gofer/.config/home-manager";
in {
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls.enable = true;
        nextls.enable = true;
        gopls = {
          enable = true;
          package = pkgs.gopls;
          config = {
            goimports = true;
            gofumpt = true;
            staticcheck = true;
            analyses = {
              unusedparams = true;
              unreachable = true;
            };
          };
        };
        nixd = {
          enable = true;
          settings.options = {
            nixos.expr = "(builtins.getFlake \"${flakePath}\").nixosConfigurations.cutie.options";
            home_manager.expr = "(builtins.getFlake \"${flakePath}\").homeConfigurations.gofer.options";
            nixvim.expr = "(builtins.getFlake \"${flakePath}\").homeConfigurations.gofer.options.programs.nixvim";
          };
        };
      };

      keymaps = {
        silent = true;

        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "gi" = "implementation";
          "gt" = "type_definition";
          "K" = "hover";
          "<leader>a" = "code_action";
          "<leader>f" = "format";
        };
      };
    };
  };
}
