return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rubocop",
          "ruby_lsp",
          "vale_ls"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Set default capabilities for all LSP servers
      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.config('ruby_lsp', {
        cmd = { 'docker', 'compose', 'exec', '-T', 'web', 'bundle', 'exec', 'ruby-lsp' },
        root_markers = { "Gemfile", ".git" },
        init_options = {
          enabledFeatures = { "codeActions", "documentFormatting", "references", "documentSymbol", "workspaceSymbol", "definition" },
        },
      })

      vim.lsp.config('rubocop', {
        cmd = {'docker', 'compose', 'exec', '-T', 'web', 'bundle', 'exec', 'rubocop', '--lsp', '--config', '.rubocop.yml'},
        init_options = { formatting = true },
        settings = {
          rubocop = {
            displayCopNames = true
          }
        },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })

      vim.lsp.config('vale_ls', {
        cmd = { "vale-ls" },
        filetypes = { "markdown" },
        root_markers = { ".vale.ini" },
        settings = {
          vale = {
            version = "latest",
            cli = {
              "--fix",
            }
          }
        },
      })

      vim.lsp.enable({ 'ruby_lsp', 'rubocop', 'lua_ls', 'vale_ls' })

      vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.diagnostic.config({
        underline = false,
        virtual_text = {
          source = true,
          prefix = '●',
          spacing = 10,
          current_line = true,
        },
        signs = true,
        severity_sort = true,
        update_in_insert = true,
        float = {
          source = 'always',
        },
      })
    end
  }
}
