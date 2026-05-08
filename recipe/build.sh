#!/usr/bin/env bash
set -ex

export CMAKE_BUILD_TYPE=Release

echo ===========================================================
echo "Building with VLLM_TARGET_DEVICE=$VLLM_TARGET_DEVICE"
echo ===========================================================

if [[ "${cpu_or_cuda}" == "cuda" ]]; then
    export VLLM_FLASH_ATTN_SRC_DIR=$SRC_DIR/flash-attention
    echo $VLLM_FLASH_ATTN_SRC_DIR
    sed -i.bak "s/set(TORCH_SUPPORTED_VERSION_CUDA \"2.4.0\")/set(TORCH_SUPPORTED_VERSION_CUDA \"${pytorch}\")/g" $SRC_DIR/flash-attention/CMakeLists.txt
    #export VLLM_FLASH_ATTN_SRC_DIR=$SRC_DIR/flash-attention

    # CUDA arch list per aggregate COOKBOOK §"CUDA Arch Lists by Version":
    #   12.8: adds Blackwell SM 10.0 (10.3/12.x not supported by nvcc 12.8).
    # xformers kernels are useful from Volta (SM70) upward, but we keep the
    # broader arch list for consistency with conda-forge's published builds.
    if [[ "${cuda_compiler_version}" == 12.8 ]]; then
        export TORCH_CUDA_ARCH_LIST="5.0;6.0;6.1;7.0;7.5;8.0;8.6;8.9;9.0;10.0+PTX"
        # Some of the parallel running jobs can use more than 20GB of memory.
        # I saw one build with three processes using 23G, 20G, and 14G.
        # Max number of josb is memory limited. Calculate it based  generally on 24G per process
        export MAX_JOBS=$(python -c "print(int( $(free -g | grep Mem | awk '{print $2}') )//24 + 1)")
        echo MAX_JOBS=$MAX_JOBS
    else
        echo "Unsupported CUDA compiler version: ${cuda_compiler_version}. Edit build.sh to add target CUDA archs."
        exit 1
    fi
    export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
    export FORCE_CUDA=1
fi

# Proceed with installation
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

