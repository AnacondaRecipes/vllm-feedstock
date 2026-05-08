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

#pytest -v -s tests/core/test_scheduler.py

#pytest -v -s tests/kernels/attention/test_cache.py


# The list of test files from the 0.9.2 test directory. We are not going to test all of them.
# pytest -v -s tests/models/language/pooling/test_classification.py
# pytest -v -s tests/models/language/pooling/test_scoring.py
# pytest -v -s tests/models/language/pooling/test_snowflake_arctic_embed.py
# pytest -v -s tests/models/language/pooling/test_qwen3_reranker.py
#pytest -v -s tests/models/language/pooling/test_cross_encoder.py
# pytest -v -s tests/models/language/pooling/test_gte.py
# pytest -v -s tests/models/language/pooling/test_embedding.py
# pytest -v -s tests/models/language/pooling/test_nomic.py
# pytest -v -s tests/models/language/pooling/test_gritlm.py
# pytest -v -s tests/models/language/pooling/test_intfloat.py
# pytest -v -s tests/models/language/pooling/test_mxbai_rerank.py
# pytest -v -s tests/models/language/pooling/test_jina.py
# pytest -v -s tests/models/language/pooling/test_baai.py
# pytest -v -s tests/models/language/pooling/test_truncation_control.py
# pytest -v -s tests/models/language/pooling/test_nomic_max_model_len.py
#pytest -v -s tests/models/language/pooling/test_reward.py
# pytest -v -s tests/models/language/generation/test_bart.py
# pytest -v -s tests/models/language/generation/test_granite.py
#pytest -v -s tests/models/language/generation/test_common.py
# pytest -v -s tests/models/language/generation/test_gemma.py
# pytest -v -s tests/models/language/generation/test_phimoe.py
#pytest -v -s tests/models/language/generation/test_mistral.py # most of these fail on g4dn due to architecture restrictions (require >= 8.0, only have 7.5)
# pytest -v -s tests/models/language/generation/test_hybrid.py
# pytest -v -s tests/models/quantization/test_awq.py
# pytest -v -s tests/models/quantization/test_aqlm.py
#pytest -v -s tests/models/quantization/test_fp8.py # Not supported on g4dn hardware
# pytest -v -s tests/models/quantization/test_nvfp4.py
# pytest -v -s tests/models/quantization/test_modelopt.py
#pytest -v -s tests/models/quantization/test_gguf.py  # All tests pass but a lot of downloads occur during the test
# pytest -v -s tests/models/quantization/test_mxfp4.py
# pytest -v -s tests/models/quantization/test_gptq_marlin.py
# pytest -v -s tests/models/quantization/test_gptq_bitblas.py
# pytest -v -s tests/models/quantization/test_bitblas.py
# pytest -v -s tests/models/quantization/test_gptq_marlin_24.py
# pytest -v -s tests/models/multimodal/generation/test_florence2.py
# pytest -v -s tests/models/multimodal/generation/test_interleaved.py
# pytest -v -s tests/models/multimodal/generation/test_phi4mm.py
# pytest -v -s tests/models/multimodal/generation/test_pixtral.py
# pytest -v -s tests/models/multimodal/generation/test_ultravox.py
# pytest -v -s tests/models/multimodal/generation/test_mllama.py
# pytest -v -s tests/models/multimodal/generation/test_qwen2_vl.py
# pytest -v -s tests/models/multimodal/generation/test_whisper.py
# pytest -v -s tests/models/multimodal/generation/test_common.py
# pytest -v -s tests/models/multimodal/generation/test_granite_speech.py
# pytest -v -s tests/models/multimodal/pooling/test_intern_vit.py
# pytest -v -s tests/models/multimodal/pooling/test_llava_next.py
# pytest -v -s tests/models/multimodal/pooling/test_phi3v.py
# pytest -v -s tests/models/multimodal/pooling/test_dse_qwen2_vl.py
# pytest -v -s tests/models/multimodal/processing/test_mllama.py
# pytest -v -s tests/models/multimodal/processing/test_smolvlm.py
# pytest -v -s tests/models/multimodal/processing/test_common.py
# pytest -v -s tests/models/multimodal/processing/test_llava_onevision.py
# pytest -v -s tests/models/multimodal/processing/test_internvl.py
# pytest -v -s tests/models/multimodal/processing/test_phi3v.py
# pytest -v -s tests/models/multimodal/processing/test_idefics3.py
# pytest -v -s tests/models/multimodal/processing/test_phi4mm.py
# pytest -v -s tests/models/multimodal/processing/test_qwen2_vl.py
# pytest -v -s tests/models/multimodal/processing/test_llava_next.py
# pytest -v -s tests/models/multimodal/processing/test_minimax_vl_01.py
# pytest -v -s tests/models/multimodal/processing/test_h2ovl.py
# pytest -v -s tests/models/multimodal/processing/test_llama4.py
# pytest -v -s tests/models/multimodal/test_mapping.py
# pytest -v -s tests/models/test_vision.py
# pytest -v -s tests/models/test_initialization.py
# pytest -v -s tests/models/test_utils.py
# pytest -v -s tests/models/test_transformers.py
# pytest -v -s tests/models/test_registry.py
# pytest -v -s tests/models/test_oot_registration.py
# pytest -v -s tests/worker/test_encoder_decoder_model_runner.py
# pytest -v -s tests/worker/test_model_input.py
# pytest -v -s tests/worker/test_swap.py
# pytest -v -s tests/worker/test_model_runner.py
# pytest -v -s tests/worker/test_profile.py
# pytest -v -s tests/multi_step/test_correctness_llm.py
# pytest -v -s tests/multi_step/test_correctness_async_llm.py
# pytest -v -s tests/spec_decode/test_multi_step_worker.py
time pytest -v -s tests/spec_decode/test_spec_decode_worker.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/spec_decode/test_dynamic_spec_decode.py
# pytest -v -s tests/spec_decode/e2e/test_ngram_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_compatibility.py
# pytest -v -s tests/spec_decode/e2e/test_multistep_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_medusa_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_integration_dist_tp4.py
# pytest -v -s tests/spec_decode/e2e/test_seed.py
# pytest -v -s tests/spec_decode/e2e/test_mtp_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_integration_dist_tp2.py
# pytest -v -s tests/spec_decode/e2e/test_integration.py
# pytest -v -s tests/spec_decode/e2e/test_eagle_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_mlp_correctness.py
# pytest -v -s tests/spec_decode/e2e/test_logprobs.py
# pytest -v -s tests/spec_decode/test_batch_expansion.py
time pytest -v -s tests/spec_decode/test_metrics.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/spec_decode/test_utils.py
time pytest -v -s tests/spec_decode/test_ngram_worker.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/spec_decode/test_scorer.py
time pytest -v -s tests/spec_decode/test_memory_usage.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/weight_loading/test_weight_loading.py
# pytest -v -s tests/mq_llm_engine/test_abort.py
# pytest -v -s tests/mq_llm_engine/test_error_handling.py
# pytest -v -s tests/mq_llm_engine/test_load.py
# pytest -v -s tests/lora/test_transformers_model.py
# pytest -v -s tests/lora/test_layers.py
# pytest -v -s tests/lora/test_baichuan.py
# pytest -v -s tests/lora/test_resolver.py
# pytest -v -s tests/lora/test_lora_allowed_token_ids.py
# pytest -v -s tests/lora/test_lora_functions.py
# pytest -v -s tests/lora/test_worker.py
# pytest -v -s tests/lora/test_lora_manager.py
# pytest -v -s tests/lora/test_punica_ops.py
# pytest -v -s tests/lora/test_tokenizer_group.py
# pytest -v -s tests/lora/test_qwen2vl.py
# pytest -v -s tests/lora/test_llama_tp.py
# pytest -v -s tests/lora/test_add_lora.py
# pytest -v -s tests/lora/test_utils.py
# pytest -v -s tests/lora/test_mixtral.py
# pytest -v -s tests/lora/test_chatglm3_tp.py
# pytest -v -s tests/lora/test_minicpmv_tp.py
# pytest -v -s tests/lora/test_phi.py
# pytest -v -s tests/lora/test_lora_checkpoints.py
# pytest -v -s tests/lora/test_quant_model.py
time pytest -v -s tests/lora/test_peft_helper.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/lora/test_lora_huggingface.py
time pytest -v -s tests/multimodal/test_inputs.py -k "not ($expanded_skip_models)"
hf cache scan
#pytest -v -s tests/multimodal/test_utils.py # too many failed download
time pytest -v -s tests/multimodal/test_image.py -k "not ($expanded_skip_models)"
hf cache scan
time pytest -v -s tests/multimodal/test_hasher.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/multimodal/test_processing.py # test fails due to missing additional modules
time pytest -v -s tests/multimodal/test_video.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/distributed/test_sequence_parallel.py
# pytest -v -s tests/distributed/test_events.py
# pytest -v -s tests/distributed/test_utils.py
# pytest -v -s tests/distributed/test_custom_all_reduce.py
# pytest -v -s tests/distributed/test_quick_all_reduce.py
# pytest -v -s tests/distributed/test_pynccl.py
# pytest -v -s tests/distributed/test_node_count.py
# pytest -v -s tests/distributed/test_eplb_algo.py
# pytest -v -s tests/distributed/test_shm_broadcast.py
# pytest -v -s tests/distributed/test_pipeline_partition.py
# pytest -v -s tests/distributed/test_distributed_oot.py
# pytest -v -s tests/distributed/test_comm_ops.py
# pytest -v -s tests/distributed/test_ca_buffer_sharing.py
# pytest -v -s tests/distributed/test_expert_parallel.py
# pytest -v -s tests/distributed/test_torchrun_example.py
# pytest -v -s tests/distributed/test_same_node.py
# pytest -v -s tests/distributed/test_pipeline_parallel.py
# pytest -v -s tests/distributed/test_pp_cudagraph.py
# pytest -v -s tests/distributed/test_eplb_execute.py
# pytest -v -s tests/distributed/test_multi_node_assignment.py

# run the whole samplers directory minus a few tests
# Skipped tests are for gated repos and unsupported gpu architectures
time pytest -v -s tests/samplers -k "not ($expanded_skip_models or test_beam_search_passes_multimodal_data or test_one_token_bad_word or test_two_token_bad_word[True])"
hf cache scan
# pytest -v -s tests/samplers/test_ranks.py
# pytest -v -s tests/samplers/test_ignore_eos.py
# pytest -v -s tests/samplers/test_logits_processor.py
# pytest -v -s tests/samplers/test_no_bad_words.py
# pytest -v -s tests/samplers/test_sampler.py
# pytest -v -s tests/samplers/test_logprobs.py
# pytest -v -s tests/samplers/test_rejection_sampler.py
# pytest -v -s tests/samplers/test_seeded_generate.py
# pytest -v -s tests/samplers/test_beam_search.py
# pytest -v -s tests/samplers/test_typical_acceptance_sampler.py

#splitting up these core tests. The first set ignores some tests that must be run with FLASH_ATTN
# or are skipped for other reasons. The second set of tests are those trying to run with FLASH_ATTN
time pytest -v -s tests/core -k "not ($expanded_skip_models)" --ignore=tests/core/test_num_computed_tokens_update.py --ignore=tests/core/block/e2e/test_correctness.py --ignore=tests/core/block/e2e/test_correctness_sliding_window.py
hf cache scan
# FLASH_ATTN appears to not work on g4dn hardware. It requires SM >= 8.0 but g4dn is 7.5
#VLLM_ATTENTION_BACKEND=FLASH_ATTN pytest -v -s tests/core/test_num_computed_tokens_update.py -k "not ($expanded_skip_models)" 
#VLLM_ATTENTION_BACKEND=FLASH_ATTN pytest -v -s tests/core/block/e2e/test_correctness.py -k "not ($expanded_skip_models)" 
#VLLM_ATTENTION_BACKEND=FLASH_ATTN pytest -v -s tests/core/block/e2e/test_correctness_sliding_window.py -k "not ($expanded_skip_models)" 

# pytest -v -s tests/core/block/e2e/test_correctness_sliding_window.py
# pytest -v -s tests/core/block/e2e/test_correctness.py
# pytest -v -s tests/core/block/test_common.py
# pytest -v -s tests/core/block/test_naive_block.py
# pytest -v -s tests/core/block/test_prefix_caching_block.py
# pytest -v -s tests/core/block/test_block_manager.py
# pytest -v -s tests/core/block/test_block_table.py
# pytest -v -s tests/core/block/test_cpu_gpu_block_allocator.py
# pytest -v -s tests/core/test_chunked_prefill_scheduler.py
# pytest -v -s tests/core/test_num_computed_tokens_update.py
# pytest -v -s tests/core/test_scheduler_encoder_decoder.py
# pytest -v -s tests/core/test_scheduler.py
# pytest -v -s tests/core/test_serialization.py

time pytest -v -s tests/plugins/lora_resolvers/test_filesystem_resolver.py -k "not ($expanded_skip_models)"
hf cache scan
# entry points have many failures unrelated to the build qwuality (e.g. GPU type being used in the test).
# Some of the entry point tests download large models without having the tests labeled with the model name,
# making it difficult to skip the large downloads.
# Consequently, it is probably best to only run selected entrypoint tests.

# pytest -v -s tests/entrypoints/openai/test_metrics.py
# pytest -v -s tests/entrypoints/openai/test_chat.py
# pytest -v -s tests/entrypoints/openai/test_tensorizer_entrypoint.py
# pytest -v -s tests/entrypoints/openai/test_completion_with_function_calling.py
# pytest -v -s tests/entrypoints/openai/test_vision_embedding.py
# pytest -v -s tests/entrypoints/openai/test_async_tokenization.py
# pytest -v -s tests/entrypoints/openai/correctness/test_mteb_embed.py
# pytest -v -s tests/entrypoints/openai/correctness/test_transcription_api_correctness.py
# pytest -v -s tests/entrypoints/openai/correctness/test_mteb_score.py
# pytest -v -s tests/entrypoints/openai/correctness/test_lmeval.py
# pytest -v -s tests/entrypoints/openai/test_chat_logit_bias_validation.py
# pytest -v -s tests/entrypoints/openai/tool_parsers/test_pythonic_tool_parser.py
# pytest -v -s tests/entrypoints/openai/tool_parsers/test_llama4_pythonic_tool_parser.py
# pytest -v -s tests/entrypoints/openai/test_serving_chat.py
# pytest -v -s tests/entrypoints/openai/test_embedding_dimensions.py
# pytest -v -s tests/entrypoints/openai/test_video.py
# pytest -v -s tests/entrypoints/openai/test_openai_schema.py
# pytest -v -s tests/entrypoints/openai/test_transcription_validation.py
# pytest -v -s tests/entrypoints/openai/test_oot_registration.py
# pytest -v -s tests/entrypoints/openai/test_models.py
# pytest -v -s tests/entrypoints/openai/test_chunked_prompt.py
# pytest -v -s tests/entrypoints/openai/test_tokenization.py
# pytest -v -s tests/entrypoints/openai/test_encoder_decoder.py
# pytest -v -s tests/entrypoints/openai/test_classification.py
# pytest -v -s tests/entrypoints/openai/test_pooling.py
# pytest -v -s tests/entrypoints/openai/test_lora_adapters.py
# pytest -v -s tests/entrypoints/openai/test_rerank.py
# pytest -v -s tests/entrypoints/openai/test_return_tokens_as_ids.py
# pytest -v -s tests/entrypoints/openai/test_audio.py
# pytest -v -s tests/entrypoints/openai/test_prompt_validation.py
# pytest -v -s tests/entrypoints/openai/test_completion_with_prompt_embeds.py
# pytest -v -s tests/entrypoints/openai/test_shutdown.py
# pytest -v -s tests/entrypoints/openai/test_chat_echo.py
# pytest -v -s tests/entrypoints/openai/test_chat_with_tool_reasoning.py
# pytest -v -s tests/entrypoints/openai/test_truncation.py
# pytest -v -s tests/entrypoints/openai/test_serving_models.py
# pytest -v -s tests/entrypoints/openai/test_score.py
# pytest -v -s tests/entrypoints/openai/test_run_batch.py
# pytest -v -s tests/entrypoints/openai/test_optional_middleware.py
# pytest -v -s tests/entrypoints/openai/test_sleep.py
# pytest -v -s tests/entrypoints/openai/test_completion.py
# pytest -v -s tests/entrypoints/openai/test_cli_args.py
# pytest -v -s tests/entrypoints/openai/test_embedding.py
# pytest -v -s tests/entrypoints/openai/test_lora_resolvers.py
# pytest -v -s tests/entrypoints/openai/test_vision.py
# pytest -v -s tests/entrypoints/openai/test_root_path.py
# pytest -v -s tests/entrypoints/openai/test_basic.py
# pytest -v -s tests/entrypoints/openai/test_translation_validation.py
# pytest -v -s tests/entrypoints/openai/test_chat_template.py
time pytest -v -s tests/entrypoints/llm/test_generate.py -k "not ($expanded_skip_models or test_max_model_len[True])" # test isn't supported on g4dn instance hardware
hf cache scan
# pytest -v -s tests/entrypoints/llm/test_generate_multiple_loras.py
time pytest -v -s tests/entrypoints/llm/test_encode.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/entrypoints/llm/test_lazy_outlines.py
# pytest -v -s tests/entrypoints/llm/test_prompt_validation.py
# pytest -v -s tests/entrypoints/llm/test_guided_generate.py
time pytest -v -s tests/entrypoints/llm/test_gpu_utilization.py -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/entrypoints/llm/test_collective_rpc.py
# pytest -v -s tests/entrypoints/llm/test_accuracy.py
# pytest -v -s tests/entrypoints/llm/test_chat.py
# pytest -v -s tests/entrypoints/offline_mode/test_offline_mode.py
# pytest -v -s tests/entrypoints/test_chat_utils.py
# pytest -v -s tests/entrypoints/test_ssl_cert_refresher.py
# pytest -v -s tests/entrypoints/test_api_server_process_manager.py

# TPU tests seem to require v1 or packages that are not available
# pytest -v -s tests/tpu/test_quantization_accuracy.py
# pytest -v -s tests/tpu/test_moe_pallas.py
# pytest -v -s tests/tpu/lora/test_lora.py
# pytest -v -s tests/tpu/test_compilation.py
# pytest -v -s tests/tpu/test_custom_dispatcher.py

# skip all V1, not supported on our current build/test instances
# pytest -v -s tests/v1/engine/test_output_processor.py
# pytest -v -s tests/v1/engine/test_engine_core.py
# pytest -v -s tests/v1/engine/test_engine_args.py
# pytest -v -s tests/v1/engine/test_engine_core_client.py
# pytest -v -s tests/v1/engine/test_llm_engine.py
# pytest -v -s tests/v1/engine/test_async_llm.py
# pytest -v -s tests/v1/engine/test_fast_incdec_prefix_err.py
# pytest -v -s tests/v1/test_external_lb_dp.py
# pytest -v -s tests/v1/core/test_scheduler_e2e.py
# pytest -v -s tests/v1/core/test_specialized_manager.py
# pytest -v -s tests/v1/core/test_kv_cache_utils.py
# pytest -v -s tests/v1/core/test_scheduler.py
# pytest -v -s tests/v1/core/test_prefix_caching.py
# pytest -v -s tests/v1/metrics/test_ray_metrics.py
# pytest -v -s tests/v1/tpu/test_mha_attn.py
# pytest -v -s tests/v1/tpu/test_pallas.py
# pytest -v -s tests/v1/tpu/test_multimodal.py
# pytest -v -s tests/v1/tpu/test_sampler.py
# pytest -v -s tests/v1/tpu/test_perf.py
# pytest -v -s tests/v1/tpu/test_spmd_model_weight_loading.py
# pytest -v -s tests/v1/tpu/worker/test_tpu_model_runner.py
# pytest -v -s tests/v1/tpu/test_topk_topp_sampler.py
# pytest -v -s tests/v1/tpu/test_tpu_qkv_linear.py
# pytest -v -s tests/v1/tpu/test_kv_cache_update_kernel.py
# pytest -v -s tests/v1/tpu/test_basic.py
# pytest -v -s tests/v1/kv_connector/nixl_integration/test_accuracy.py
# pytest -v -s tests/v1/kv_connector/nixl_integration/test_edge_cases.py
# pytest -v -s tests/v1/kv_connector/unit/test_remote_prefill_lifecycle.py
# pytest -v -s tests/v1/kv_connector/unit/test_nixl_connector.py
# pytest -v -s tests/v1/kv_connector/unit/test_multi_connector.py
# pytest -v -s tests/v1/kv_connector/unit/test_remote_decode_lifecycle.py
# pytest -v -s tests/v1/sample/test_rejection_sampler.py
# pytest -v -s tests/v1/sample/test_logits_processors.py
# pytest -v -s tests/v1/sample/test_logprobs.py
# pytest -v -s tests/v1/sample/test_topk_topp_sampler.py
# pytest -v -s tests/v1/sample/test_sampler.py
# pytest -v -s tests/v1/sample/test_sampling_params_e2e.py
# pytest -v -s tests/v1/sample/test_logprobs_e2e.py
# pytest -v -s tests/v1/entrypoints/openai/test_multi_api_servers.py
# pytest -v -s tests/v1/entrypoints/openai/test_chat_completion.py
# pytest -v -s tests/v1/entrypoints/openai/test_completion.py
# pytest -v -s tests/v1/entrypoints/llm/test_struct_output_generate.py
# pytest -v -s tests/v1/e2e/test_correctness_sliding_window.py
# pytest -v -s tests/v1/e2e/test_cascade_attention.py
# pytest -v -s tests/v1/e2e/test_spec_decode.py
# pytest -v -s tests/v1/test_oracle.py
# pytest -v -s tests/v1/shutdown/test_forward_error.py
# pytest -v -s tests/v1/shutdown/test_processor_error.py
# pytest -v -s tests/v1/shutdown/test_delete.py
# pytest -v -s tests/v1/shutdown/test_startup_error.py
# pytest -v -s tests/v1/test_utils.py
# pytest -v -s tests/v1/worker/test_gpu_model_runner.py
# pytest -v -s tests/v1/worker/test_gpu_input_batch.py
# pytest -v -s tests/v1/test_metrics_reader.py
# pytest -v -s tests/v1/test_serial_utils.py
# pytest -v -s tests/v1/structured_output/test_utils.py
# pytest -v -s tests/v1/spec_decode/test_ngram.py
# pytest -v -s tests/v1/spec_decode/test_eagle.py
# pytest -v -s tests/v1/spec_decode/test_max_len.py
# pytest -v -s tests/v1/test_async_llm_dp.py
# pytest -v -s tests/v1/test_request.py

pytest -v -s tests/detokenizer/ -k "not ($expanded_skip_models)" --ignore tests/detokenizer/test_stop_reason.py --ignore tests/detokenizer/test_stop_strings.py
hf cache scan
# pytest -v -s tests/detokenizer/test_disable_detokenization.py
# pytest -v -s tests/detokenizer/test_stop_reason.py
# pytest -v -s tests/detokenizer/test_stop_strings.py
# pytest -v -s tests/detokenizer/test_stop_checker.py


# pytest -v -s tests/mistral_tool_use/test_mistral_tool_calls.py  # OOM running this

# compile tests have too many failures caused by unsupported GPU version
# pytest -v -s tests/compile/test_sequence_parallelism.py
# pytest -v -s tests/compile/test_functionalization.py
# pytest -v -s tests/compile/piecewise/test_simple.py
# pytest -v -s tests/compile/piecewise/test_toy_llama.py
# pytest -v -s tests/compile/piecewise/test_full_cudagraph.py
# pytest -v -s tests/compile/test_silu_mul_quant_fusion.py
# pytest -v -s tests/compile/test_fusion_attn.py
# pytest -v -s tests/compile/test_pass_manager.py
# pytest -v -s tests/compile/test_wrapper.py
# pytest -v -s tests/compile/test_fusion.py
# pytest -v -s tests/compile/test_basic_correctness.py
# pytest -v -s tests/compile/test_config.py
# pytest -v -s tests/compile/test_full_graph.py
# pytest -v -s tests/compile/test_async_tp.py

# pytest -v -s tests/tool_use/test_chat_completion_request_validations.py
# pytest -v -s tests/tool_use/test_xlam_tool_parser.py
# pytest -v -s tests/tool_use/test_jamba_tool_parser.py
# pytest -v -s tests/tool_use/test_minimax_tool_parser.py
# pytest -v -s tests/tool_use/test_parallel_tool_calls.py
# pytest -v -s tests/tool_use/test_tool_choice_required.py
# pytest -v -s tests/tool_use/test_tool_calls.py
# pytest -v -s tests/tool_use/test_chat_completions.py
# pytest -v -s tests/neuron/2_core/test_comm_ops.py
# pytest -v -s tests/neuron/2_core/test_eagle.py
# pytest -v -s tests/neuron/2_core/test_mistral.py
# pytest -v -s tests/neuron/2_core/test_multi_lora.py
# pytest -v -s tests/neuron/1_core/test_logits_processor.py
# pytest -v -s tests/neuron/1_core/test_cache.py
# pytest -v -s tests/neuron/1_core/test_layernorm.py
# pytest -v -s tests/neuron/1_core/test_activation.py
# pytest -v -s tests/neuron/1_core/test_neuron_quant.py
# pytest -v -s tests/neuron/1_core/test_prefix_prefill.py
# pytest -v -s tests/neuron/1_core/test_rotary_embedding.py
# pytest -v -s tests/neuron/1_core/test_neuron_model_runner.py
# pytest -v -s tests/neuron/1_core/test_block_table.py

# tests/kernels has about 44k tests under it
# flash_attention doesn't work on g4dn instances (GPU is too old)
# pytest -v -s tests/kernels/attention/test_lightning_attn.py
time pytest -v -s tests/kernels/attention/test_cache.py -k "(test_copy_blocks or test_reshape_and_cache) and not (test_fp8_e4m3_conversion[cuda:0-0-dtype1 or test_reshape_and_cache_flash[HND-fp8-cuda:0-0-dtype1 or test_reshape_and_cache[fp8-cuda:0-0-dtype1 or test_swap_blocks[auto-cuda:0-0-dtype2-10000-32-256-8-256- or test_copy_blocks[auto-cuda:0-0-dtype2-10000-32-256-8-1-256] or test_reshape_and_cache[auto-cuda:0-0-dtype2-10000-32-256-8-42] or test_fp8_e4m3_conversion[cuda:0-0-dtype2-10000-32-256-8] or test_reshape_and_cache_flash[NHD-fp8-cuda:0-0-dtype1)"
hf cache scan
# pytest -v -s tests/kernels/attention/test_blocksparse_attention.py
# pytest -v -s tests/kernels/attention/test_rocm_attention_selector.py
# pytest -v -s tests/kernels/attention/test_flashmla.py
# pytest -v -s tests/kernels/attention/test_attention.py
# pytest -v -s tests/kernels/attention/test_prefix_prefill.py
# pytest -v -s tests/kernels/attention/test_merge_attn_states.py
# pytest -v -s tests/kernels/attention/test_mla_decode_cpu.py
# pytest -v -s tests/kernels/attention/test_triton_unified_attention.py
# pytest -v -s tests/kernels/attention/test_triton_decode_attention.py
# pytest -v -s tests/kernels/attention/test_cascade_flash_attn.py
# pytest -v -s tests/kernels/attention/test_flash_attn.py
# pytest -v -s tests/kernels/attention/test_flashinfer.py
# pytest -v -s tests/kernels/attention/test_mha_attn.py
# pytest -v -s tests/kernels/attention/test_encoder_decoder_attn.py
# pytest -v -s tests/kernels/attention/test_attention_selector.py

time pytest -v -s tests/kernels/quantization/test_fp8_quant.py tests/kernels/quantization/test_awq_triton.py -k "not ($expanded_skip_models or test_scaled_mm or test_w8a8_fp8_fused_moe or test_w8a8_block_int8_matmul or test_fp8_quant_large or test_moe)" --ignore tests/kernels/quantization/test_marlin_gemm.py
hf cache scan
# pytest -v -s tests/kernels/quantization/test_machete_mm.py
# pytest -v -s tests/kernels/quantization/test_cutlass_2of4_sparse.py
# pytest -v -s tests/kernels/quantization/test_block_int8.py
# pytest -v -s tests/kernels/quantization/test_cutlass_scaled_mm.py
# pytest -v -s tests/kernels/quantization/test_int8_kernel.py
# pytest -v -s tests/kernels/quantization/test_allspark_gemm.py
# pytest -v -s tests/kernels/quantization/test_nvfp4_scaled_mm.py
# pytest -v -s tests/kernels/quantization/test_nvfp4_quant.py
# pytest -v -s tests/kernels/quantization/test_awq.py
# pytest -v -s tests/kernels/quantization/test_fp8_quant.py
# pytest -v -s tests/kernels/quantization/test_aqlm.py
# pytest -v -s tests/kernels/quantization/test_int8_quant.py
# pytest -v -s tests/kernels/quantization/test_block_fp8.py
# pytest -v -s tests/kernels/quantization/test_marlin_gemm.py
# pytest -v -s tests/kernels/quantization/test_gptq.py
# pytest -v -s tests/kernels/quantization/test_gguf.py
# pytest -v -s tests/kernels/quantization/test_rocm_skinny_gemms.py
# pytest -v -s tests/kernels/quantization/test_ggml.py
# pytest -v -s tests/kernels/quantization/test_awq_triton.py
# pytest -v -s tests/kernels/quantization/test_triton_scaled_mm.py


# pytest -v -s tests/kernels/moe/test_block_int8.py
# pytest -v -s tests/kernels/moe/test_deepep_deepgemm_moe.py
# pytest -v -s tests/kernels/moe/test_deepep_moe.py
# pytest -v -s tests/kernels/moe/test_cutlass_grouped_gemm.py
# pytest -v -s tests/kernels/moe/test_moe.py
# pytest -v -s tests/kernels/moe/test_moe_permute_unpermute.py
# pytest -v -s tests/kernels/moe/test_block_fp8.py
# pytest -v -s tests/kernels/moe/test_moe_align_block_size.py
# pytest -v -s tests/kernels/moe/test_rocm_aiter_topk.py
# pytest -v -s tests/kernels/moe/test_pplx_cutlass_moe.py
# pytest -v -s tests/kernels/moe/test_deepgemm.py
# pytest -v -s tests/kernels/moe/test_silu_mul_fp8_quant_deep_gemm.py
# pytest -v -s tests/kernels/moe/test_batched_moe.py
# pytest -v -s tests/kernels/moe/test_cutlass_moe.py
# pytest -v -s tests/kernels/moe/test_triton_moe_ptpc_fp8.py
# pytest -v -s tests/kernels/moe/test_nvfp4_moe.py
# pytest -v -s tests/kernels/moe/test_pplx_moe.py

#time pytest -v -c tests/kernels/core/ -k "not ($expanded_skip_models)" --ignore tests/kernels/core/test_layernorm.py
hf cache scan
# pytest -v -s tests/kernels/core/test_pos_encoding.py
# pytest -v -s tests/kernels/core/test_permute_cols.py
# pytest -v -s tests/kernels/core/test_rotary_embedding.py
# pytest -v -s tests/kernels/core/test_uva.py
# pytest -v -s tests/kernels/core/test_activation.py
# pytest -v -s tests/kernels/core/test_layernorm.py
# pytest -v -s tests/kernels/core/test_fused_quant_layernorm.py
# pytest -v -s tests/kernels/core/test_opcheck.py
# pytest -v -s tests/kernels/test_triton_flash_attention.py
# pytest -v -s tests/kernels/test_cutlass_mla_decode.py
# pytest -v -s tests/kernels/mamba/test_mamba_mixer2.py
# pytest -v -s tests/kernels/mamba/test_causal_conv1d.py
# pytest -v -s tests/kernels/mamba/test_mamba_ssm_ssd.py
# pytest -v -s tests/kernels/mamba/test_mamba_ssm.py
# pytest -v -s tests/kernels/test_flex_attention.py
# pytest -v -s tests/kernels/test_apply_repetition_penalties.py
# pytest -v -s tests/kernels/test_fused_quant_activation.py
# pytest -v -s tests/model_executor/test_logits_processor.py
# pytest -v -s tests/model_executor/test_model_load_with_params.py
# pytest -v -s tests/model_executor/test_enabled_custom_ops.py
# pytest -v -s tests/model_executor/test_guided_processors.py
# pytest -v -s tests/model_executor/test_weight_utils.py


# pytest -v -s tests/engine/test_short_mm_context.py
# pytest -v -s tests/engine/test_arg_utils.py
# pytest -v -s tests/engine/test_multi_step_output_processor.py
# pytest -v -s tests/engine/test_executor.py
# pytest -v -s tests/engine/test_options.py
# pytest -v -s tests/engine/test_multiproc_workers.py
# pytest -v -s tests/engine/test_computed_prefix_blocks.py

# basic correctness tests fail due to gated repo use and a GPU that is too old
# pytest -v -s tests/basic_correctness/test_basic_correctness.py
# pytest -v -s tests/basic_correctness/test_cumem.py
# pytest -v -s tests/basic_correctness/test_preemption.py
# pytest -v -s tests/basic_correctness/test_cpu_offload.py
# pytest -v -s tests/basic_correctness/test_chunked_prefill.py

# pytest -v -s tests/tracing/test_tracing.py
# pytest -v -s tests/kv_transfer/test_module.py
# pytest -v -s tests/kv_transfer/test_lookup_buffer.py
# pytest -v -s tests/kv_transfer/test_disagg.py
# pytest -v -s tests/kv_transfer/test_send_recv.py
# pytest -v -s tests/test_cache_block_hashing.py
# pytest -v -s tests/config/test_config_generation.py
# pytest -v -s tests/config/test_mp_reducer.py
# pytest -v -s tests/quantization/test_bitsandbytes.py
# pytest -v -s tests/quantization/test_gptq_dynamic.py
# pytest -v -s tests/quantization/test_lm_head.py
# pytest -v -s tests/quantization/test_quark.py
# pytest -v -s tests/quantization/test_compressed_tensors.py
# pytest -v -s tests/quantization/test_register_quantization_config.py
# pytest -v -s tests/quantization/test_experts_int8.py
# pytest -v -s tests/quantization/test_configs.py
# pytest -v -s tests/quantization/test_torchao.py
# pytest -v -s tests/quantization/test_auto_round.py
# pytest -v -s tests/quantization/test_rtn.py
# pytest -v -s tests/quantization/test_fp8.py
# pytest -v -s tests/quantization/test_cpu_offload.py
# pytest -v -s tests/quantization/test_ipex_quant.py
# pytest -v -s tests/quantization/test_ptpc_fp8.py
# pytest -v -s tests/test_inputs.py
# pytest -v -s tests/test_config.py

time pytest -v -s tests/reasoning/ -k "not ($expanded_skip_models)"
hf cache scan
# pytest -v -s tests/reasoning/test_deepseekr1_reasoning_parser.py
# pytest -v -s tests/reasoning/test_granite_reasoning_parser.py
# pytest -v -s tests/reasoning/test_qwen3_reasoning_parser.py


# pytest -v -s tests/test_utils.py

#pytest -v -s tests/tokenization/ -k "not ($expanded_skip_models or mosaicml/mpt-7b or test_get_llama3_eos_token)"
# pytest -v -s tests/tokenization/test_detokenize.py
# pytest -v -s tests/tokenization/test_cached_tokenizer.py
# pytest -v -s tests/tokenization/test_tokenizer_group.py
# pytest -v -s tests/tokenization/test_tokenizer_registry.py
# pytest -v -s tests/tokenization/test_mistral_tokenizer.py
# pytest -v -s tests/tokenization/test_get_eos.py
time pytest -v -s tests/tokenization/test_tokenizer.py -k "not ($expanded_skip_models)"
# pytest -v -s tests/benchmarks/test_throughput_cli.py
# pytest -v -s tests/benchmarks/test_latency_cli.py
# pytest -v -s tests/benchmarks/test_serve_cli.py
# pytest -v -s tests/fastsafetensors_loader/test_fastsafetensors_loader.py
# pytest -v -s tests/fastsafetensors_loader/test_weight_utils.py
# pytest -v -s tests/vllm_test_utils/vllm_test_utils/__init__.py
# pytest -v -s tests/vllm_test_utils/vllm_test_utils/blame.py
# pytest -v -s tests/vllm_test_utils/vllm_test_utils/monitor.py
# pytest -v -s tests/vllm_test_utils/setup.py
# pytest -v -s tests/encoder_decoder/test_e2e_correctness.py
# pytest -v -s tests/test_sharded_state_loader.py
# pytest -v -s tests/async_engine/test_async_llm_engine.py
# pytest -v -s tests/async_engine/test_request_tracker.py
# pytest -v -s tests/async_engine/test_api_server.py
# pytest -v -s tests/prefix_caching/test_disable_sliding_window.py
# pytest -v -s tests/prefix_caching/test_prefix_caching.py
# pytest -v -s tests/test_sequence.py
# pytest -v -s tests/runai_model_streamer_test/test_runai_model_streamer_loader.py
# pytest -v -s tests/runai_model_streamer_test/test_weight_utils.py
# pytest -v -s tests/plugins_tests/test_platform_plugins.py
# pytest -v -s tests/plugins_tests/test_scheduler_plugins.py
# pytest -v -s tests/prompt_adapter/test_multi_adapter_inference.py
# pytest -v -s tests/prompt_adapter/test_pa_lora.py
# pytest -v -s tests/prompt_adapter/test_bloom.py
# pytest -v -s tests/test_scalartype.py
# pytest -v -s tests/tensorizer_loader/test_tensorizer.py
# pytest -v -s tests/test_seed_behavior.py
# pytest -v -s tests/cuda/test_cuda_context.py
# pytest -v -s tests/metrics/test_metrics.py
# pytest -v -s tests/test_vllm_port.py
# pytest -v -s tests/test_triton_utils.py
# pytest -v -s tests/test_outputs.py
# pytest -v -s tests/test_logger.py
# pytest -v -s tests/tools/test_config_validator.py
# pytest -v -s tests/test_regression.py
# pytest -v -s tests/test_embedded_commit.py
# pytest -v -s tests/test_sampling_params.py
# pytest -v -s tests/test_version.py

# Show which repos were downloaded during testing and how much space they take up
hf cache scan