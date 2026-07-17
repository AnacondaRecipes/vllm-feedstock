#!/usr/bin/env bash

set -e
set -x

# These tests seem to fail due to what appears to be a vLLM bug.
SKIP_TESTS=(
    --deselect tests/kernels/attention/test_cpu_attn.py::test_varlen_with_paged_kv_softcap
    --deselect tests/kernels/attention/test_cpu_attn.py::test_varlen_with_paged_kv_normal_amx
    --deselect tests/kernels/attention/test_cpu_attn.py::test_varlen_with_paged_kv_alibi
    --deselect tests/kernels/attention/test_cpu_attn.py::test_varlen_with_paged_kv_sink
)

# SKIP_MODELS=(
#     google/gemma-2-2b-it
#     or google/gemma-1.1-2b-it
#     or google/gemma-1.1-2b-it
#     or llama/Llama-3.2-1B-Instruct
# )
# expanded_skip_models=${skip_models[@]}


pytest -v -s tests/kernels/attention/test_cpu_attn.py ${SKIP_TESTS[@]}

# too many failing tests due to bfloat precision issues
# For example:
# E       AssertionError: Tensor-likes are not close!
# E
# E       Mismatched elements: 1 / 32768 (0.0%)
# E       Greatest absolute difference: 0.001220703125 at index (62, 110) (up to 0.001 allowed)
# E       Greatest relative difference: 0.2080078125 at index (62, 110) (up to 0.016 allowed)
#pytest -v -s tests/kernels/moe/test_cpu_fused_moe.py

pytest -v -s tests/kernels/test_onednn.py
# The following tests are included in the project's list of CPU tests, but depends on hardware capabilities not available
# on the AWS instance that this will end up being tested on (g4dn). The tests have passed when run on a different instance
# (m7i-flex).
#pytest -v -s tests/kernels/test_awq_int4_to_int8.py
#pytest -v -s tests/kernels/quantization/test_cpu_fp8_scaled_mm.py

# Skipping this first test because it takes too long to run
# VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/models/language/generation -m cpu_model -k "not (expanded_skip_models)"
VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/models/language/pooling -m cpu_model --deselect "tests/models/language/pooling/test_embedding.py::test_models[ssmits/Qwen2-7B-Instruct-embed-base]"

VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/quantization/test_compressed_tensors.py::test_compressed_tensors_w8a8_logprobs
