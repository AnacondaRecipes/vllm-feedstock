#!/usr/bin/env bash
set -ex

export CMAKE_BUILD_TYPE=Release

echo ===========================================================
echo "Building with VLLM_TARGET_DEVICE=$VLLM_TARGET_DEVICE"
echo ===========================================================

# Proceed with installation
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

