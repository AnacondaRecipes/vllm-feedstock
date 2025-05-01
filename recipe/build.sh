#!/usr/bin/env bash
set -ex

patch -p1 < "${RECIPE_DIR}/fix-gettid.patch"

$PYTHON -m pip install . -vv --no-deps --no-build-isolation

