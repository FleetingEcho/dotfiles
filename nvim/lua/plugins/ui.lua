return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},
	{"lewis6991/gitsigns.nvim"},
	{"sindrets/diffview.nvim" },

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},


	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "buffers",  -- or buffers
				show_buffer_close_icons = false,
				show_close_icon = false,
				always_show_bufferline = true,
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")

			-- Custom Git status component
			local function git_status()
				-- Initialize each status with emoji and placeholder for counts
				local statuses = {
					stashed = " 📦 ",
					conflicted = " ⚔️ ",
					ahead = " 🏎️ 💨 ",
					behind = " 🐢 ",
					diverged = " 🔱 🏎️ 💨 🐢 ",
					untracked = " 🛤️ ",
					modified = " 📝 ",
					staged = " 🗃️ ",
					renamed = " 📛 ",
					deleted = " 🗑️ ",
				}

				-- Retrieve counts (simulated here; replace with actual git status commands or integrations as needed)
				-- You may need to use a plugin like `gitsigns.nvim` for real-time data.
				local git_info = require("gitsigns").status_dict or {}

				-- Format each status with counts
				local status_str = ""
				if git_info.staged > 0 then status_str = status_str .. statuses.staged .. "×" .. git_info.staged .. " " end
				if git_info.modified > 0 then status_str = status_str .. statuses.modified .. "×" .. git_info.modified .. " " end
				if git_info.untracked > 0 then status_str = status_str .. statuses.untracked .. " " end
				if git_info.conflicted > 0 then status_str = status_str .. statuses.conflicted .. " " end
				if git_info.renamed > 0 then status_str = status_str .. statuses.renamed .. "×" .. git_info.renamed .. " " end
				if git_info.deleted > 0 then status_str = status_str .. statuses.deleted .. "×" .. git_info.deleted .. " " end
				if git_info.ahead > 0 then status_str = status_str .. statuses.ahead .. "×" .. git_info.ahead .. " " end
				if git_info.behind > 0 then status_str = status_str .. statuses.behind .. "×" .. git_info.behind .. " " end

				-- Format diverged status if ahead and behind both have counts
				if git_info.ahead > 0 and git_info.behind > 0 then
					status_str = status_str .. statuses.diverged
						:gsub("${ahead_count}", git_info.ahead)
						:gsub("${behind_count}", git_info.behind)
				end

				-- Add stashed (simulated here as no gitsigns support for stashes)
				if git_info.stashed then status_str = status_str .. statuses.stashed .. " " end

				return status_str ~= "" and status_str or "No Changes"
			end

			-- Update lualine_c to include git status with emojis
			opts.sections.lualine_c = {
				-- {
				-- 	"branch",
				-- 	icon = "",
				-- },
				{
					git_status, -- Show git status with emoji
					color = { fg = "#ffffff", bg = "#333333" },  -- Adjust colors as needed
				},
				{
					LazyVim.lualine.pretty_path({
						length = 0,
						relative = "cwd",
						modified_hl = "MatchParen",
						directory_hl = "",
						filename_hl = "Bold",
						modified_sign = "",
						readonly_icon = " 󰌾 ",
					}),
				},
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function(_, opts)
			local logo = [[
███████╗██╗     ███████╗███████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
█████╗  ██║     █████╗  █████╗     ██║   ██║██╔██╗ ██║██║  ███╗███████║
██╔══╝  ██║     ██╔══╝  ██╔══╝     ██║   ██║██║╚██╗██║██║   ██║╚════██║
██║     ███████╗███████╗███████║   ██║   ██║██║ ╚████║╚██████╔╝███████║
╚═╝     ╚══════╝╚══════╝╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"
			opts.config.header = vim.split(logo, "\n")
		end,
	},
}
