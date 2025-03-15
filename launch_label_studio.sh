#!/bin/zsh

dataset_path=$1

export LABEL_STUDIO_LOCAL_FILES_SERVING_ENABLED=true
export LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT=$dataset_path

uv run label-studio
