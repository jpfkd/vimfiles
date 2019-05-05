function! s:IsInRTP(afile)
  return index(map(split(&rtp, ','), 'resolve(v:val)'), resolve(a:afile)) != -1
endfunction

augroup ftdetectvimhelp
  au!
  au BufRead,BufNewFile */doc/* if s:IsInRTP(expand('<afile>:p:h:h')) |
        \   set ft=help |
        \ endif
augroup END
