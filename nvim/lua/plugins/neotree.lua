-- ~/.config/nvim/lua/plugins/neotree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree toggle<CR>",
      desc = "Toggle Neo-tree",
    },
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,  -- 确保隐藏文件可见
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
        title = "",  -- 这里将标题设置为空，隐藏标题栏
        mappings = {
          -- 自定义一些快捷键
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
  end,
}
