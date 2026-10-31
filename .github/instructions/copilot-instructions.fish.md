# GitHub Copilot Code Review Instructions

## Review Philosophy
- Only comment when you have HIGH CONFIDENCE (>80%) that an issue exists
- Be concise: one sentence per comment when possible
---
description: "Pure Fish project guidance for implementation and code review"
applyTo: "**/*.fish"
---

# Pure Coding and Review Instructions

Pure is a Fish shell prompt. Review and implementation advice must match Fish semantics and the repository's conventions in [AGENTS.md](../../AGENTS.md), [CONTRIBUTING.md](../../CONTRIBUTING.md), and [fish.instructions.md](fish.instructions.md).

## Testing expectations

Use the Docker-backed Make targets from the [makefile](../../makefile), for example:

```fish
set --local fish_version (fish --version | string match --regex '(?:\\d+.?){3}')
make test-pure-on FISH_VERSION=$fish_version CMD="fishtape tests/path.test.fish"
```

When reviewing a test, look for isolated configuration state and use of the existing fixtures and mocks in `tests/`. Do not assume a bare local `fishtape` run represents the supported test environment.
