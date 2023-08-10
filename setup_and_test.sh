#!/bin/bash

# Installs LLaMa-2 GGML

# install libcublas dev first
conda install -c "nvidia/label/cuda-11.4.0" libcublas-dev -y

git clone https://github.com/mtournier-apixio/apxllama.cpp.git

# https://github.com/ggerganov/llama.cpp.git

cd apxllama.cpp

# with CPU machine:
# make 

# with GPU machine:
make LLAMA_CUBLAS=1

USER_PROMPT="Write a short story about llamas"

MODEL_PATH="/home/jovyan/shared/ggml/llama-2-70b-chat.ggmlv3.q4_0.bin"

PROMPT="[INST] <<SYS>>You are a helpful assistant<</SYS>>${USER_PROMPT}[/INST]"

# remove --n-gpu-layers if not using GPU # remove -t 30 to run in GPU

./main \
    --color \
    -m $MODEL_PATH \
    -gqa 8 \
    -p "${PROMPT}" \
    --n-gpu-layers 83
