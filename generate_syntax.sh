#!/bin/bash
# generate_syntax.sh
# Generate Vim syntax file from ctags.
#
# Author: Nathan Campos <nathan@innoveworkshop.com>

# Directories.
tagsdir="."
syntaxfile="syntax/esp8266.vim"

# Terminal coloring.
bold=$(tput bold)
normal=$(tput sgr0)

# Usage dialog.
function usage {
	echo "Usage: ${bold}$0${normal} tag_folder"
	echo -e "\n    tag_folder\tWhere the tags should reside."
	echo

	exit 1
}

# Creates a syntax file and adds a header to it.
function create_file {
	echo -e "${bold}Creating a new syntax file${normal}"
	echo "Deleting old syntax file"
	rm -f $syntaxfile
	touch $syntaxfile
	echo "Adding a header to the syntax file"

	echo '" ============================================================================' >> $syntaxfile
	echo '" File:        esp8255.vim' >> $syntaxfile
	echo '" Description: Syntax highlighting for the Espressif ESP8266 Non-OS SDK.' >> $syntaxfile
	echo '" Author:      Nathan Campos <nathan@innoveworkshop.com>' >> $syntaxfile
	echo '" License:     MIT' >> $syntaxfile
	echo '" Notes:       Generated by generate_syntax.sh, do not modify otherwise your' >> $syntaxfile
	echo '"              changes are going to be overwritten.' >> $syntaxfile
	echo '" ============================================================================' >> $syntaxfile
	echo '' >> $syntaxfile
}

# Finishes the syntax file with a footer.
function finish_file {
	echo -e "${bold}Finishing the syntax file${normal}"
	echo "Adding a footer"

	echo 'highlight link espFunction Function' >> $syntaxfile
	echo 'highlight link espMacro Macro' >> $syntaxfile
	echo 'highlight link espEnum Macro' >> $syntaxfile
	echo 'highlight link espStruct Type' >> $syntaxfile
	echo '' >> $syntaxfile
}

# Builds the syntax file.
function build_syntax {
	echo -e "${bold}Actually building the syntax file${normal}"

	for tagfile in $tagsdir/*; do
		tagtype=$(basename $tagfile)
		syndef="espUnknown"

		# Tell the user what you are parsing now.
		if [[ $tagtype == "functions" ]]; then
			echo "Building syntax for functions"
			echo "\" Functions" >> $syntaxfile
			syndef="espFunction"
		elif [[ $tagtype == "macros" ]]; then
			echo "Building syntax for macros"
			echo "\" Macros" >> $syntaxfile
			syndef="espMacro"
		elif [[ $tagtype == "structs" ]]; then
			echo "Building syntax for structs, typedefs and unions"
			echo "\" Structs, typedefs and unions" >> $syntaxfile
			syndef="espStruct"
		elif [[ $tagtype == "enums" ]]; then
			echo "Building syntax for enumerators"
			echo "\" Enumerators" >> $syntaxfile
			syndef="espEnum"
		fi

		# Read the tags file line-by-line.
		while IFS='' read -r line || [[ -n "$line" ]]; do
			if [[ $line =~ ^([A-Za-z_][A-Za-z_0-9]+)[[:blank:]].+$ ]]; then
				keyword=${BASH_REMATCH[1]}

				# What the fuck was Espressif thinking when they made these header files?????
				if [[ $line =~ os_type\.h ]]; then
					# Handle "struct-like" defines in os_type.h
					echo "syntax keyword espStruct $keyword" >> $syntaxfile
				elif [[ $line =~ ^os_.+osapi\.h.+ ]]; then
					# Handle the os_* functions that are redefined using #define.
					echo "syntax keyword espFunction $keyword" >> $syntaxfile
				else
					# The stuff that makes sense.
					echo "syntax keyword $syndef $keyword" >> $syntaxfile
				fi
			fi
		done < "$tagfile"

		echo '' >> $syntaxfile
	done
}

# The actual execution of the script.
if [[ $# -gt 0 ]]; then
	# Set the paths.
	tagsdir=$1

	create_file
	build_syntax
	finish_file

	echo -e "${bold}Done${normal}"
else
	# Don't know how to use it?
	usage
fi

