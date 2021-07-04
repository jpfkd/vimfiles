" vim:ft=vim

if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.pp               setfiletype pascal
    au! BufRead,BufNewFile *dosbox*.conf      setfiletype dosini
    au! BufRead,BufNewFile */dos/*.conf       setfiletype dosini
    au! BufRead,BufNewFile /usr/include/c++/* setfiletype cpp
augroup END
