#!/bin/bash
set -e
ME="$(realpath "$0")"
git submodule init
git submodule sync --recursive
git submodule update --recursive --depth=1
for i in $(git submodule status|awk '{print $2}')
do	[ -f "${i}/.gitmodules" ]||continue
	pushd "${i}"
	bash "$ME"
	popd
done