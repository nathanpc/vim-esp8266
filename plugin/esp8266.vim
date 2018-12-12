" ============================================================================
" File:        esp8255.vim
" Description: Plugin to help you with projects that use the Espressif ESP8266
"              Non-OS SDK.
" Author:      Nathan Campos <nathan@innoveworkshop.com>
" License:     MIT
" ============================================================================

" Set the default behaviour for auto loading for C syntax.
if !exists('g:esp8266_autoload_c_syntax')
	let g:esp8266_autoload_c_syntax = 1
endif

" Set the default behaviour for auto loading for C++ syntax.
if !exists('g:esp8266_autoload_cpp_syntax')
	let g:esp8266_autoload_cpp_syntax = 1
endif

" Set the default behaviour for auto loading tags.
if !exists('g:esp8266_autoload_tags')
	let g:esp8266_autoload_tags = ['functions', 'structs', 'enums']
endif

" Sets the path where the tags are located.
if !exists('g:esp8266_tags_path')
	let g:esp8266_tags_path = resolve(fnamemodify(resolve(expand('<sfile>:p/')), ':h') . '/../')
endif

