#!/bin/bash -eu

cd "$(dirname "$0")"

CGO_ENABLED=0 source ./build.bash -tags without_openssl

# ld.so needs the "./" prefix or it always return false.
# This is also how ldd calls it acc. to strace.
if ld.so --verify ./gocryptfs ; then
	echo "build-without-openssl.bash: error: compiled binary is not static"
	exit 1
fi
