return {
  {
    "jiriks74/presence.nvim",
    event = "UIEnter",
    config = function()
      -- The setup config table shows all available config options with their default values:
      local presence = require("presence")
      presence.setup({
        -- General options
        auto_update         = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text   = ":333", -- Text displayed when hovered over the Neovim image
        main_image          = "neovim", -- Main image display (either "neovim" or "file")
        client_id           = "1172122807501594644", -- Use your own Discord application client id (not recommended)
        log_level           = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout    = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number  = true, -- Displays the current line number instead of the current project
        blacklist           = {}, -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
        blacklist_repos     = {}, -- A blacklist that applies to git remote repo URLs instead of folder/file names
        buttons             = false, -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
        file_assets         = {}, -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
        show_time           = true, -- Show the timer

        -- Rich Presence text options
        editing_text        = "overengineering %s =^w^=",                          -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text  = "looking through cute files in %s x3",                 -- Format string rendered when browsing a file explorer
        git_commit_text     = "blessing repo with cute code ^^",           -- Format string rendered when committing changes in git
        plugin_manager_text = "Making my nvim heavier >w<", -- Format string rendered when managing plugins
        reading_text        = "reading %s",          -- Format string rendered when a read-only or unmodifiable file is loaded
        workspace_text      = "messing up %s",                 -- Format string rendered when in a git repository
        line_number_text    = "layer %s of %s",         -- Format string rendered when enable_line_number is true
      })

      vim.api.nvim_create_user_command("PresenceStop", function()
        presence:stop()
        vim.notify("Discord presence stopped")
      end, {})
    end
  },
}
