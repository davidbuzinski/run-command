#!/bin/bash

RMC_BASE_URL='https://mw-ci-static-dev.s3.amazonaws.com/run-matlab-command/experimental'
SUPPORTED_OS=('win64' 'maci64' 'maca64' 'glnxa64')

# Create dist directory if it doesn't already exist
DISTDIR="$(pwd)/dist/bin"
mkdir -p $DISTDIR

# Download and extract in a temporary directory
WORKINGDIR=$(mktemp -d -t rmc_build.XXXXXX)
cd $WORKINGDIR

for os in ${SUPPORTED_OS[@]}
do
    if [[ $os == 'win64' ]] ; then
        bin_ext='.exe'
    else
        bin_ext=''
    fi
    mkdir -p "$WORKINGDIR/$os"
    wget -O  "$WORKINGDIR/$os/run-matlab-command$bin_ext" "$RMC_BASE_URL/$os/run-matlab-command$bin_ext"
done

mv -f ./* "$DISTDIR/"
rm -rf $WORKINGDIR
