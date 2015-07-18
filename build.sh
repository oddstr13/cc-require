#!/bin/bash
NAME="cc-require"

if [ -z "${VERSION}" ]; then
    VERSION=$(printf "%s.%s.%s" "$(tail -n1 .hgtags | cut -d' ' -f2)" "$(hg identify -n)" "$(hg identify -i)")
fi

if [ -z "${BUILDDIR}" ]; then
    BUILDDIR=$(dirname $(realpath $0))/build
fi

BRANCH="$(hg identify -b)"

# Clean up
rm -rv "${BUILDDIR}"


OUTPUT="${BUILDDIR}/${NAME}_${BRANCH}_${VERSION}"


mkdir -p "${BUILDDIR}"

# Docs
pandoc -f markdown README.md -t html5 -o "${OUTPUT}.html"
pandoc -f markdown README.md -t tools/panbbcode.lua -o "${OUTPUT}.bbcode"
pandoc -f markdown README.md -t latex -V links-as-notes -V geometry:margin=2cm -V fontsize=12pt -V toc -o "${OUTPUT}.pdf"

# Build
if [ -n "$(which 7z)" ]; then
    7z a "${OUTPUT}.zip" pack.mcmeta pack.png assets/
    exit 0
fi

if [ -n "$(which 7zr)" ]; then
    7zr a "${OUTPUT}.zip" pack.mcmeta pack.png assets/
    exit 0
fi

if [ -n "$(which zip)" ]; then
    mkdir -p $(dirname "${OUTPUT}")
    zip -r "${OUTPUT}.zip" pack.mcmeta pack.png assets/
    exit 0
fi
