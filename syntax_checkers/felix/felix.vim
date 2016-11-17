"============================================================================
"File:        felix.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Garrett Bluma <garrett.bluma at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_felix_felix_checker')
    finish
endif
let g:loaded_syntastic_felix_felix_checker = 1

if !exists('g:syntastic_felix_felix_exec')
    let g:syntastic_felix_felix_exec = 'flx'
endif

let s:save_cpo = &cpo
set cpo&vim

" TODO: Highlighting
function! SyntaxCheckers_felix_felix_GetHighlightRegex(item)
    let term = matchstr(a:item['text'], "\\mCLIENT ERROR'\\zs[^']\\+\\ze'")
    return term !=# '' ? '\V' . escape(term, '\') : ''
endfunction

function! SyntaxCheckers_felix_felix_GetLocList() dict

    let makeprg = self.makeprgBuild({
        \ 'exe' : 'flx',
        \ 'args' : '-c --nocc' })

    let errorformat = 
        \     'See also %f: line %l\, cols %c%m,' .
        \         'See: %f: line %l\, cols %c%m,' .
        \          'In: %f: line %l\, cols %c%m,' .
        \              '%f: line %l\, cols %c%m,' .
        \     'Fatal error%m,'  .
        \     '%m,'  .
        \     '%-G%.%#'


    return SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'felix',
    \ 'name': 'felix' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
