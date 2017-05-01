 " release autogroup in MyAutoCmd
 augroup MyAutoCmd
   autocmd!
 augroup END

 "------------------------
 "検索関係
 "------------------------
 set ignorecase          " 大文字小文字を区別しない
 set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
 set incsearch           " インクリメンタルサーチ
 set hlsearch             " 検索マッチテキストをハイライト

 " バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
 cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
 cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
 "
"------------------------
"編集関係
"------------------------
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set shiftwidth=2
set softtabstop=2
set expandtab
set cursorline          "カーソル行をハイライト
set noundofile
set display=lastline    "一行の文字数が多くてもきちんと描画する
set ambiwidth=double    " 全角記号を欠けないようにする
set encoding=utf-8
set fileencodings=utf-8,cp932
set pumheight=10 "補完メニューの高さ
set display=lastline "一行が長くても全ての文字を描画する

nnoremap + <C-a> "インクリメント
nnoremap - <C-x> "デクリメント

" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" 先頭、行末の移動
nnoremap <Space>h  ^
nnoremap <Space>l  $


 "---------------------------------------------
 " 改行
 " EmacsのC-oと同じ動作
 nnoremap go :<C-u>call append('.', '')<CR>

 " ↑の逆バージョン
 nnoremap gO :normal! O<ESC>j


 let mapleader = ","     "leaderを,に変更


 "インデントを連続して変更
 vnoremap < <gv
 vnoremap > >gv


 autocmd FileType * setlocal formatoptions-=ro "改行時にコメントが追加されるのを防ぐ


 " 対応括弧に'<'と'>'のペアを追加
 set matchpairs& matchpairs+=<:>

 " バックスペースでなんでも消せるようにする
 set backspace=indent,eol,start

 " クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
 " 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
 if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
 else
     " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
     set clipboard& clipboard+=unnamed
 endif

 " Swapファイル？Backupファイル？前時代的すぎ
 " なので全て無効化する
 set nowritebackup
 set nobackup
 set noswapfile
 set wildmenu  " コマンドライン補完を便利に


 "-------------------------
 "表示関係
 "-------------------------
 set list                " 不可視文字の可視化
 set listchars=tab:>-,eol:↲
 set number              " 行番号の表示
 set wrap                " 長いテキストの折り返し
 set textwidth=0         " 自動的に改行が入るのを無効化
 " set colorcolumn=80      " その代わり80文字目にラインを入れる

 "ビープ音すべてを無効にする
 set t_vb=
 set visualbell
 set novisualbell



  "--------------------------
  "マクロ及びキー設定
  "--------------------------

  " ESCを二回押すことでハイライトを消す
  nmap <silent> <Esc><Esc> :nohlsearch<CR>

  " カーソル下の単語を * で検索
  vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

  " 検索後にジャンプした際に検索単語を画面中央に持ってくる
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz

  " j, k による移動を折り返されたテキストでも自然に振る舞うように変更
  nnoremap j gj
  nnoremap k gk

  " vを二回で行末まで選択
  vnoremap v $h
 "
  " Ctrl + hjkl でウィンドウ間を移動
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l



  " make, grep などのコマンド後に自動的にQuickFixを開く
  autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

  " QuickFixおよびHelpでは q でバッファを閉じる
  autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

  " w!! でスーパーユーザーとして保存（sudoが使える環境限定）
  cmap w!! w !sudo tee > /dev/null %

  " :e などでファイルを開く際にフォルダが存在しない場合は自動作成
  function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
  autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)



 "--------------------------
 "NeoBundle
 "--------------------------
 set nocompatible
 if has("vim_starting")
   set runtimepath+=~/.vim/bundle/neobundle.vim
 endif
 call neobundle#begin(expand('~/.vim/bundle/'))

 if neobundle#load_cache()
   NeoBundleFetch 'Shougo/neobundle.vim'
   call neobundle#load_toml('~/.vim/neobundle.toml')
   call neobundle#load_toml('~/.vim/neobundlelazy.toml', {'lazy' :1} )
   NeoBundleSaveCache
 endif

 call neobundle#end()


 " ファイルタイププラグインおよびインデントを有効化
 " これはNeoBundleによる処理が終了したあとに呼ばなければならない
 filetype plugin indent on

 " インストールされていないプラグインのチェックおよびダウンロード
 NeoBundleCheck


 "
 nnoremap [unite] <Nop>
 nmap U [unite]
 nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
 nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
 nnoremap <silent> [unite]r :<C-u>Unite register<CR>
 nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
 nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
 nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
 nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
 nnoremap <silent> [unite]w :<C-u>Unite window<CR>
 "nnoremap <silent> / :<C-u>Unite -buffer-name=search line -start-insert -no-quit<CR>
 nnoremap <silent> // :<C-u>Unite -buffer-name=search line -start-insert<CR>
 let s:hooks = neobundle#get_hooks("unite.vim")
 function! s:hooks.on_source(bundle)
   " start unite in insert mode
   let g:unite_enable_start_insert = 1
   " use vimfiler to open directory
   call unite#custom_default_action("source/bookmark/directory", "vimfiler")
   call unite#custom_default_action("directory", "vimfiler")
   call unite#custom_default_action("directory_mru", "vimfiler")
   autocmd MyAutoCmd FileType unite call s:unite_settings()
   function! s:unite_settings()
     imap <buffer> <Esc><Esc> <Plug>(unite_exit)
     nmap <buffer> <Esc> <Plug>(unite_exit)
     nmap <buffer> <C-n> <Plug>(unite_select_next_line)
     nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
   endfunction
 endfunction



 "-------------------------------------------------------------
 " grep検索(agを使う)
 "-------------------------------------------------------------
 " 大文字小文字を区別しない
 let g:unite_enable_ignore_case = 1
 let g:unite_enable_smart_case = 1
 let g:ag_prg='/usr/local/bin/ag'
 " grep検索
 nnoremap <silent> ,,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
 " カーソル位置の単語をgrep検索
 nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
 " grep検索結果の再呼出
 nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
 " unite grep に ag(The Silver Searcher) を使う
 if executable('ag')
   let g:unite_source_grep_command = 'ag'
   let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
   let g:unite_source_grep_recursive_opt = ''
 endif


 "------------------------------------
 " neocomplete.vim
 "------------------------------------
 "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
 " Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
 let g:neocomplete#sources#syntax#min_keyword_length = 3
 let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
 " Plugin key-mappings.
 inoremap <expr><C-g>     neocomplete#undo_completion()
 inoremap <expr><C-l>     neocomplete#complete_common_string()

 " Recommended key-mappings.
 " <CR>: close popup and save indent.
 inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
 function! s:my_cr_function()
   " return neocomplete#close_popup() . "\<CR>"
   " For no inserting <CR> key.
   return pumvisible() ? neocomplete#close_popup() : "\<CR>"
 endfunction
 " <TAB>: completion.
 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 " <C-h>, <BS>: close popup and delete backword char.
 inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
 inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
 inoremap <expr><C-y>  neocomplete#close_popup()
 inoremap <expr><C-e>  neocomplete#cancel_popup()

 " Close popup by <Space>.
 inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"



 "-------------------------------------------------
 " quickrunの選択範囲実行
 "-------------------------------------------------
 let g:quickrun_no_default_key_mappingsi=1
         nnoremap <silent> <Leader>r :QuickRun -mode n<CR>
                 vnoremap <silent> <Leader>r :QuickRun -mode v<CR>

 let g:quickrun_config = {}
 let g:quickrun_config.markdown = {
       \ 'outputter' : 'null',
       \ 'command'   : 'open',
       \ 'cmdopt'    : '-a',
       \ 'args'      : '"Marked 2"',
       \ 'exec'      : '%c %o %a %s',
       \ }

 "-------------------------------------------------
 " vimfiler
 "-------------------------------------------------
 " netrw っぽく
 let g:vimfiler_as_default_explorer = 1
 " セーフモード OFF (削除やリネームをサクサクしたい)
 let g:vimfiler_safe_mode_by_default = 0
 let g:vimfiler_enable_auto_cd = 1
 " " vimfiler をサクサク起動する
 nnoremap <Space>f :<C-u>VimFiler -split -simple -winwidth=30 -no-quit<CR>


 " カレントディレクトリが Git リポジトリ内にある場合，そのリポジトリのルートを VimFiler で開く
 function! s:git_root_dir()
     if(system('git rev-parse --is-inside-work-tree') == "true\n")
         return ':VimFiler ' . system('git rev-parse --show-cdup') . '\<CR>'
     else
         echoerr '!!!current directory is outside git working tree!!!'
     endif
 endfunction
 nnoremap <expr><Leader>fg <SID>git_root_dir()


 "-------------------------------------------------
 " clever.vim
 "-------------------------------------------------
 let g:clever_f_smart_case = 1
 let g:clever_f_use_migemo = 1
 let g:clever_f_chars_match_any_signs = ';'

 "-------------------------------------------------
 " ctrlp.vim
 "-------------------------------------------------
 " (findやgrepが使える環境前提)
 " let g:ctrlp_user_command = ['.git', 'cd %s && find . -type f | grep -v .git']
 let g:ctrlp_user_command = ['ag %s -l']

 "-------------------------------------------------
 " 自動保存
 "-------------------------------------------------
 let g:auto_save = 1
 let g:auto_save_in_insert_mode = 0


 "---------------------------------------------------------------------------
 " QFixHowm
 "---------------------------------------------------------------------------
 "QFixHowmキーマップ
 let QFixHowm_Key = 'g'

 "howm_dirはファイルを保存したいディレクトリを設定。
 let howm_dir             = '~/Dropbox/memo'
 let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.howm'
 let howm_fileencoding    = 'utf-8'
 let howm_fileformat      = 'unix'
 let QFixHowm_DiaryFile   = 'diary/%Y/%m/%Y-%m-%d-000000.howm'
 let QFixHowm_FileType = 'markdown'
 let QFixHowm_Folding = 0
 "---------------------------------------------------------------------------

 nnoremap <c-y> :YRShow<CR>

 "---------------------------------------------------------------------------
 " markdown
 "---------------------------------------------------------------------------
 let g:vim_markdown_folding_disabled=1



 "---------------------------------------------------------------------------
 " easymotion
 "---------------------------------------------------------------------------
 let g:EasyMotion_do_mapping = 0 "Disable default mappings
 nmap s <Plug>(easymotion-s2)
 let g:EasyMotion_enter_jump_first = 1
 let g:EasyMotion_space_jump_first = 1
 let g:EasyMotion_use_migemo = 1
 nmap g/ <Plug>(easymotion-sn)
 xmap g/ <Plug>(easymotion-sn)
 omap g/ <Plug>(easymotion-tn)

 "---------------------------------------------------------------------------
 "incsearch.vim
 "---------------------------------------------------------------------------
 function! s:config_fuzzyall(...) abort
  return extend(copy({
  \   'converters': [
  \     incsearch#config#fuzzy#converter(),
  \     incsearch#config#fuzzyspell#converter()
  \   ],
  \ }), get(a:, 1, {}))
 endfunction
 
 noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
 noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
 noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))

 map /  <Plug>(incsearch-stay)
 map ?  <Plug>(incsearch-backward)
 map g/ <Plug>(incsearch-stay)


 let g:lightline = {
       \ 'colorscheme': 'wombat',
       \ }
 set laststatus=2

 autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

