-- Docker LSP connectivity checker
local M = {}

function M.check_docker_connection()
  print("Checking Docker LSP connectivity...")
  
  -- Check if docker compose is available
  local docker_check = vim.fn.system("docker compose ps")
  if vim.v.shell_error ~= 0 then
    print("❌ Docker compose not available or no containers running")
    print("Output: " .. docker_check)
    return false
  end
  
  print("✅ Docker compose is available")
  
  -- Check if web service is running
  local web_check = vim.fn.system("docker compose ps web")
  if vim.v.shell_error ~= 0 then
    print("❌ 'web' service not found or not running")
    print("Available services:")
    print(vim.fn.system("docker compose ps --services"))
    return false
  end
  
  print("✅ 'web' service is running")
  
  -- Check if bundle is available in container
  local bundle_check = vim.fn.system("docker compose exec -T web which bundle")
  if vim.v.shell_error ~= 0 then
    print("❌ Bundle not found in container")
    return false
  end
  
  print("✅ Bundle is available in container")
  
  -- Check if ruby-lsp gem is installed
  local ruby_lsp_check = vim.fn.system("docker compose exec -T web bundle list | grep ruby-lsp")
  if vim.v.shell_error ~= 0 then
    print("❌ ruby-lsp gem not found")
    print("Install it by adding to your Gemfile: gem 'ruby-lsp', group: :development")
    return false
  end
  
  print("✅ ruby-lsp gem is installed")
  
  -- Test actual LSP command
  local lsp_test = vim.fn.system("timeout 5 docker compose exec -T web bundle exec ruby-lsp --help 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    print("❌ ruby-lsp command failed")
    return false
  end
  
  print("✅ ruby-lsp command works")
  print("🎉 All checks passed! LSP should work properly.")
  return true
end

function M.suggest_fixes()
  print("\n🔧 Troubleshooting suggestions:")
  print("1. Make sure your Docker containers are running: docker compose up -d")
  print("2. Add ruby-lsp to your Gemfile (development group)")
  print("3. Run bundle install in your container")
  print("4. Check if your service name is 'web' or update the LSP config")
  print("5. Ensure your project root has Gemfile and is mounted in container")
end

-- Command to run the check
vim.api.nvim_create_user_command('CheckDockerLSP', function()
  if not M.check_docker_connection() then
    M.suggest_fixes()
  end
end, {})

return M