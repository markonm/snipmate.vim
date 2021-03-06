" These are the mappings for snipMate.vim. Putting it here ensures that it
" will be mapped after other plugins such as supertab.vim.
if !exists('loaded_snips') || exists('s:did_snips_mappings')
	finish
endif
let s:did_snips_mappings = 1

" This is put here in the 'after' directory in order for snipMate to override
" other plugin mappings (e.g., supertab).
"
" You can safely adjust these mappings to your preferences (as explained in
" :help snipMate-remap).
" Trigger snipmate
inoremap <silent> <expr> <Plug>SnipmateTrigger pumvisible() ? "<c-y><c-r>=TriggerSnippet()<cr>" : "<c-r>=TriggerSnippet()<cr>"
snoremap <silent> <Plug>SnipmateTrigger <esc>i<right><c-r>=TriggerSnippet()<cr>
" go backwards
inoremap <silent> <Plug>SnipmateBackwards <c-r>=BackwardsSnippet()<cr>
snoremap <silent> <Plug>SnipmateBackwards <esc>i<right><c-r>=BackwardsSnippet()<cr>
" show all snippets
inoremap <silent> <Plug>SnipmateMenu <c-r>=ShowAvailableSnips()<cr>

" The default mappings for these are annoying & sometimes break snipMate.
" You can change them back if you want, I've put them here for convenience.
snor <bs> b<bs>
snor <right> <esc>a
snor <left> <esc>bi
snor ' b<bs>'
snor ` b<bs>`
snor % b<bs>%
snor U b<bs>U
snor ^ b<bs>^
snor \ b<bs>\
snor <c-x> b<bs><c-x>

" By default load snippets in snippets_dir
if empty(snippets_dir)
	finish
endif

call GetSnippets(snippets_dir, '_') " Get global snippets

au FileType,BufEnter * if &ft != 'help' | call GetSnippets(snippets_dir, &ft) | endif

" create command for SnipEdit
fun! SnippetsEdit(mods)
  if &ft == ''
    exe a:mods . " split " . g:snippets_dir . "_.snippets"
  else
    exe a:mods . " split " . g:snippets_dir . &ft . ".snippets"
  endif
endf
command! SnipEdit :call SnippetsEdit(<q-mods>)

" vim:noet:sw=4:ts=4:ft=vim
