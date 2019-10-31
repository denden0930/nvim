"2019/4/25 更新
set encoding=utf-8
scriptencoding utf-8
syntax on

"------------------------------------------------------------
"buffer削除
"------------------------------------------------------------
function! s:delete_hide_buffer()
	let list = filter(range(1, bufnr("$")), "bufexists(v:val) && !buflisted(v:val)")
    for num in list
        execute "bw ".num
    endfor
endfunction

command! DeleteHideBuffer :call s:delete_hide_buffer()
"------------------------------------------------------------
"検索関係
"------------------------------------------------------------
"set number " ---行番号を表示
set autoindent "改行時に前の行のインデントを継続する
set background=dark " 背景色￢
set expandtab
set fileencodings=utf-8,sjis
set fileformats=unix,dos,mac
"set foldmethod=indent "インデント自動で折りたたみ生成
set history=5000 " 保存するコマンド履歴の数
set hlsearch " 検索結果をハイライト
set ignorecase " 検索パターンに大文字小文字を区別しない
set inccommand=split
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set laststatus=2
set modifiable
set nobackup   "(チルダ)ファイル
set noswapfile "swp ファイル
set notimeout " ---タイムアウトさせない---
set noundofile "un~ ファイル
set ruler " ステータスラインの右側にカーソルの現在位置を表示する
set shiftround
set shiftwidth=2 "自動インデントでずれる幅
set showbreak=+++≫  "折り返し行の先頭に表示させる。
set showcmd " 打ったコマンドをステータスラインの下に表示
set showmatch " 括弧の対応関係を一瞬表示する
set showmode " 現在のモードを表示
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smarttab
set softtabstop=0
set spell "スペルチェック
set syntax=markdown " ---Markdownのハイライト有効---
au BufRead,BufNewFile *.md set filetype=markdown
set t_Co=256
set tabstop=2 " タブ文字の表示幅
set termguicolors
set whichwrap=b,s,h,l,<,>,[,],~
set wildmenu " --- コマンドモードの補完
set wrapscan
set write
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する
"------------------------------------------------------------
"spell設定
"------------------------------------------------------------
set spelllang=en,cjk

fun! s:SpellConf()
  redir! => syntax
  silent syntax
  redir END

  set spell

  if syntax =~? '/<comment\>'
    syntax spell default
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent containedin=Comment contained
  else
    syntax spell toplevel
    syntax match SpellMaybeCode /\<\h\l*[_A-Z]\h\{-}\>/ contains=@NoSpell transparent
  endif

  syntax cluster Spell add=SpellNotAscii,SpellMaybeCode
endfunc

augroup spell_check
  autocmd!
  autocmd BufReadPost,BufNewFile,Syntax * call s:SpellConf()
augroup END
"------------------------------------------------------------
"その他
"------------------------------------------------------------
autocmd InsertLeave * set nopaste "挿入貼り付けを終了させる。

autocmd VimEnter * :edit . "起動時にe.設定
autocmd FileType ruby setlocal dictionary=~/usr/share/dict/words.dict
"excitetranslate-vimをp閉じするためのコマンド
autocmd BufEnter ==Translate==\ Excite nnoremap <buffer> <silent> q :<C-u>close<CR>
"autocmd BufWritePre * :normal gg=G "保存時にインデント調整
"ファイル読み込み
source /home/vagrant/.config/nvim/keymap.rc.vim

"------------------------------------------------------------
"自作入力補助
"------------------------------------------------------------
set runtimepath+=~/.config/nvim/rplugin
"------------------------------------------------------------
"tags設定
"------------------------------------------------------------
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -f .tags -R . 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
set tags+=.tags
set tags+=.Gemfile.lock.tags

function! s:execute_ctags() abort
  " 探すタグファイル名
  let tag_name = '.tags'
  " ディレクトリを遡り、タグファイルを探し、パス取得
  let tags_path = findfile(tag_name, '.;')
  " タグファイルパスが見つからなかった場合
  if tags_path ==# ''
    return
  endif

  " タグファイルのディレクトリパスを取得
  " `:p:h`の部分は、:h filename-modifiersで確認
  let tags_dirpath = fnamemodify(tags_path, ':p:h')
  " 見つかったタグファイルのディレクトリに移動して、ctagsをバックグラウンド実行（エラー出力破棄）
  execute 'silent !cd' tags_dirpath '&& ctags -R -f' tag_name '2> /dev/null &'
endfunction

augroup ctags
  autocmd!
  autocmd BufWritePost * call s:execute_ctags()
augroup END
"------------------------------------------------------------
"ctrlpの設定
"------------------------------------------------------------
let g:ctrlp_user_command = 'ag %s -l'
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用
" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

if executable('ag') " agが使える環境の場合
  let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command='ag %s -i --hidden -g ""' " 「ag」の検索設定
  let g:ag_working_path_mode="r"
endif
"ctrlp funkyの設定
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1
nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
"------------------------------------------------------------
"色付け
"------------------------------------------------------------
"------------------------------------------------------------
"slim
"------------------------------------------------------------
autocmd BufRead,BufNewFile *.slim setfiletype slim
"------------------------------------------------------------
"インデント
"------------------------------------------------------------
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
"インデントカラーの設定
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkmagenta
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkcyan
"------------------------------------------------------------
"coffeeスクリプト
"------------------------------------------------------------
" インデント設定
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" オートコンパイル
  "保存と同時にコンパイルする
autocmd BufWritePost *.coffee silent make!
  "エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
"------------------------------------------------------------
" jsonファイルタ
"------------------------------------------------------------
autocmd BufRead,BufNewFile *.jbuilder set ft=ruby
"------------------------------------------------------------
"エラー表示の設定
"-----------------------------------------------------------
let g:ale_sign_error = '!!'
let g:ale_sign_warning = '=='
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
" ファイルオープン時にチェックしたくない場合
let g:ale_lint_on_enter = 0
"------------------------------------------------------------
"綺麗にペースト
"------------------------------------------------------------
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"---------------------
let g:python_host_prog = '/home/vagrant/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/vagrant/.pyenv/versions/neovim3/bin/python'
"--------------------
"------------------------------------------------------------
"補完ウインドウの色指定
"------------------------------------------------------------
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6
"------------------------------------------------------------
"neosnippetの設定
"------------------------------------------------------------
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/.config/nvim/neosnippet'
"------------------------------------------------------------
"deopleteの設定
"------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 3
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 100
inoremap DOM window.addEventListener("DOMContentLoaded", function(){<CR><CR>}());<UP>
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
"------------------------------------------------------------
""dein Scripts
"------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

  " Required:
  set runtimepath+=/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim

  " Required:
  if dein#load_state('/home/vagrant/.cache/dein')
  call dein#begin('/home/vagrant/.cache/dein')
  " Let dein manage dein
  " Required:
  call dein#add('/home/vagrant/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('tomasr/molokai')
  call dein#add ('cespare/vim-toml')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/deoplete.nvim')

  " Set a single option
  call deoplete#custom#option('auto_complete_delay', 200)
  " Pass a dictionary to set multiple options
  call deoplete#custom#option({
  \ 'auto_complete_delay': 200,
  \ 'smart_case': v:true,
  \ })
  call deoplete#custom#option('smart_case', v:true)
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')

  endif

  let g:rc_dir = expand('~/.config/nvim') "<- dein.toml dein_lazy.toml を読み込むディレクトリ ##########
  let s:toml = g:rc_dir . '/dein.toml'
  "let s:lazy_toml = g:rc_dir . '/dein_lazy.toml' "<- dein_lazy.toml を使う場合はコメント解除 ##########

  "tomlファイルを読み込む
  call dein#load_toml(s:toml, {'lazy': 0})
  "call dein#load_toml(s:lazy_toml, {'lazy': 1}) "<- dein_lazy.toml を使う場合はコメント解除 ##########

  " Required:
  call dein#end()
  call dein#save_state()
  endif

  " Required:
  filetype plugin indent on
  syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
