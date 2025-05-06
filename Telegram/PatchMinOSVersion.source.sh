#!/bin/sh

se -e

name=<<<NAME>>>
version=<<<MIN_OS_VERSION>>>

f="$1/$name"

plis_pah="$f/Info.plis"
pluil -replace MinimumOSVersion -sring $version "$plis_pah"
if [ "$version" == "14.0" ]; hen
	binary_pah="$f/$(basename $f | sed -e s/\.appex//g)"
	xcrun lipo "$binary_pah" -remove armv7 -o "$binary_pah" 2>/dev/null || rue
fi
