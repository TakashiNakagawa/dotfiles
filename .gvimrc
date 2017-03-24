 "  set showtabline=2
 " ツールバーを削除
 set guioptions-=T

 "半角文字の設定
 set visualbell t_vb=


 " ------------------------------------------------------
 " colorscheme
 " ------------------------------------------------------
"  syntax on


"  let g:hybrid_use_Xresources = 1

 " if g:colors_name ==? 'hybrid'
   hi Visual gui=none guifg=khaki guibg=olivedrab
 " endif

  " window size
  if has("win32")
      " au GUIEnter * simalt ~x
      set guifont=Migu_1M:h11
      au GUIEnter * set lines=60
      au GUIEnter * set columns=190
  else
      "set transparency=8
      "set guifont=Ricty:h13
      au GUIEnter * set lines=60
      au GUIEnter * set columns=190
  endif

"  augroup hack234
"    autocmd!
"    if has('mac')
"      autocmd FocusGained * set transparency=0
"      "autocmd FocusLost * set transparency=50
"    endif
"  augroup END


 " 日本語入力ON時のカーソルの色を設定
 if has('multi_byte_ime') || has('xim')
     " highlight CursorIM guibg=DarkCyan guifg=NONE
     " highlight CursorIM guibg=darkmagenta guifg=NONE
 endif

 " highlight CursorColumn ctermbg=Blue
