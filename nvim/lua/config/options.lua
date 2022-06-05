local options = {
    scrolloff = 8,
    number = true,
    relativenumber = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    showmode = false,
    signcolumn = "yes",
    autoread = true,
    wrap = false,
    hidden = true,
    swapfile = false,
    backup = false,
    writebackup = false,
    cmdheight = 2,
    updatetime = 300,
    termguicolors = true,
    errorbells = false,
    incsearch = true,
    splitright = true,
    splitbelow = true,
}

vim.opt.clipboard:append "unnamedplus"
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end
