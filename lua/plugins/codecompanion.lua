return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using the telescope actions
    {
      "stevearc/dressing.nvim", -- Optional: Improves `vim.ui.select`
      opts = {},
    },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        agent = {
          adapter = "copilot",
        },
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:echo $ANTHROPIC_API_KEY",
            },
            schema = {
              model = {
                default = "claude-sonnet-4",
              },
            },
          })
        end,
      },
      display = {
        diff = {
          provider = "mini_diff",
        },
      },
      opts = {
        log_level = "ERROR",
        send_code = true,
        use_default_actions = true,
        use_default_prompt_library = true,
      },
    })
  end,
  keys = {
    { "<leader>ai", ":CodeCompanionChat<CR>", mode = "n", desc = "Open CodeCompanion Chat" },
    { "<leader>aa", ":CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "Open CodeCompanion Actions" },
    { "<leader>at", ":CodeCompanionToggle<CR>", mode = { "n", "v" }, desc = "Toggle CodeCompanion" },
    { "<leader>ac", ":CodeCompanionCmd<CR>", mode = "n", desc = "Open CodeCompanion Command" },
    { "<leader>ao", ":CodeCompanionChat Add<CR>", mode = { "n", "v" }, desc = "Add selection to CodeCompanion Chat" },
    { "<leader>ab", ":CodeCompanionChat buffer<CR>", mode = "n", desc = "Add entire file to CodeCompanion Chat" },
  },
}