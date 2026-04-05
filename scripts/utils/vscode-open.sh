#!/usr/bin/env bash
if [ -d .devcontainer ]; then
    devcontainer up --workspace-folder .
    hex_path=$(printf '%s' "$(pwd)" | od -A n -t x1 | tr -d ' \n')
    code --folder-uri "vscode-remote://dev-container+${hex_path}$(pwd)"
else
    code .
fi
