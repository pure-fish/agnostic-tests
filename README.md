# agnostic-tests

> One black-box test suite for every [Pure](https://github.com/pure-fish/pure) prompt implementation.

The suite runs each implementation's prompt and checks its plain-text output.
[pure-fish](https://github.com/pure-fish/pure) is the reference: when implementations disagree, Fish is right.

| Implementation | Repository | Adapter |
| :------------- | :--------- | :------ |
| Fish (reference) | [pure-fish/pure](https://github.com/pure-fish/pure) | `adapters/fish/` |
| Python | [edouard-lopez/pure.py](https://github.com/edouard-lopez/pure.py) | `adapters/python/` |
| Go | [edouard-lopez/pure.go](https://github.com/edouard-lopez/pure.go) | `adapters/go/` |

## Usage

```sh
make checkout                     # clone the three implementations into .implementations/
make test IMPLEMENTATION=fish     # run the suite on one implementation
make test-all                     # run the suite on every implementation
make docker-test IMPLEMENTATION=go
```

Requirements outside Docker: `bats` 1.10+, `bats-support`, `bats-assert`, `fish`, `git`, `go`,
and `python3` 3.10+ with `pip install colorful gitpython platformdirs`.
Point `BATS_LIB_PATH` at the folder holding `bats-support` and `bats-assert`.

## Use in an implementation's CI

Call the reusable workflow from the implementation's repository.
It tests the caller's commit, so pull requests get feedback before merge.

```yaml
jobs:
  agnostic-tests:
    uses: pure-fish/agnostic-tests/.github/workflows/test-implementation.yml@main
    with:
      implementation: go # fish, python or go
```

Pass `agnostic-tests-ref` to pin the suite to a tag or SHA.

## How it works

Tests never call an implementation directly.
They call `adapters/$IMPLEMENTATION/prompt`, which accepts the shared contract:

1. `--last-command-status N` and `--command-duration MS`.
2. Every `PURE_*` env var as configuration, e.g. `PURE_SYMBOL_GIT_DIRTY='!'`.
3. The current directory as the prompt's working directory.
4. Prints the full prompt on stdout and exits 0.
5. Optionally `--json`, one object per segment.

`PURE_*` names are Fish's `pure_*` variables in upper case.

## Feature tags

Each test carries tags with `# bats test_tags=git_dirty`.
`adapters/<implementation>/support` lists the tags an implementation claims.
A test is skipped when one of its tags is missing, and fails when the claimed feature differs from Fish.

## Adding a test

1. Pick a Fish test in `pure-fish/pure/tests/`.
2. Rewrite it in `specs/<feature>.bats` with a feature tag. Check output, never internal functions.
3. Run it on Fish first: it must pass there.
4. Add the tag to the `support` file of each implementation that passes it.
