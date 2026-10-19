#!/usr/bin/env bash
set -ex

export CMAKE_BUILD_TYPE=Release

echo ===========================================================
echo "Building with VLLM_TARGET_DEVICE=$VLLM_TARGET_DEVICE"
echo ===========================================================

if [[ "${gpu_variant}" == "cuda" ]]; then
    export VLLM_FLASH_ATTN_SRC_DIR=$SRC_DIR/flash-attention
    echo $VLLM_FLASH_ATTN_SRC_DIR
    sed -i.bak "s/set(TORCH_SUPPORTED_VERSION_CUDA \"2.4.0\")/set(TORCH_SUPPORTED_VERSION_CUDA \"${pytorch}\")/g" $SRC_DIR/flash-attention/CMakeLists.txt
    #export VLLM_FLASH_ATTN_SRC_DIR=$SRC_DIR/flash-attention

    export VLLM_CUTLASS_SRC_DIR=$SRC_DIR/cutlass-src

    # arch list is from pytorch feedstock: https://github.com/AnacondaRecipes/pytorch-feedstock/blob/8da9b2d5acf0735e7c2082819aca7eeae3094c62/recipe/build.sh#L239
    if [[ "$target_platform" == "linux-aarch64" && "${cuda_compiler_version}" == 13.* ]]; then
        export TORCH_CUDA_ARCH_LIST="8.0;9.0;10.0;11.0;12.0;12.1+PTX"
    elif [[ "${cuda_compiler_version}" == 12.* ]]; then
        export TORCH_CUDA_ARCH_LIST="7.5;8.0;8.6;9.0;10.0;12.0+PTX"
        # More recent builds of vllm seem to use less memory than older builds, allowing
        # us to have 6 or more concurrent jobs on a machine with 64G of memory
        MEM=$(free -g | grep Mem | awk '{print $2}')
        export MAX_JOBS=$(python -c "print(int( $MEM )//12 + 1 + max($MEM-64, 0)//10)")
        echo MAX_JOBS=$MAX_JOBS
    elif [[ "${cuda_compiler_version}" == 13.* ]]; then
        export TORCH_CUDA_ARCH_LIST="7.5;8.0;8.6;9.0;10.0;12.0+PTX"
        # More recent builds of vllm seem to use less memory than older builds, allowing
        # us to have 6 or more concurrent jobs on a machine with 64G of memory
        MEM=$(free -g | grep Mem | awk '{print $2}')
        export MAX_JOBS=$(python -c "print(int( $MEM )//12 + 1 + max($MEM-64, 0)//10)")
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

