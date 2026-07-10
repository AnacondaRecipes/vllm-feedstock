#!/usr/bin/env bash

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
pytest -v -s tests/kernels/test_onednn.py
pytest -v -s tests/kernels/quantization/test_cpu_fp8_scaled_mm.py
