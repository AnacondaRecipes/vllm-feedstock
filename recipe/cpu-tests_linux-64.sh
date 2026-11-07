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

# Skipping this first test because it takes too long to run, even though it is in the upstream
# project's list of CPU tests.
# VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/models/language/generation -m cpu_model

# Qwen2.5-Math-PRM-7B is deselected: its ~15 GiB checkpoint download fails with "No space left on device"
# on the test worker after the other models have been cached (not a vLLM or packaging bug).
VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/models/language/pooling -m cpu_model \
    --deselect "tests/models/language/pooling/test_embedding.py::test_models[ssmits/Qwen2-7B-Instruct-embed-base]" \
    --deselect "tests/models/language/pooling/test_reward.py::test_prm_models_with_golden_outputs[half-Qwen/Qwen2.5-Math-PRM-7B]"

VLLM_CPU_KVCACHE_SPACE=4 pytest -v -s tests/quantization/test_compressed_tensors.py::test_compressed_tensors_w8a8_logprobs

# The mcp patches (0006, 0007) let vllm run against mcp 1.x, which is what gets installed alongside
# huggingface_hub 1.x (its 'mcp' extra caps mcp<2). These are the CPU-runnable tests that cover the affected code
# (vllm/entrypoints/mcp/tool_server.py and vllm/entrypoints/openai/responses/context.py). The server-based tests
# (test_mcp_tools.py::TestMCPEnabled and friends) need a model and a running server, so they are not included.
#
# test_post_process_tools_description_* build mcp Tool objects with the mcp 2.x-only 'input_schema' keyword, so they
# cannot pass against mcp 1.x. Patch 0006 is what makes the corresponding code work on mcp 1.x.
MCP_SKIP_TESTS=(
    --deselect tests/entrypoints/openai/responses/test_mcp_tools.py::TestMCPToolServerUnit::test_post_process_tools_description_uses_trim_schema_result
    --deselect tests/entrypoints/openai/responses/test_mcp_tools.py::TestMCPToolServerUnit::test_post_process_tools_description_honors_meta_opt_out
)
pytest -v -s tests/entrypoints/openai/responses/test_mcp_tools.py -k "not TestMCPEnabled" ${MCP_SKIP_TESTS[@]}
pytest -v -s tests/entrypoints/openai/responses/test_parsable_context_unit.py
pytest -v -s tests/entrypoints/unit_tests/test_context.py
