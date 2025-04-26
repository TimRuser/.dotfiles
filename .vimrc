
call plug#begin()

Plug 'morhetz/gruvbox'

Plug 'tpope/vim-sensible'

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_compiler_method = 'latexmk'

Plug 'KeitaNakamura/tex-conceal.vim'
set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

call plug#end()

autocmd vimenter * ++nested colorscheme gruvbox

augroup VimTeXAutoItem
  autocmd!
  autocmd FileType tex setlocal formatoptions+=tcroqln
  autocmd FileType tex setlocal comments+=b:\\item
  autocmd FileType tex inoremap <buffer> <expr> <CR> getline('.') =~ '^\\s*\\\\item\\s*$' ? '<C-w><C-w>' : '<CR>'
augroup END

setlocal spell
set spelllang=de_ch,en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
