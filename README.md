# LazyVim & Tmux & Starship & Fish
> Leader key is space

## Folder
`~/.config`


## Fish shell
- `brew install fish starship fzf`
- `source ~/.config/fish/config.fish`



## Lazyvim
```shell
:Mason
:terminal
:Lazy
```

# Keymaps
- https://www.lazyvim.org/keymaps



## My Shortcut

Copy the current line and paste it below
- `yy + p`: Copy the current line and paste it below.
- `u`: Undo the previous action.
- `Ctrl + r`: Redo the previously undone action.

Jump to definition and back
- `go to definition`: Jump to the definition.
- `Ctrl + o`: Return to the previous location.
- `Ctrl + i`: Jump forward again.

Tab operations
- `te`: In normal mode, open a new tab (`tabedit`).
- `<Tab>`: Switch to the next tab.
- `<Shift + Tab>`: Switch to the previous tab.

Window operations
- `ss`: Split the current window horizontally.
- `sv`: Split the current window vertically.

Window navigation
- `sh`: Move the cursor to the left window (`<C-w> h`).
- `sk`: Move the cursor to the upper window (`<C-w> k`).
- `sj`: Move the cursor to the lower window (`<C-w> j`).
- `sl`: Move the cursor to the right window (`<C-w> l`).

Resize windows
- `Ctrl + w` + `←`: Narrow the window.
- `Ctrl + w` + `→`: Widen the window.
- `Ctrl + w` + `↑`: Increase the window height.
- `Ctrl + w` + `↓`: Decrease the window height.

Telescope shortcuts (all in Normal mode)

- `;f`: List files in the current working directory, following `.gitignore` rules.
- `;r`: Live search in the current working directory, following `.gitignore`.
- `\\`: List all open buffers.
- `;t`: List help tags, press `<CR>` to open help.
- `;;`: Restore the last Telescope picker.
- `;e`: List diagnostics for all open buffers.
- `;s`: List symbols from Treesitter, such as functions and variables.
- `sf`: Open the file browser, starting from the current buffer's path.

Telescope file operations

- `?`: Show all keybindings.
- `a`: Create a new file.
- `h`: Go to the parent directory.
- `/`: Enter insert mode to search for files.
- `Ctrl + u`: Move selection up by 10 lines.
- `Ctrl + d`: Move selection down by 10 lines.
- `PageUp`: Scroll the preview pane up.
- `PageDown`: Scroll the preview pane down.

## Tmux commands

> Leader is Ctrl + t

#### Basic operations
- Start tmux: `tmux`
- Start a new session with a name: `tmux new -s session_name`
- List sessions: `tmux ls`
- Attach to an existing session: `tmux attach -t session_name`
- Kill a session: `tmux kill-session -t session_name`
- Detach from a session: Press `Ctrl + t`, then `d` (session continues running)
- Close a session: Type `exit` or `Ctrl + d` to close the current tmux window.
- Kill all sessions: `tmux kill-server`
- Rename a session: `Ctrl + t` then `$`
- Delete a session: Attach to the session and type `exit`

#### Window management
- New window: `Ctrl + t` then `c`
- Switch windows: `Ctrl + t` then the window number, `n` (next window), `p` (previous window)
- Rename a window: `Ctrl + t` then `,`, and enter a new name.
- Close a window: `Ctrl + t` then `&`

#### Pane management
- Split a horizontal pane: `Ctrl + t` then `"`
- Split a vertical pane: `Ctrl + t` then `%`
- Switch panes: `Ctrl + t` then arrow keys or `o` (switch to the next pane)
- Resize panes: `Ctrl + t` then arrow keys, hold `Ctrl` for larger adjustments
- Close a pane: Type `exit` in the pane or press `Ctrl + d`

#### Other shortcuts
- View the list of tmux commands: `Ctrl + t` then `?`
- Reload configuration file: `Ctrl + t` then `:source-file ~/.tmux.conf`

## Lazyvim keybindings

Jump to the start of the current line
- `0`: Move the cursor to the start of the current line (column 0).
- `^`: Move the cursor to the first non-whitespace character on the current line.

Jump to the beginning of the file
- `gg`: Move the cursor to the first line of the file.
- `$` or `G`: Quickly jump to the end of the line or file.

Enter insert mode
- `i`: Insert before the cursor position.
- `I`: Insert at the start of the line.
- `a`: Insert after the cursor position.
- `A`: Insert at the end of the line.
- `o`: Insert a new line below the current line.
- `O`: Insert a new line above the current line.

Cursor movement
- `h`: Move left one character.
- `l`: Move right one character.
- `j`: Move down one line.
- `k`: Move up one line.
- `w`: Jump forward to the start of the next word.
- `b`: Jump backward to the start of the previous word.
- `e`: Jump to the end of the current word.

Selection (Visual mode)
- `v`: Enter character selection mode (Visual mode).
- `V`: Enter line selection mode.
- `Ctrl + v`: Enter block selection mode (Visual Block mode).
- `o`: Switch the cursor to the opposite end of the selection.
- `Esc`: Exit selection mode (cancel selection).

Operate on selected content
- `y`: Copy (yank) the selected text.
- `d`: Delete the selected text.
- `p`: Paste text after the cursor.
- `c`: Change (replace) the selected text.

Find and replace
- `/`: Search for specified content; press `Enter` to jump to matches.
- `n`: Find the next match.
- `N`: Find the previous match.
- `:%s/old_text/new_text/g`: Replace all occurrences of `old_text` with `new_text` in the file.
- `:noh`: Disable search result highlighting.

Undo and redo
- `u`: Undo.
- `Ctrl + r`: Redo.

Save and exit
- `:w`: Save the file.
- `:q`: Quit Vim.
- `:wq`: Save and quit.
- `:q!`: Force quit without saving.


## File Structure
```txt
.
|____README.md
|____nvim
| |____init.lua
| |____lua
| | |____util
| | | |____debug.lua
| | |____config
| | | |____autocmds.lua
| | | |____keymaps.lua
| | | |____options.lua
| | | |____lazy.lua
| | |____plugins
| | | |____zenmode.lua
| | | |____editor.lua
| | | |____lsp.lua
| | | |____colorscheme.lua
| | | |____treesitter.lua
| | | |____ui.lua
| | | |____coding.lua
| | |____craftzdog
| | | |____lsp.lua
| | | |____discipline.lua
| | | |____hsl.lua
| |____lazy-lock.json
| |____lazyvim.json
|____starship.toml
|____tmux
| |____statusline.conf
| |____tmux.conf
| |____utility.conf
| |____macos.conf
```