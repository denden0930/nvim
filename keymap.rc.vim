"------------------------------------------------------------
"ファイルショートカット
"------------------------------------------------------------
cnoremap k<CR> source ~/.config/nvim/keymap.rc.vim<CR>
cnoremap i<CR> source ~/.config/nvim/init.vim<CR>
cnoremap ww w !sudo tee %<CR>

nnoremap neo :vs<CR><C-w>l<ESC>:NeoSnippetEdit<CR>
nnoremap yml :vs<CR><C-w>l<ESC>:e /vagrant/APP/myrungo/config/locales/ja.yml<CR>
nnoremap sneo :tabnew ~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets/<CR>
nnoremap md :tabnew ~/.config/nvim/rplugin/python3/deoplete/sources/callneco.py<CR>
nnoremap mn<CR> :tabnew ~/.config/nvim<CR>
nnoremap mnd :tabnew ~/.config/nvim/dein.toml<CR>
nnoremap mnk :tabnew ~/.config/nvim/keymap.rc.vim<CR>
nnoremap mni :tabnew ~/.config/nvim/init.vim<CR>
nnoremap mnt :tabnew /vagrant/APP/dictionary/app/views/webshops/<CR>
nnoremap mnp :tabnew /vagrant/APP/myrungo/public/<CR>
nnoremap mnv :tabnew /vagrant<CR>


"------------------------------------------------------------
"入力補助
"------------------------------------------------------------
"単語辞書 :excで検索"
cnoremap exc<CR> ExciteTranslate<CR>
"inoremap jtag = javascript_include_tag "", :media => "all"<C-c>f"
"inoremap ctag = stylesheet_link_tag "scss/.css", :media => "all"<C-c>f"
"inoremap for( for ( let i = 0; i <  .length; i++) {<CR><CR>};<UP><Space><Space>
"inoremap swi  switch (){<CR>case :<CR>break;<CR>default:<CR>}<UP><UP><UP><UP><UP>
"inoremap case: case :<CR>break;<UP><Left>
inoremap 　 <Space>
inoremap ＃ #
inoremap ~~ ～
nnoremap bb :buffer<CR>
"------------------------------------------------------------
"検索系、置換、ハイライト
"------------------------------------------------------------
" ---カーソル下の単語をハイライトする---
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> <2-LeftMouse> g*
" ---カーソル下の単語をハイライトしてから置換する---
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>
" ---.ビジュアルモードでもハイライト・置換---
xnoremap <silent> <Space> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z
xnoremap * :<C-u>call <SID>set_vsearch()<CR>/<C-r>/<CR>
xmap # <Space>:%s/<C-r>///g<Left><Left>
function! s:set_vsearch()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction
" ハイライトの切り替え
nnoremap <silent><C-l> :<C-u>noh<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>
"ｊｊ押しで保存
"noremap <silent> jj <ESC>:<C-u>w<CR>
"英単語の候補一覧"
nnoremap zz z=
"------------------------------------------------------------
"カーソル移動関連
"------------------------------------------------------------
" ---行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
"------------------------------------------------------------
"インデント、ウィンドウ枠操作
"------------------------------------------------------------
"---Window設定---
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
"---nomal時のスペース挿入
nnoremap <space> i<space><right><Esc>
"---インデント調整
nnoremap > >>
nnoremap < <<
"-----タブ切り替え
"右タブに移動"
nnoremap <TAB> gt
"タブに移動
nnoremap <S-tab> gT
"C-c で新規タブを開く
nnoremap <C-c> :tabnew<CR>:e.<CR>
"エンター改行
nnoremap <CR> i<Return><Esc>
"空行削除
nnoremap :kara :g/^$/d<CR>
"------------------------------------------------------------
"入力補佐
"------------------------------------------------------------
" ---Ctrl+tでタイポ修正---
inoremap <C-t> <Esc><Left>"zx"zpa
inoremap <C-d> <Del>
"emmetショートカットキー
let g:user_emmet_leader_key='<c-m>'
"---新規カッコ,"クォーテション作成
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
"---新規カッコ空閉じ,"クォーテション作成
inoremap {{ {}
inoremap (( ()
inoremap [[ []
inoremap "<CR> ""
inoremap '<CR> ''
"---新規カッコ閉じ　ＣＳＳ書く用---
inoremap {<CR> {};<Left><Left><CR><ESC><S-o>
inoremap (<CR> ();<Left><Left><CR><ESC><S-o>
inoremap [<CR> [];<Left><Left><CR><ESC><S-o>
"---既存タグにカッコつけ--- 行末にカッコつけ

inoremap (<TAB> (<Right><ESC>$a)
inoremap [<TAB> [<Right><ESC>$a]
inoremap "<TAB> "<Right><ESC>$a"
inoremap '<TAB> '<Right><ESC>$a'
"---既存タグにカッコつけ--- 単語末にカッコつけ
inoremap {} {<Right><ESC>Ea}
inoremap () (<Right><ESC>Ea)
inoremap (/ (<Right><ESC>t/a)
inoremap (. (<Right><ESC>t.a)
inoremap [] [<Right><ESC>Ea]
inoremap ") "<Right><ESC>t)a"
inoremap "} "<Right><ESC>t}a"
inoremap "] "<Right><ESC>t]a"
inoremap ", "<Right><ESC>t,a"
inoremap ": "<Right><ESC>t:a"
inoremap "; "<Right><ESC>t;a"
inoremap ') '<Right><ESC>t)a'
inoremap '} '<Right><ESC>t}a'
inoremap '] '<Right><ESC>t]a'
inoremap ', '<Right><ESC>t,a'
inoremap ': '<Right><ESC>t:a'
inoremap '; '<Right><ESC>t;a'
"---既存タグにカッコつけ---
inoremap {<Right> {
inoremap (<Right> (
inoremap [<Right> [
inoremap "<Right> "
inoremap '<Right> '
"------------------------------------------------------------
"その他
"------------------------------------------------------------
" ---エスケープ+保存---
inoremap <silent> jj <ESC>:<C-u>w<CR>
inoremap <C-c> <ESC>:w<CR>
" ---ctrlp funkyの設定---
nnoremap <Leader>fu :CtrlPFunky<Cr>
"---narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
"---vimコメント---
"inoremap "- "------------------------------------------------------------<CR><CR>------------------------------------------------------------<UP>
"CSSコメント
"inoremap "* /* --------------------------------------------------<CR><CR>-------------------------------------------------- */<UP>
"シャープ系コメントアウト"
"inoremap "# #------------------------------------------------------------<CR>#<CR>#------------------------------------------------------------<UP>
" ---カーソル下の行を上の末行に移動---
nnoremap J <UP>J<DOWN>^
"------------------------------------------------------------
"カット＆ペースト
"------------------------------------------------------------
"vimペーストをインサイトで行う。"
inoremap <C-p> <ESC>pi<Right>
"---頭/末まで切り取り
nnoremap ds v^d
nnoremap dff v$<Left>d
nnoremap df<CR> v$d
"---頭/末までコピー
nnoremap yt v^y
nnoremap yuu v$<Left>y
nnoremap yu<CR> v$y
"--- バックスペースキーの有効化
set backspace=indent,eol,start
"--- バックスペースキーで削除
nnoremap <BS> <left>x
"xやs,ddではヤンクしない"
nnoremap x "_x
nnoremap s "_s
nnoremap dd "_dd
"ビジュアルモードで連続ペーストできるように
xnoremap <expr> p 'pgv"'.v:register.'y`>'
" ---行を移動する---
" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp
" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]
