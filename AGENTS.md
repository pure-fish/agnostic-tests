# AGENTS.md

Work in English. Keep changes small and avoid external dependencies where possible.

## Project map

- `makefile`: authoritative build, test, documentation commands.

## Build and test

Use Docker-backed Make targets so tests run against the requested Fish version:

If tooling is not installed on the host, stop and ask the user which version to use, then pass it as `FISH_VERSION` to the `make` command.

Useful targets include `build-*`, `test-*`. See the [makefile](makefile) for target details and the [contributing guide](CONTRIBUTING.md) for the full workflow.

## Implementation conventions

- Prefer the existing helpers, fixtures, mocks, and color/configuration conventions over new abstractions; for non-runtime tooling (for example under `tools/`, docs, or tests), external utilities may be used when justified.

Follow the [code conventions](CONTRIBUTING.md#code-conventions) and Fish-specific [shell instructions](.github/instructions/fish.instructions.md).

## Feature changes

Work using a TDD approach. Keep command output concise, write tests for bug fixes, and do not commit generated artifacts except screenshots produced by `tools/screenshot.fish` for feature changes that alter visible prompt states.
