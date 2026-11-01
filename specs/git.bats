#!/usr/bin/env bats
# Ported from pure-fish tests/_pure_prompt_git_branch.test.fish
# and tests/_pure_prompt_git_dirty.test.fish

setup() {
    load '../helpers/setup'
    pure_isolate
    pure_git_repo
}

# bats test_tags=git_branch
@test "git branch: shows the current branch" {
    git commit --quiet --allow-empty --message 'init'
    run pure_prompt
    assert_success
    assert_output --partial 'main'
}

# bats test_tags=git_branch
@test "git branch: shows a new branch name" {
    git commit --quiet --allow-empty --message 'init'
    git checkout --quiet -b feature/agnostic
    run pure_prompt
    assert_success
    assert_output --partial 'feature/agnostic'
}

# bats test_tags=git_branch
@test "git branch: no branch outside a repo" {
    mkdir -p "$BATS_TEST_TMPDIR/plain" && cd "$BATS_TEST_TMPDIR/plain"
    run pure_prompt
    assert_success
    refute_output --partial 'main'
}

# bats test_tags=git_dirty
@test "git dirty: clean repo is not dirty" {
    echo "clean" > file.txt
    git add file.txt
    git commit --quiet --message 'clean'
    run pure_prompt
    assert_success
    refute_output --partial 'main*'
}

# bats test_tags=git_dirty
@test "git dirty: untracked file marks repo dirty" {
    git commit --quiet --allow-empty --message 'init'
    touch file.txt
    run pure_prompt
    assert_success
    assert_output --partial 'main*'
}

# bats test_tags=git_dirty
@test "git dirty: staged file marks repo dirty" {
    git commit --quiet --allow-empty --message 'init'
    echo "staged" > file.txt
    git add file.txt
    run pure_prompt
    assert_success
    assert_output --partial 'main*'
}

# bats test_tags=git_dirty,config
@test "git dirty: PURE_SYMBOL_GIT_DIRTY changes the symbol" {
    git commit --quiet --allow-empty --message 'init'
    touch file.txt
    export PURE_SYMBOL_GIT_DIRTY='!'
    run pure_prompt
    assert_success
    assert_output --partial 'main!'
}
