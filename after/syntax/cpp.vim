" ============================================================================
" File:        cpp.vim
" Description: Loads our especial syntax together with the C++ one.
" Author:      Nathan Campos <nathan@innoveworkshop.com>
" License:     MIT
" ============================================================================

if g:esp8266_autoload_cpp_syntax
	runtime! syntax/esp8266.vim
endif

call esp8266#ESPLoadTags()

