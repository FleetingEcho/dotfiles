-- ~/.config/nvim/lua/plugins/neotree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "akinsho/nvim-bufferline.lua", -- Ensure bufferline is included
  },
  keys = {
    { "<C-Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<C-S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
  },
  config = function()
    require("neo-tree").setup({
      -- Neo-tree configuration here
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            ".venv",
            ".git",
          },
          never_show = { ".git" },
        },
        follow_current_file = true,
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
      },
      default_component_configs = {
        indent = {
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          expand_marker = "▸",
          collapse_marker = "▾",
        },
      },
      window = {
        position = "left",
        width = 30,
        title = "",
        mappings = {
          ["<CR>"] = "open",
          ["<Tab>"] = "preview",
          ["o"] = "open",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["p"] = "paste_from_clipboard",
        },
      },
    })
    require("bufferline").setup {} -- Ensure Bufferline setup is called
  end,
}
