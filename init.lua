
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug 'EdenEast/nightfox.nvim'
Plug 'Valloric/YouCompleteMe'

vim.call("plug#end")

vim.cmd.colorscheme("nightfox")

local config

if vim.fn.has("win32") then
config = "~/AppData/Local/nvim/init.lua"
else
config = "~/nvim/init.lua"
end

-- Indentation
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop= -1

-- Misc
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"

-- Visual
vim.opt.cmdheight = 1
vim.opt.number = true
vim.opt.guicursor = "i:block"
vim.opt.cursorline = true
vim.opt.ruler = true

-- Spaces for identation for everything except makefiles
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"Makefile"},
    callback = function() vim.opt_local.expandtab = false end
})

vim.api.nvim_create_user_command("Conf", 
function() 
    vim.cmd(string.format("edit %s", config))
end,
{nargs=0}
)

vim.api.nvim_create_user_command("RelConf",
function()
   vim.cmd(string.format("source %s", config))
end,
{nargs=0}
)

vim.api.nvim_create_user_command("Cd",
function(opts)
    vim.cmd(string.format("Ntree %s", opts.args))
    vim.cmd(string.format("cd %s", opts.args))
end,
{nargs=1})

-- Beginning of line, End of line
vim.keymap.set({"i"}, "<C-q>", "<Esc>0i")
vim.keymap.set({"i"}, "<C-e>", "<Esc>$i", {remap=true})
vim.keymap.set({"n"}, "<C-q>", "<Esc>0")
vim.keymap.set({"n"}, "<C-e>", "<Esc>$", {remap=true})

-- Moving line up, Moving line down
vim.keymap.set({"i", "n", "v"}, "<C-j>", function()
    vim.cmd(":move -2");
end)
vim.keymap.set({"i", "n", "v"}, "<C-k>", function()
    vim.cmd(":move +1")
end, {remap=true})

-- Delete whole word
vim.keymap.set({"i"}, "<C-h>", function()
    vim.api.nvim_input("<Esc>dawi")
end, {remap=true})

-- Go backwards
vim.keymap.set({"n"}, "C-h", function()
    vim.api.nvim_input("b")
end)

-- Undo
vim.keymap.set({"n", "v"}, "<C-z>", function()
    vim.cmd(":undo")
end)

vim.keymap.set({"i"}, "<C-z>", function()
    vim.api.nvim_input("<Esc>")
    vim.cmd(":undo")
    vim.api.nvim_input("i")
end)

-- Autocomplete

-- Go to definition
vim.keymap.set({"i", "n", "v"}, "<C-f>", function()
    vim.cmd(":YcmCompleter GoTo expand(\"<cword>\")")
end)

-- Go to symbol
vim.keymap.set({"i", "n", "v"}, "<C-c-f>", function()
    vim.cmd(":YcmCompleter GoTo expand(\"<cword>\")")
end)

vim.g.netrw_keepdir = 0
