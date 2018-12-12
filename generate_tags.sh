#!/bin/bash
# generate_tags.sh
# Generate tags for the ESP8266 SDK headers.
#
# Author: Nathan Campos <nathan@innoveworkshop.com>

# Directories.
sdkdir="/opt/microchip/xc8/v2.00"
tagsdir="."

# Flags.
ctflags="--c-kinds=+defgmpstuvxz"

# Terminal coloring.
bold=$(tput bold)
normal=$(tput sgr0)

# Usage dialog.
function usage {
	echo "Usage: $bold$0$normal tag_folder [sdk_dir]"
	echo -e "\n    tag_folder: Where the tags should reside."
	echo "    sdk_dir: Path to the ESP8266_NONOS_SDK-* directory."
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

# Builds a tag file from XC8.
#
# @param $1 Compiler name.
# @param $2 Header file location.
# @param $3 Tag file name.
function build_tag {
	echo "Building tags from $3"
	ctags $ctflags -o $tagsdir/$1/$3 $2
}

# Builds the tags for XC8.
function build_xc8 {
	hdir="$xc8dir/pic/include"
	echo "${bold}Building tags for the 8-bit family${normal}"

	for f in $hdir/*.h; do
		if [[ -f $f ]]; then
			header=$(basename $f)

			# Checks if the file is a valid device header.
			if [[ $header =~ ^pic([a-zA-Z0-9]+)\.h$ ]]; then
				# Make sure the device name is uppercase.
				device=$(echo ${BASH_REMATCH[1]} | tr a-z A-Z)

				# Build the tags.
				build_tag "xc8" $f $device
			fi
		fi
	done

	# Build the last tag for the utility headers.
	echo -e "Building tags from xc.h and pic.h as \"$tagsdir/xc8/generic\""
	ctags $ctflags -o $tagsdir/xc8/generic $hdir/xc.h $hdir/pic.h
}

# The actual execution of the script.
if [[ $# -gt 0 ]]; then
	# Set the tags folder.
	tagsdir=$1

	# Set the SDK path if specified.
	if [[ $# -eq 2 ]]; then
		sdkdir=$2
	fi

	echo -e "${bold}Done${normal}"
else
	# Don't know how to use it?
	usage
fi

