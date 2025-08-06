vim.api.nvim_create_user_command('LspStatus', function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to current buffer")
  else
    for _, client in ipairs(clients) do
      print("Client: " .. client.name)
      print("Supports definition: " .. tostring(client.server_capabilities.definitionProvider))
      print("Supports references: " .. tostring(client.server_capabilities.referencesProvider))
      print("Supports hover: " .. tostring(client.server_capabilities.hoverProvider))
      print("---")
    end
  end
end, { desc = 'Show LSP client status and capabilities' })
