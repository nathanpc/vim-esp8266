" ============================================================================
" File:        esp8266.vim
" Description: Plugin to help you with projects that use the Espressif ESP8266
"              Non-OS SDK.
" Author:      Nathan Campos <nathan@innoveworkshop.com>
" License:     MIT
" ============================================================================

" Loads the ESP tags that are defined in the autoload variable.
function! esp8266#ESPLoadTags(...)
	let a:tags_arr = get(a:, 1, g:esp8266_autoload_tags)
		for tagfile in a:tags_arr
			exe 'set tags+=' . g:esp8266_tags_path . '/tags/' . tagfile
		endfor
endfunction

