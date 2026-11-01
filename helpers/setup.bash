# Shared helpers for every spec. Load with: load '../helpers/setup'

bats_require_minimum_version 1.10.0 # BATS_TEST_TAGS

AGNOSTIC_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMPLEMENTATION=${IMPLEMENTATION:?set IMPLEMENTATION to fish, python or go}
ADAPTER="$AGNOSTIC_ROOT/adapters/$IMPLEMENTATION"
if [[ ! -x "$ADAPTER/prompt" || ! -f "$ADAPTER/support" ]]; then
    echo "unknown IMPLEMENTATION '$IMPLEMENTATION': expected adapters/$IMPLEMENTATION/{prompt,support}" >&2
    exit 1
fi

load "$AGNOSTIC_ROOT/helpers/normalize"
bats_load_library bats-support
bats_load_library bats-assert

# Skip the test when the implementation does not list one of its tags.
pure_skip_unsupported() {
    local tag
    for tag in "${BATS_TEST_TAGS[@]}"; do
        if ! grep --quiet --line-regexp --fixed-strings "$tag" "$ADAPTER/support"; then
            skip "$IMPLEMENTATION does not support '$tag'"
        fi
    done
}

# Give the test a clean, predictable environment.
pure_isolate() {
    pure_skip_unsupported

    export HOME="$BATS_TEST_TMPDIR/home"
    export XDG_CONFIG_HOME="$HOME/.config"
    export TERM=xterm-256color
    export LANG=C.UTF-8
    export COLUMNS=80
    unset SSH_CONNECTION SSH_CLIENT SSH_TTY VIRTUAL_ENV
    while read -r name; do unset "$name"; done < <(compgen -e | grep '^PURE_' || true)

    mkdir -p "$HOME"
    export GIT_CONFIG_GLOBAL="$HOME/.gitconfig"
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    git config --global init.defaultBranch main

    mkdir -p "$BATS_TEST_TMPDIR/work"
    cd "$BATS_TEST_TMPDIR/work"
}

# Turn the current directory into an empty git repo on branch main.
pure_git_repo() {
    git init --quiet --initial-branch=main
}

# Print the prompt without colours.
pure_prompt() {
    local -
    set -o pipefail
    "$ADAPTER/prompt" "$@" | strip_ansi
}

# Print the prompt with colours as readable tokens, like {red}.
pure_prompt_colors() {
    local -
    set -o pipefail
    "$ADAPTER/prompt" "$@" | tokenize_ansi
}
