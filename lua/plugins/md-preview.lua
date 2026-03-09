return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", ft = "markdown", desc = "Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", ft = "markdown", desc = "Markdown Preview Stop" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview Toggle" },
    },
  }
}
