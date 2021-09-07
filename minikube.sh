#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

DEFAULT_MINIKUBE_VERSION=latest

show_help() {
cat << EOF
Usage: $(basename "$0") <options>

    -h, --help                              Display help
    -v, --version                           The minikube version to use (default: $DEFAULT_MINIKUBE_VERSION)"

EOF
}

main() {
    local version="$DEFAULT_MINIKUBE_VERSION"

    parse_command_line "$@"

    if [[ ! -d "$RUNNER_TOOL_CACHE" ]]; then
        echo "Cache directory '$RUNNER_TOOL_CACHE' does not exist" >&2
        exit 1
    fi

    local os
    os="$(uname | tr A-Z a-z)"

    local arch
    arch=$(uname -m)
    local cache_dir="$RUNNER_TOOL_CACHE/minikube/$version/$arch"

    local minikube_dir="$cache_dir/minikube/bin"
    if [[ ! -x "$minikube_dir/minikube" ]]; then
        install_minikube
    fi

    echo 'Adding minikube directory to PATH...'
    echo "$minikube_dir" >> "$GITHUB_PATH"

    "$minikube_dir/minikube" version
}

parse_command_line() {
    while :; do
        case "${1:-}" in
            -h|--help)
                show_help
                exit
                ;;
            -v|--version)
                if [[ -n "${2:-}" ]]; then
                    version="$2"
                    shift
                else
                    echo "ERROR: '-v|--version' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            *)
                break
                ;;
        esac

        shift
    done
}

install_minikube() {
    echo 'Installing minikube...'

    mkdir -p "$minikube_dir"

    if [[ "$version" == "latest" ]]; then
        curl -sSLo "$minikube_dir/minikube" "https://github.com/kubernetes/minikube/releases/latest/download/minikube-$os-amd64"
    else
        curl -sSLo "$minikube_dir/minikube" "https://github.com/kubernetes/minikube/releases/download/$version/minikube-$os-amd64"
    fi

    chmod +x "$minikube_dir/minikube"
}

main "$@"
