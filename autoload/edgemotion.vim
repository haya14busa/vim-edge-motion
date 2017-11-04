"=============================================================================
" FILE: autoload/edgemotion.vim
" AUTHOR: haya14busa
" License: MIT license
"=============================================================================
scriptencoding utf-8

let s:DIRECTION = { 'FORWARD': 1, 'BACKWARD': 0 }

function! edgemotion#move(dir) abort
  if mode(1) is# 'v' || mode(1) is# 'V' || mode(1) is# 'CTRL_V'
    let visual_mode = 1
  elseif mode(1) is# 'no'
    let visual_mode = 0
  else
    let visual_mode = 0
    normal! V
  endif

  let next_cmd = a:dir is# s:DIRECTION.FORWARD ? 'gj' : 'gk'
  let prev_cmd = a:dir is# s:DIRECTION.FORWARD ? 'gk' : 'gj'
  let orig_col = virtcol('.')
  let last_line = line('.')
  call winrestview({'curswant': col('.')})
  while 1
    if visual_mode == 1
      execute next_cmd
    else
      execute 'normal!' next_cmd
    endif
    if (virtcol('.') < orig_col) || (orig_col is# 1 && getline('.') ==# '')
      if visual_mode == 1
        execute prev_cmd
      else
        execute 'normal!' prev_cmd
      endif
      break
    elseif line('.') is# last_line
      break
    endif
    let last_line = line('.')
  endwhile
endfunction

" __END__
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
