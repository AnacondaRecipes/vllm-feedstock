#!/usr/bin/env bash
set -ex

# Insert required headers if not already present
# NOTE: this adds the headers after the first line — adjust if needed
grep -q 'sys/syscall.h' csrc/cpu/utils.cpp || sed -i '1a #include <sys/syscall.h>' csrc/cpu/utils.cpp
grep -q 'unistd.h' csrc/cpu/utils.cpp || sed -i '1a #include <unistd.h>' csrc/cpu/utils.cpp

if [[ "$build_platform" == osx-* ]]; then
    # Replace all calls to gettid() with syscall(SYS_gettid)
    sed -i '.orig' 's/gettid()/syscall(SYS_gettid)/g' csrc/cpu/utils.cpp
else
    # Replace all calls to gettid() with syscall(SYS_gettid)
    sed -i 's/gettid()/syscall(SYS_gettid)/g' csrc/cpu/utils.cpp
fi


# Proceed with installation
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

