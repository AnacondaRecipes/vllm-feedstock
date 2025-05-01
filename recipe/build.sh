#!/usr/bin/env bash
set -ex

# Apply the patch manually
patch -p1 < "${RECIPE_DIR}/fix-gettid.patch"

# Build and install using pip (respecting isolated env)
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

