# LazyVim & Tmux & Starship & Fish
> Leader 键是空格

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


## My Shortcut


复制当前行并粘贴到下一行
- `yy + p`：复制当前行并粘贴到下一行。
- `u`：撤销上一步操作。
- `Ctrl + r`：重做上一步撤销的操作。

跳转定义与返回
- `go to definition`：跳转到定义位置。
- `Ctrl + o`：返回到之前的位置。
- `Ctrl + i`：再次回到跳转的位置。

Tab 操作
- `te`：在正常模式下，打开一个新的标签页（`tabedit`）。
- `<Tab>`：切换到下一个标签页。
- `<Shift + Tab>`：切换到上一个标签页。

Window 操作
- `ss`：水平拆分当前窗口（split）。
- `sv`：垂直拆分当前窗口（vsplit）。

Window 移动
- `sh`：将光标移动到左侧的窗口（相当于 `<C-w> h`）。
- `sk`：将光标移动到上方的窗口（相当于 `<C-w> k`）。
- `sj`：将光标移动到下方的窗口（相当于 `<C-w> j`）。
- `sl`：将光标移动到右侧的窗口（相当于 `<C-w> l`）。

调整窗口大小
- `Ctrl + w` + `←`：使窗口变窄。
- `Ctrl + w` + `→`：使窗口变宽。
- `Ctrl + w` + `↑`：增加窗口高度。
- `Ctrl + w` + `↓`：减少窗口高度。


Telescope 快捷键（都是 Normal 模式）

- `;f`：列出当前工作目录中的文件，遵循 `.gitignore` 规则
- `;r`：在当前工作目录中实时搜索字符串，遵循 `.gitignore` 规则
- `\\`：列出所有已打开的缓冲区
- `;t`：列出帮助标签，按 `<CR>` 打开帮助信息
- `;;`：恢复上一个 Telescope 选择器
- `;e`：列出所有已打开缓冲区的诊断信息
- `;s`：从 Treesitter 列出函数、变量等符号信息
- `sf`：打开文件浏览器，使用当前缓冲区路径为起点


Telescope 文件操作

- `?`:查询所有快捷键
- `a`：创建一个新文件。
- `h`：转到上一级目录。
- `/`：进入插入模式以搜索文件。
- `Ctrl + u`：将选择项向上移动 10 行。
- `Ctrl + d`：将选择项向下移动 10 行。
- `PageUp`：向上滚动预览窗格。
- `PageDown`：向下滚动预览窗格。

##  Tmux commands

>Leader is Ctrl+t
#### 基本操作
- 启动 tmux：`tmux`
- 启动并命名会话：`tmux new -s session_name`
- 列出会话：`tmux ls`
- 附加到已有会话：`tmux attach -t session_name`
- 删除已有会话：`tmux kill-session -t session_name`
- 离开会话：按下 `Ctrl + t`，然后按 `d`（会话继续运行）
- 关闭会话：输入 `exit` 或 `Ctrl + d` 关闭当前的 tmux 窗口
- 关闭所有会话：`tmux kill-server`
- 重命名会话：`Ctrl + t` 然后按 `$`
- 删除会话：附加到会话中并输入 `exit`

#### 窗口管理
- 新建窗口：`Ctrl + t` 然后按 `c`
- 切换窗口：`Ctrl + t` 然后按窗口编号或 `n`（下一个窗口），`p`（上一个窗口）
- 重命名窗口：`Ctrl + t` 然后按 `,`，输入新名称
- 关闭窗口：`Ctrl + t` 然后按 `&`

#### 窗格（Pane）管理
- 拆分水平窗格：`Ctrl + t` 然后按 `"`
- 拆分垂直窗格：`Ctrl + t` 然后按 `%`
- 切换窗格：`Ctrl + t` 然后按方向键或 `o`（切换到下一个窗格）
- 调整窗格大小：`Ctrl + t` 然后按方向键，按住 `Ctrl` 键以更大幅度调整
- 关闭窗格：在窗格中输入 `exit`，或按 `Ctrl + d`

#### 其他快捷键
- 查看 tmux 指令列表：`Ctrl + t` 然后按 `?`
- 重新加载配置文件：`Ctrl + t` 然后输入 `:source-file ~/.tmux.conf`




## Lazyvim keybindings


跳到当前行的行首
- `0`：将光标移动到当前行的行首（列 0）。
- `^`：将光标移动到当前行的第一个非空白字符。

跳到文件的开头
- `gg`：将光标移动到文件的第一行的行首。
- `$` 或 `G`：快速跳到行尾或文件末尾。

进入插入模式
- `i`：在当前光标位置前插入。
- `I`：在当前行的行首插入。
- `a`：在当前光标位置后插入。
- `A`：在当前行的行尾插入。
- `o`：在当前行的下方插入新行。
- `O`：在当前行的上方插入新行。

光标移动
- `h`：向左移动一个字符。
- `l`：向右移动一个字符。
- `j`：向下移动一行。
- `k`：向上移动一行。
- `w`：向下跳到下一个单词的开头。
- `b`：向上跳到上一个单词的开头。
- `e`：跳到当前单词的末尾。

选中（Visual 模式）
- `v`：进入字符选中模式（Visual 模式）。
- `V`：进入行选中模式。
- `Ctrl + v`：进入块选中模式（Visual Block 模式）。
- `o`：在选中模式下，切换光标到选区的另一端。
- `Esc`：退出选中模式（放弃选择）。

操作选中内容
- `y`：复制选中的文本（Yank）。
- `d`：删除选中的文本（Delete）。
- `p`：在当前光标后粘贴文本。
- `c`：修改选中的文本。

查找和替换
- `/`：查找指定内容，按 `Enter` 后光标跳到匹配的内容。
- `n`：查找下一个匹配的内容。
- `N`：查找上一个匹配的内容。
- `:%s/旧文本/新文本/g`：在整个文件中替换所有旧文本为新文本。
- `:noh`：关闭高亮显示查找结果。

撤销和重做
- `u`：撤销（Undo）。
- `Ctrl + r`：重做（Redo）。

保存与退出
- `:w`：保存文件。
- `:q`：退出 Vim。
- `:wq`：保存并退出。
- `:q!`：不保存强制退出。


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