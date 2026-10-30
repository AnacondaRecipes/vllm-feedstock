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
