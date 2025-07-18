return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    branch = "main",
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      model = "claude-sonnet-4", -- Model to use
      -- See Configuration section for rest
    },
    keys = {
      { "<leader>kc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
    }
    -- See Commands section for default commands if you want to lazy load on them
  },
}
