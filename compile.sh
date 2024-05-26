#!/bin/bash

# Compile all the .po files to .mo binary files.
# Copyright (C) 2022  Gouenji Shuuya (Github: gouenji-shuuya)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

###############################################################################

shopt -s extglob
shopt -s globstar

script_dir=$(dirname "$0")
cd $script_dir

generated_dir="0_generated"

for lang in $script_dir/!(0_generated|0_pot)/; do
	for filename in $lang/**/*.po; do
		relative_path=$(dirname ${filename#"$lang/"})
		dest="$generated_dir/$relative_path/$lang/LC_MESSAGES/"
		mkdir -p "$dest"
		cp $filename $dest
	done
done


for filename in $generated_dir/**/*.po; do
	msgfmt -c $filename -o ${filename%.*}.mo
done

###############################################################################

# End of file.
