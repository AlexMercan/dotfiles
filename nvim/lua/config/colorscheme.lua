local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha, amoled, catppuccino

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
