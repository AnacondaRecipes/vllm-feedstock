#!/bin/bash

set -ex

# These are large models or models that come from gated repos that we want to skip.
skip_models=(
    Qwen/Qwen3-8B
    or Qwen/Qwen2.5-Math-PRM-7B
    or Qwen/Qwen2.5-1.5B-Instruct-GGUF
    or Qwen/Qwen2.5-1.5B-Instruct
    or Qwen/Qwen2.5-0.5B-Instruct
    or QuantFactory/gpt2-large-GGUF
    or Milos/slovak-gpt-j-405M
    or TitanML/tiny-mixtral
    or abhigoyal/vllm-medusa-llama-68m-random
    or afrideva/stablelm-3b-4e1t-GGUF
    or bartowski/Phi-3.5-mini-instruct-GGUF
    or bigcode/starcoder2-3b
    or bigcode/tiny_starcoder_py
    or bigscience/bloom-560m
    or cognitivecomputations/TinyDolphin-2.8-1.1b
    or facebook/opt-125m
    or microsoft/Phi-3.5-mini-instruct
    or microsoft/phi-2
    or mistralai/Mistral-7B-Instruct-v0.3
    or openai-community/gpt2
    or openai-community/gpt2-large
    or stabilityai/stablelm-3b-4e1t
    or tsunemoto/TinyDolphin-2.8-1.1b-GGUF
    or TinyLlama/TinyLlama-1.1B-Chat-v1.0
    or distilbert/distilgpt2
    or ArthurZ/ilama-3.2-1B
    or TheBloke/Llama-2-7B-fp16
    or JackFram/llama-160wm
    or llava-hf/llava-1.5-7b-hf
    or google/gemma-2-2b-it
    or SzymonOzog/test-gguf-moe-sample
    or intfloat/multilingual-e5-small
    or Isotr0py/test-gguf-sample

    # gated repo
    or Llama-3.2-1B
)

expanded_skip_models=${skip_models[@]}

time pytest -v -s tests/lora/test_peft_helper.py -k "not ($expanded_skip_models)"
hf cache list

time pytest -v -s tests/multimodal/test_inputs.py -k "not ($expanded_skip_models)"
hf cache list

time pytest -v -s tests/multimodal/test_image.py -k "not ($expanded_skip_models)"
hf cache list

time pytest -v -s tests/multimodal/test_hasher.py -k "not ($expanded_skip_models)"
hf cache list

# Needs 'av' package
# Still a couple of failures I need to figure out
# Deselection some tests due to lack of support for 8x8 resolution videos on the
# available openh264 codec.
# tests/multimodal/test_video.py::test_video_processor_from_model_repo[glm4v]
# tests/multimodal/test_video.py::test_video_processor_from_model_repo[glm46v]
# tests/multimodal/test_video.py::test_video_processor_from_model_repo[qwen3vl]
# tests/multimodal/test_video.py::test_video_processor_from_model_repo[qwen2vl]
# tests/multimodal/test_video.py::test_video_processor_from_model_repo[qwen2_5_vl]
time pytest -v -s tests/multimodal/test_video.py -k "not ($expanded_skip_models or test_video_processor_from_model_repo[glm4v] or test_video_processor_from_model_repo[glm46v] or test_video_processor_from_model_repo[qwen3vl] or test_video_processor_from_model_repo[qwen2vl] or test_video_processor_from_model_repo[qwen2_5_vl] )"
hf cache list

# run the whole samplers directory minus a few tests
# Skipped tests are for gated repos and unsupported gpu architectures
# deselecting tests/samplers/test_no_bad_words.py::TestTwoTokenBadWord::test_two_token_bad_word due to lack of flashinfer support
time pytest -v -s tests/samplers -k "not ($expanded_skip_models or test_beam_search_passes_multimodal_data or test_one_token_bad_word or test_two_token_bad_word[True])" --deselect tests/samplers/test_no_bad_words.py::TestTwoTokenBadWord::test_two_token_bad_word
hf cache list

pytest -v -s tests/detokenizer/ -k "not ($expanded_skip_models)" --ignore tests/detokenizer/test_stop_reason.py --ignore tests/detokenizer/test_stop_strings.py
hf cache list

# flash_attention doesn't work on g4dn instances (GPU is too old)
# pytest -v -s tests/kernels/attention/test_lightning_attn.py
# Skipping test_reshape_and_cache[auto-cuda:0-0-dtype1-10000-32-256-8-42] for out of memory error
# need to skip kv_cache_dtype=fp8 tests unless sm_89; tests:
# test_reshape_and_cache_flash_unaligned_rows[triton-NHD-fp8-dtype0]
# test_reshape_and_cache_flash_unaligned_rows[triton-NHD-fp8-dtype1]
# test_reshape_and_cache_flash_unaligned_rows[cuda-NHD-fp8-dtype0]
# test_reshape_and_cache_flash_unaligned_rows[cuda-HND-fp8-dtype0]
time pytest -v -s tests/kernels/attention/test_cache.py -k "(test_copy_blocks or test_reshape_and_cache) and not (test_fp8_e4m3_conversion[cuda:0-0-dtype1 or test_reshape_and_cache_flash[HND-fp8-cuda:0-0-dtype1 or test_reshape_and_cache[fp8-cuda:0-0-dtype1 or test_swap_blocks[auto-cuda:0-0-dtype2-10000-32-256-8-256- or test_copy_blocks[auto-cuda:0-0-dtype2-10000-32-256-8-1-256] or test_reshape_and_cache[auto-cuda:0-0-dtype2-10000-32-256-8-42] or test_fp8_e4m3_conversion[cuda:0-0-dtype2-10000-32-256-8] or test_reshape_and_cache_flash[NHD-fp8-cuda:0-0-dtype1 or fp8-cuda:0-0-dtype0 or triton-tensor-NHD-fp8-cuda:0-0-dtype1 or test_reshape_and_cache_flash_unaligned_rows[triton-NHD-fp8-dtype0] or test_reshape_and_cache_flash_unaligned_rows[triton-NHD-fp8-dtype1] or test_reshape_and_cache_flash_unaligned_rows[cuda-NHD-fp8-dtype0] or test_reshape_and_cache_flash_unaligned_rows[cuda-HND-fp8-dtype0] or test_reshape_and_cache[auto-cuda:0-0-dtype1-10000-32-256-8-42])"
hf cache list

time pytest -v -s tests/kernels/quantization/test_fp8_quant.py tests/kernels/quantization/test_awq_triton.py -k "not ($expanded_skip_models or test_scaled_mm or test_w8a8_fp8_fused_moe or test_w8a8_block_int8_matmul or test_fp8_quant_large or test_moe)" --ignore tests/kernels/quantization/test_marlin_gemm.py
hf cache list

time pytest -v -s tests/reasoning/ -k "not ($expanded_skip_models)" --ignore tests/reasoning/test_cohere_command_reasoning_parser.py
hf cache list

time pytest -v -s tests/cuda
time pytest -v -s tests/v1/cudagraph/test_cudagraph_dispatch.py
time pytest -v -s tests/v1/cudagraph/test_breakable_cudagraph.py

# Show which repos were downloaded during testing and how much space they take up
hf cache list