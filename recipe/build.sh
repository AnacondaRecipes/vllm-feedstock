#!/usr/bin/env bash
set -ex

# Apply patch using standard git-style -p1
patch -p1 < "${RECIPE_DIR}/fix-gettid.patch"

# Install package
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

