{
  plugins = {
    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          options = {
            desc = "telescope find files";
          };
        };
        "<leader>fg" = {
          action = "live_grep";
          options = {
            desc = "telescope live grep";
          };
        };
      };
    };
  };
}
