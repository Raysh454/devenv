--options
require('core.options')

--Keybinds
require("core.remap")

--Load Lazy, other plugins are loaded in this file
require("core.plugins.lazy")

--Load Language server
require("core.lsp_config")

--Colorscheme
vim.o.termguicolors = true
vim.cmd.colorscheme "catppuccin-macchiato"
