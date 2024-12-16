return {
	{
    "sainnhe/sonokai",
    lazy = false,        -- Load the plugin immediately
    priority = 1000,     -- Ensure it loads before other plugins
    config = function()
      -- Available styles: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
      vim.g.sonokai_style = "andromeda"
      vim.cmd("colorscheme sonokai")   -- Apply the colorscheme
    end,
  },
}
