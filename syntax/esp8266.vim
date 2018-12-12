" ============================================================================
" File:        esp8255.vim
" Description: Syntax highlighting for the Espressif ESP8266 Non-OS SDK.
" Author:      Nathan Campos <nathan@innoveworkshop.com>
" License:     MIT
" ============================================================================

if exists('b:current_syntax')
	finish
endif

highlight link espFunction Function
highlight link espEnum Constant
highlight link espStruct Structure

let b:current_syntax = 'esp8266'

