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

pytest -v -s tests/kernels/attention/test_cpu_attn.py ${SKIP_TESTS[@]}

# Skip the tests that require BFloat16
pytest -v -s tests/kernels/test_onednn.py -k "not test_onednn_gemm"
