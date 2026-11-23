# ProjectName

## Documentation

Anvil is the canonical reference for all conventions, patterns, and architectural decisions:
https://github.com/st0o0/anvil

Before making architectural choices, check the relevant Anvil docs section. When in doubt, Anvil wins.

## Quality gates

### Slopwatch (LLM anti-cheat)

Every code change is validated by Slopwatch via Claude Code hook (`.claude/settings.json`).
Strict mode is active — all rules are errors, not warnings.

- Never disable tests (`Skip=`, `Ignore`, `#if false`)
- Never suppress warnings (`#pragma warning disable`, `SuppressMessage`, `<NoWarn>`)
- Never add empty catch blocks
- Never add `Task.Delay` / `Thread.Sleep` in tests
- Never bypass CPM with inline `Version` attributes

If Slopwatch flags something, fix the underlying issue. Do not update the baseline unless there is a documented, justified reason.

### Architecture tests

ArchUnitNET enforces project reference direction and domain isolation. See `ProjectName.Architecture.Tests`.

## Project conventions

- Central Package Management — versions in `Directory.Packages.props`, never inline
- `TreatWarningsAsErrors` is on — fix warnings, don't suppress them
- `.editorconfig` defines style — never modify it to silence warnings
- Conventional Commits enforced by commitlint
- Single-line commit messages, no body
