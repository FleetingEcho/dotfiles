if vim.loader then
	vim.loader.enable()
end
vim.o.modifiable = true

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")
