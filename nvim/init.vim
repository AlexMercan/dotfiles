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

set splitright
set splitbelow

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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

Plug 'ThePrimeagen/harpoon'

Plug 'catppuccin/nvim'

Plug 'windwp/nvim-autopairs'

Plug 'ggandor/lightspeed.nvim'
Plug 'windwp/nvim-ts-autotag'

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


let g:AutoPairsMapCh = 0

let g:coq_settings = {'auto_start': v:true, 'match.max_results':10, 'clients.lsp.weight_adjust' : 1.3}

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}

require('telescope').setup{
    defaults = {
       file_ignore_patterns  = {"mod/", "%.class",".git/.*","/usr/.*","bin/.*","node_modules/.*", "%.jar", "%.bin", "%.fxml", "%.xml", "obj/"}
    }
}

local nvim_lsp = require('lspconfig')
local coq = require "coq"

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
            coq.lsp_ensure_capabilities
            {
                on_attach = custom_attach,
                flags = {
                  debounce_text_changes = 150,
                },
                root_dir=vim.loop.cwd
            }
    }
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

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
EOF

"Quickfix list and locallist
let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            cclose
        else
            copen
        end
    else
        echo 'toggle locallist'
        if g:the_primeagen_qf_l == 1
            lclose
        else
            lopen
        end
    endif
endfun

fun! SetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 1
    else
        let g:the_primeagen_qf_g = 1
    end
endfun

fun! UnsetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:the_primeagen_qf_l = 0
    else
        let g:the_primeagen_qf_g = 0
    end
endfun

augroup locallist
    autocmd!
    " Populate locallist with lsp diagnostics automatically 
    autocmd! BufWrite, BufEnter, InsertLeave * :lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
augroup END

augroup fixlist
    autocmd!
    autocmd BufWinEnter quickfix call SetQFControlVariable()
    autocmd BufCreate quickfix call SetQFControlVariable()
    autocmd BufWinLeave * call UnsetQFControlVariable()
augroup END

nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>zz
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>zz
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> [d <cmd>lua vim.diagnostic.goto_prev()<CR>zz
nnoremap <silent> ]d <cmd>lua vim.diagnostic.goto_next()<CR>zz
nnoremap <silent> <leader>q <cmd>lua vim.diagnostic.setloclist()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

" Telescope pickers
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy())<cr>
nnoremap <C-g> <cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_ivy())<cr>

nnoremap <C-b>w <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols(require('telescope.themes').get_ivy())<cr>
nnoremap <C-b>d <cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<cr>

nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Quickfix list stuff
nnoremap <C-q> <cmd>call ToggleQFList(1)<CR>
nnoremap ]a <cmd>cnext<CR>zz
nnoremap [a <cmd>cprev<CR>zz

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap ; :

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Harpoon navigation
nnoremap tj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap tk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap tl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap t; :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep highlight after indent
vnoremap < <gv
vnoremap > >gv

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
