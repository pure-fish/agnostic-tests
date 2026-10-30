#!/usr/bin/env bats
# Ported from pure-fish tests/_pure_prompt_symbol.test.fish

setup() {
    load '../helpers/setup'
    pure_isolate
}

# bats test_tags=prompt_symbol
@test "prompt symbol: default symbol ends the prompt" {
    run pure_prompt --last-command-status 0
    assert_success
    assert_regex "${lines[-1]}" '❯ ?$'
}

# bats test_tags=prompt_symbol
@test "prompt symbol: same symbol after a failed command" {
    run pure_prompt --last-command-status 1
    assert_success
    assert_regex "${lines[-1]}" '❯ ?$'
}

# bats test_tags=prompt_symbol,config
@test "prompt symbol: PURE_SYMBOL_PROMPT changes the symbol" {
    export PURE_SYMBOL_PROMPT='>'
    run pure_prompt --last-command-status 0
    assert_success
    assert_regex "${lines[-1]}" '> ?$'
}

# bats test_tags=prompt_symbol,colors
@test "prompt symbol: magenta after a successful command" {
    run pure_prompt_colors --last-command-status 0
    assert_success
    assert_regex "${lines[-1]}" '\{magenta\}❯'
}

# bats test_tags=prompt_symbol,colors
@test "prompt symbol: red after a failed command" {
    run pure_prompt_colors --last-command-status 1
    assert_success
    assert_regex "${lines[-1]}" '\{red\}❯'
}
