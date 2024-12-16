return {
  "folke/zen-mode.nvim",
  config = function()
      require("zen-mode").setup({
          window = {
              backdrop = 0.95,
              width = 100,
              height = 1,
              options = {
                  colorcolumn = "",
                  signcolumn = "no",
                  number = false,
                  relativenumber = false,
              },
          },
          plugins = {
              options = {
                  enabled = true,
                  ruler = false,
                  showcmd = false,
                  laststatus = 0,
              },
              twilight = { enabled = false },
              gitsigns = { enabled = false },
              tmux = { enabled = true },
              wezterm = {
                  enabled = true,
                  font = "+20",
              },
          },
      })
  end,
}
