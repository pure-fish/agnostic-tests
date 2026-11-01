#!/usr/bin/env bats
# Ported from pure-fish tests/_pure_prompt_new_line.test.fish
# and tests/_pure_prompt_current_folder.test.fish

setup() {
    load '../helpers/setup'
    pure_isolate
}

# bats test_tags=new_line
@test "layout: prompt starts with a blank line" {
    run --keep-empty-lines pure_prompt
    assert_success
    assert_equal "${lines[0]}" ''
}

# bats test_tags=current_folder
@test "layout: shows the current folder" {
    run pure_prompt
    assert_success
    assert_output --partial 'work'
}
