return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require('nvim-treesitter.configs')

      config.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "ruby",
          "javascript",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "html",
          "css",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },
      }
    end
  }
}
