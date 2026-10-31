# GitHub Copilot Code Review Instructions

## Review Philosophy
- Only comment when you have HIGH CONFIDENCE (>80%) that an issue exists
- Be concise: one sentence per comment when possible
---
description: "General project guidance for implementation and code review"
applyTo: "**/*"
---

## Review priorities

- Report only high-confidence, actionable problems; lead with correctness, regressions, security, and user-visible prompt behavior.
- Check Fish quoting and expansion, exit-status handling, command substitution, cleanup, path handling, and behavior across supported Fish versions.
- Check that changes preserve public/private naming, configuration defaults, prompt rendering, and existing feature flags.
- For new behavior, check for focused Fishtape coverage and documentation updates when the user-facing prompt changes.
- Do not report stylistic preferences already covered by the linked conventions unless they cause a concrete defect.


## Review format

State the problem briefly, explain the impact when it is not obvious, and give a specific fix. If confidence is low, stay silent rather than filing a speculative comment.