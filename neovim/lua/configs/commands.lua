-- Command to set AI assistant preference
vim.api.nvim_create_user_command("AIAssistantVendor", function()
  local assistants = { "sidekick", "avante" }
  vim.ui.select(assistants, {
    prompt = "Select AI Assistant:",
    format_item = function(item)
      return item:sub(1, 1):upper() .. item:sub(2)
    end,
  }, function(choice)
    if not choice then
      return -- User cancelled the selection
    end

    vim.g.ai_assistant = choice

    -- Save to file for persistence
    local config_path = vim.fn.stdpath("data") .. "/.ai_preference"
    local file = io.open(config_path, "w")
    if file then
      file:write(choice)
      file:close()
      vim.notify(
        string.format("AI assistant set to '%s'. Please restart Neovim for changes to take effect.", choice),
        vim.log.levels.INFO
      )
    else
      vim.notify("Failed to save AI assistant preference", vim.log.levels.ERROR)
    end
  end)
end, {
  desc = "Set AI assistant (sidekick or avante)",
})
