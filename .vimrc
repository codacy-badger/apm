let g:ycm_global_ycm_extra_conf = '.ycm_extra_conf.py'
" Don't ask for load the YCM configuration.
let g:ycm_confirm_extra_conf = 0
" Comments which started with "TODO:" prefix.
let g:todo_search_path = 'src/*.{hpp,cpp}'

set makeprg=make\ debug
" Automatically insert a copyright message.
autocmd BufNewFile *.{cpp,hpp} :LicenseApache
autocmd QuitPre * :mks! .session.vim
