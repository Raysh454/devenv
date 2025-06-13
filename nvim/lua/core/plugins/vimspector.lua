vim.keymap.set("n", "<Leader>Di", "<Plug>VimspectorBalloonEval", {})
vim.keymap.set("x", "<Leader>Di", "<Plug>VimspectorBalloonEval", {})

vim.keymap.set("n", "<Leader>D<Up>", "<Plug>VimspectorUpFrame", {})
vim.keymap.set("n", "<Leader>D<Down>", "<Plug>VimspectorDownFrame", {})
vim.keymap.set("n", "<Leader>DB", "<Plug>VimspectorBreakpoints", {})
vim.keymap.set("n", "<Leader>DD", "<Plug>VimspectorDisassemble", {})
vim.keymap.set("n", "<Leader>DR", function() vim.cmd("call vimspector#Launch()") end, {})
vim.keymap.set("n", "<Leader>DC", function() vim.cmd("call vimspector#Continue()") end, {})
vim.keymap.set("n", "<Leader>DSI", function() vim.cmd("call vimspector#StepInto()") end, {})
vim.keymap.set("n", "<Leader>DSO", function() vim.cmd("call vimspector#StepOver()") end, {})
vim.keymap.set("n", "<Leader>DSE", function() vim.cmd("call vimspector#StepOut()") end, {})
vim.keymap.set("n", "<Leader>DST", function() vim.cmd("call vimspector#SetCurrentThread()") end, {})

--[[ 

Breakpoint Menu Keybinds
    t, <F9> - toggle, i.e. enable/disable breakpoint
    T - toggle, i.e. enable/disable ALL breakpoints
    dd, <Del> - delete the current breakpoint
    cc, C - edit the current breakpoint options
    i, a, o - add a new line breakpoint
    I, A, O - add a new function breakpoint
    <Enter> or double-click - jump to the line breakpoint
]]
