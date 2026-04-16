#!/usr/bin/env bash

set -e
set -x

pytest tests/core/test_scheduler.py

pytest -v -s tests/kernels/attention/test_cache.py -m cpu_model
pytest -v -s tests/kernels/attention/test_mla_decode_cpu.py -m cpu_model

SKIP_TESTS=(
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-openai-community/gpt2]
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-facebook/opt-125m]
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-Qwen/Qwen2.5-0.5B-Instruct]
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-TitanML/tiny-mixtral]
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-google/gemma-1.1-2b-it]
    --deselect tests/models/language/generation/test_common.py::test_models[False-5-32-meta-llama/Llama-3.2-1B-Instruct]
)
VLLM_CPU_SGL_KERNEL=1 pytest -v -s tests/models/language/generation ${SKIP_TESTS[@]} -m cpu_model

pytest -s -v \
    tests/quantization/test_compressed_tensors.py::test_compressed_tensors_w8a8_static_setup \
    tests/quantization/test_compressed_tensors.py::test_compressed_tensors_w8a8_dynamic_per_token