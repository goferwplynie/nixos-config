{
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        suggestion = {
          enabled = true;
          auto_trigger = true;

          keymap = {
            accept = "<C-l>";
            next = "<C-j>";
            prev = "<C-k>";
            dismiss = "<C-h>";
          };
        };
      };
    };
  };
}
