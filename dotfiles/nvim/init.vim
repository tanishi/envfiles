if &compatible
  set nocompatible
endif

function! s:source_rc(path, ...) abort "{{{
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('~/.config/nvim/rc/' . a:path))
  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  let content = map(readfile(abspath), 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  let tempfile = tempname()
  try
    call writefile(content, tempfile)
    execute 'source' fnameescape(tempfile)
  finally
    if filereadable(tempfile)
      call delete(tempfile)
    endif
  endtry
endfunction "}}}

augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *? call vimrc#on_filetype()
augroup END

if has('vim_starting')
  call s:source_rc('init.rc.vim')
endif

if filereadable(expand('~/.config/nvim/local.vim'))
  execute "source" expand("~/.config/nvim/local.vim")
endif

call s:source_rc('dein.rc.vim')

if has('vim_starting') && !empty(argv())
  call vimrc#on_filetype()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')

  syntax enable
  filetype plugin indent on
endif

call s:source_rc('options.rc.vim')
call s:source_rc('mappings.rc.vim')

set secure


