{
  plugins = {
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
  };
}
