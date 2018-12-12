# Makefile
# Creates a common interface for users to automate the tag and syntax
# highlighting generation.
#
# Author: Nathan Campos <nathan@innoveworkshop.com>

# Directories.
TAGSDIR = tags
SDKPATH = ~/external/forks/esp-open-sdk/ESP8266_NONOS_SDK-2.1.0-18-g61248df

all: syntax/esp8266.vim

syntax/esp8266.vim: $(TAGSDIR)/functions $(TAGSDIR)/enums $(TAGSDIR)/structs
	@./generate_syntax.sh $(TAGSDIR)

$(TAGSDIR)/functions $(TAGSDIR)/enums $(TAGSDIR)/structs:
	@./generate_tags.sh $(TAGSDIR) $(SDKPATH)
	@echo

clean:
	rm -rf $(TAGSDIR)
	rm -rf "syntax/esp8266.vim"

