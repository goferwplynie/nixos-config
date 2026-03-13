{
  inputs,
  pkgs,
  ...
}: let
  flakePath = "/home/gofer/.config/home-manager";
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          integrations = {
            cmp = true;
            treesitter = true;
          };

          transparent_background = true;
        };
      };
    };

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

    opts = {
      tabstop = 4;
      shiftwidth = 2;

      number = true;
      relativenumber = true;

      breakindent = true;

      undofile = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      updatetime = 250;
      timeoutlen = 300;

      splitright = true;
      splitbelow = true;

      inccommand = "split";

      cursorline = true;
      confirm = true;

      hlsearch = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }
      {
        mode = "n";
        key = "<leader>sv";
        action = "<cmd>vsplit<CR>";
        options = {
          desc = "split right";
        };
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>split<CR>";
        options = {
          desc = "split below";
        };
      }
      {
        mode = "n";
        key = "<leader>ee";
        action = "<cmd>Oil<CR>";
        options = {
          desc = "open file explorer";
        };
      }
    ];

    diagnostic = {
      virtual_lines = {
        current_line = true;
      };

      virtual_text = true;
    };

    plugins = {
      lualine.enable = true;
      treesitter.enable = true;
      oil.enable = true;
      autoclose.enable = true;
      guess-indent.enable = true;

      presence = {
        enable = true;
        settings = {
          autoUpdate = true;
          neovimImageText = ":333";
          mainImage = "neovim";
          clientId = "1172122807501594644";
          debounceTimeout = 10;
          enableLineNumber = true;
          showTime = true;

          editingText = "overengineering %s =^w^=";
          fileExplorerText = "looking through cute files in %s x3";
          pluginManagerText = "Making my nvim heavier >w<";
          readingText = "reading %s";
          workspaceText = "messing up %s";
          lineNumberText = "layer %s of %s";
        };
      };

      blink-cmp = {
        enable = true;
        settings = {
          completion = {
            list.selection = {
              preselect = true;
              auto_insert = true;
            };
            trigger.show_on_trigger_character = true;
          };
          sources.default = ["lsp" "path" "snippets" "buffer"];
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            nix = ["alejandra"];
          };
        };
      };

      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          lua_ls.enable = true;
          gopls.enable = true;
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

    extraPlugins = [
      pkgs.vimPlugins.opencode-nvim
    ];

    extraConfigLua = ''
          vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    '';
  };
}
