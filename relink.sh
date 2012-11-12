#!/usr/bin/env bash

# Symlink all $repodir dotfiles in $linkdest and remove any
# broken $linkdest (dotfile) links.
#
# 11/12/2012 - initial version (dmachay)
#

# Background:
# This is used to manage the git dotfile repo; run this script
# after adding or removing dotfiles to $repodir to automatically
# add/remove the symlinks in $linkdest. 
# - Files that don't start with a dot in $dotfiles are ignored. 
# - Files in $ignore_list are ignored (.git should be there)
# - Existing links and "real" dotfiles are not changed for safety. 
# - Broken dotfile links in $linkdest are deleted.

repodir=~/dotfiles
linkdest=~
ignore_list=( .git )

# Create links
for f in $(ls -1A $repodir | egrep -e "^\."); do
	for igf in ${ignore_list[@]}; do
		if [ $igf == $f ]; then
			continue 2
		fi
	done
	
	if [ -e $linkdest/$f ]; then
		if [ ! -L $linkdest/$f ]; then
			echo "Not changing existing (non-symlink) file: $linkdest/f"
		fi
		# Silently ignore existing symlinks
		continue
	fi
	
	echo "Creating link $linkdest/$f -> $repodir/$f"
	ln -s $repodir/$f $linkdest/$f
	
done

# Delete broken links
for f in $(ls -1A $linkdest | egrep -e "^\."); do
	if [ -L $linkdest/$f -a ! -e $linkdest/$f ]; then
		echo "Removing broken link $linkdest/$f"
		rm $linkdest/$f
	fi
done
		