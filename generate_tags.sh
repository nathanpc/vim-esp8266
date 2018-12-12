#!/bin/bash
# generate_tags.sh
# Generate tags for the ESP8266 SDK headers.
#
# Author: Nathan Campos <nathan@innoveworkshop.com>

# Directories.
sdkdir="."
tagsdir="."

# Terminal coloring.
bold=$(tput bold)
normal=$(tput sgr0)

# Usage dialog.
function usage {
	echo "Usage: $bold$0$normal tag_folder sdk_dir"
	echo -e "\n    tag_folder\tWhere the tags should reside."
	echo -e "    sdk_dir\tPath to the ESP8266_NONOS_SDK-* directory."
	echo

	exit 1
}

# Creates the necessary folders for placing tags into.
function create_dirs {
	echo "${bold}Creating the tags directory${normal}"
	
	echo "Creating $tagsdir/"
	mkdir -p "$tagsdir/"
}

# Cleans the tags directory.
function clean {
	echo "${bold}Deleting $tagsdir/${normal}"
	rm -rf "$tagsdir"
}

# Build tags, but documenting code is pretty nice huh?
function build_tags {
	hdir="$sdkdir/include"
	echo "${bold}Building tags for the ESP8266 standard API${normal}"

	for header in $hdir/*.h; do
		echo "Building tags from $bold$(basename $header)$normal"
		
		echo "  --> Functions"
		ctags --c-kinds=p -a -o "$tagsdir/functions" "$header"
		echo "  --> Macros"
		ctags --c-kinds=d -a -o "$tagsdir/macros" "$header"
		echo "  --> Enumerators"
		ctags --c-kinds=eg -a -o "$tagsdir/enums" "$header"
		echo "  --> Structs, typedefs and unions"
		ctags --c-kinds=mstux -a -o "$tagsdir/structs" "$header"
	done
}

# The actual execution of the script.
if [[ $# -gt 1 ]]; then
	# Set the paths.
	tagsdir=$1
	sdkdir=$2

	clean
	create_dirs
	build_tags

	echo -e "${bold}Done${normal}"
else
	# Don't know how to use it?
	usage
fi

