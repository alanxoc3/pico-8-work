#!/bin/bash
# Looks at all the library files, and copies the relevant ones into the source
# folder.

# Change this to the correct path of the libraries.
LIBPATH=~/.lexaloffle/pico-8/carts/alan-pico-lib/

PATHS=$(find $LIBPATH -path '*/src/*.p8' | grep -v /demo)

if [ -z $1 ]; then exit; fi

if [ $1 = "update" ]; then
	for path in $PATHS; do
		name=$(echo $path | sed 's/^.*\///g')
		if [ -e lib/$name ]; then
			cp -v $path ./lib/
		fi
	done
fi

if [ $1 = "view" ]; then
	for path in $PATHS; do
		name=$(echo $path | sed 's/^.*\///g')
		echo $name
	done
fi
