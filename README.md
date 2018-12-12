# esp8266.vim

A [Vim](https://vim.org/) plugin to help you with your ESP8266 Non-OS (maybe RTOS too?) SDK projects. This plugin includes tags for auto completion and syntax highlighting.

We recommend using [universal-ctags](https://ctags.io/) since it's more up-to-date than [exuberant-ctags](http://ctags.sourceforge.net/).

## Building

This plugin comes with tags and syntax generated from SDK version `ESP8266_NONOS_SDK-2.1.0-18-g61248df`, but if you wish to build it for your own SDK version it is extremely simple:

    make clean
    make

Now you should have up-to-date tags and syntax highlighting.
