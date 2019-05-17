let g:ycm_global_ycm_extra_conf = '.ycm_extra_conf.py'
" Don't ask for load the YCM configuration.
let g:ycm_confirm_extra_conf = 0
" Comments which started with "TODO:" prefix.
let g:todo_search_path = 'src/*.{hpp,cpp}'

fun! InitCpp()
    :LicenseApache
    exe 'normal G'
endfun
autocmd BufNewFile *.cpp :call InitCpp()

fun! InitHpp()
    :LicenseApache
    exe "normal Gi#pragma once\<Esc>o\<Esc>o"
endfun
autocmd BufNewFile *.hpp :call InitHpp()

autocmd BufWritePost *.{cpp,hpp} set makeprg=make\ debug
autocmd QuitPre * :mks! .session.vim
