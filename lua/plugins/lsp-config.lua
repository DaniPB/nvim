return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
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
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
      lspconfig.ruby_lsp.setup({
        cmd = { 'docker', 'compose', 'exec', '-T', 'web', 'bundle', 'exec', 'ruby-lsp' },
        capabilities = capabilities,
        root_dir = require("lspconfig").util.root_pattern("Gemfile", ".git"),
        init_options = {
          enabledFeatures = { "codeActions", "documentFormatting", "references", "documentSymbol", "workspaceSymbol", "definition" },
        },
      })
      lspconfig.rubocop.setup({
        capabilities = capabilities,
        cmd = {'docker', 'compose', 'exec', '-T', 'web', 'bundle', 'exec', 'rubocop', '--lsp', '--config', '.rubocop.yml'},
        init_options = { formatting = true },
        -- Aquí puedes agregar la configuración específica para RuboCop
        settings = {
          rubocop = {
            -- Esto hará que los nombres de los cops se muestren en los mensajes de advertencia
            displayCopNames = true
          }
        },
      })
      lspconfig.vale_ls.setup({
        cmd = { "vale-ls" },
        filetypes = { "markdown" },
        root_dir = require("lspconfig").util.root_pattern(".vale.ini"),
        settings = {
          vale = {
            version = "latest",
            cli = {
              "--fix", -- Enable fix mode
            }
          }
        },
        capabilities = capabilities, -- if you're using nvim-cmp capabilities
      })

      vim.keymap.set("n", "H", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      vim.diagnostic.config({
        underline = false,
        -- virtual_text = true,
        virtual_text = {
          source = true, -- Or 'if_many'
          prefix = '●', -- Could be '■', '▎', 'x'
          spacing = 10,
          current_line = true,
        },
        signs = true,
        severity_sort = true,
        update_in_insert = true,
        float = {
          source = 'always', -- Or 'always'
        },
      })
    end
  }
}
