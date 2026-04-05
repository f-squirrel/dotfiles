#!/usr/bin/env bash
if [ -d .devcontainer ]; then
    result=$(devcontainer up --workspace-folder .)
    remote_workspace=$(echo "$result" | jq -r '.remoteWorkspaceFolder // empty')
    if [ -z "$remote_workspace" ]; then
        remote_workspace=$(pwd)
    fi
    hex_path=$(printf '%s' "$(pwd)" | od -A n -t x1 | tr -d ' \n')
    code --folder-uri "vscode-remote://dev-container+${hex_path}${remote_workspace}"
else
    code .
fi
