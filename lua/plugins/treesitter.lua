return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').install({
        "ruby",
        "javascript",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "html",
        "css",
      })
    end
  }
}
