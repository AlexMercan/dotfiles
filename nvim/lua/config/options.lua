local options = {
    scrolloff = 8,
    number = true,
    relativenumber = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    smartcase = true,
    ignorecase = true,
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
    laststatus = 3,
}

vim.opt.clipboard:append "unnamedplus"
vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i, --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = false,
    }
end
