" syntax/esp8255.vim
" Syntax highlighting for the Espressif ESP8266 Non-OS SDK.
"
" Author: Nathan Campos <nathan@innoveworkshop.com>

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

