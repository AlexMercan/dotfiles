set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noshowmode
set clipboard+=unnamedplus
set autoread
set nowrap
set hidden
set noswapfile
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set termguicolors
set noerrorbells
set scrolloff=8   
set incsearch

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mhinz/vim-startify'
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'lighthaus-theme/vim-lighthaus'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plug 'ThePrimeagen/harpoon'

Plug 'vlime/vlime', {'rtp': 'vim/'}
Plug 'catppuccin/nvim'

call plug#end()

colorscheme catppuccin

let g:lightline = {
            \ 'colorscheme': 'catppuccin',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Use autocmd to force lightline update.
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Highlight full name (not only icons).
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let mapleader = " "
let g:coq_settings = { 'auto_start': v:true }

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require('telescope').setup{
    defaults = {
       file_ignore_patterns  = {"%.class",".git/.*","bin/.*", "%.jar", "%.bin"}
    }
}

local nvim_lsp = require('lspconfig')
local coq = require "coq"

local servers = { 'pyright', 'jdtls', 'gopls', 'clangd'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {coq.lsp_ensure_capabilities{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
}
}
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
nvim_lsp.jdtls.setup {coq.lsp_ensure_capabilities
            {
                on_attach = custom_attach,
                flags = {
                  debounce_text_changes = 150,
                },
                root_dir=vim.loop.cwd}
            }

EOF

nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>zz
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>zz
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" nnoremap <C-p> :GFiles<CR>
nnoremap ; :

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

"Harpoon navigation
nnoremap tj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap tk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap tl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap t; :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Using ALT+{h, j, k, l} to navigate windows from any mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

