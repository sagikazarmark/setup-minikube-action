#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")

main() {
    args=()

    if [[ -n "${INPUT_VERSION:-}" ]]; then
        args+=(--version "${INPUT_VERSION}")
    fi

    "$SCRIPT_DIR/minikube.sh" "${args[@]}"
}

main
