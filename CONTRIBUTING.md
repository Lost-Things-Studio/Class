# Contributing to Class

Thank you for taking the time to improve Class. This project aims to stay small,
readable, dependency-light, and easy to embed in any Lua codebase.

## Code of Conduct

By participating in this project, you agree to follow the community rules in
[CODE_OF_PRODUCT.md](CODE_OF_PRODUCT.md). Be respectful, assume good intent,
and keep technical discussions focused on the work.

## What to Contribute

Contributions are welcome when they make the library easier to use, safer to
maintain, or better documented. Good contribution areas include:

- Bug fixes in `class.lua`.
- Unit tests for existing or new behavior.
- Documentation improvements in `README.md` or `docs/`.
- Compatibility fixes for supported Lua versions.
- Small, well-scoped feature proposals.

Before starting a large feature, open an issue first so the direction can be
discussed before you spend time on implementation.

## Local Setup

1. Fork and clone the repository.

   ```bash
   git clone https://github.com/<your-username>/Class.git
   cd Class
   ```

2. Make sure Lua is installed.

   ```bash
   lua -v
   luac -v
   ```

3. Run the test suite.

   ```bash
   lua tests/run.lua
   ```

4. Check syntax before opening a pull request.

   ```bash
   luac -p class.lua tests/*.lua
   ```

The GitHub workflow currently checks the project with Lua 5.1, 5.2, 5.3, and
5.4. Please keep compatibility with those versions unless a change explicitly
updates the supported version policy.

## Development Workflow

1. Create a focused branch.

   ```bash
   git checkout -b fix/short-description
   ```

2. Keep each pull request focused on one purpose.

3. Add or update tests for behavior changes.

4. Update documentation when public behavior changes.

5. Run the local checks before pushing.

   ```bash
   luac -p class.lua tests/*.lua
   lua tests/run.lua
   ```

## Lua Style Guide

Class is intentionally compact, but the code should still be easy for future
contributors to read.

- Prefer clear indentation and readable blocks over dense one-line functions.
- Keep public behavior in `class.lua` documented through tests.
- Avoid adding runtime dependencies.
- Keep Lua 5.1 compatibility in mind.
- Prefer descriptive local names when adding new logic.
- Avoid unrelated refactors in bug-fix pull requests.
- Add comments only when they explain non-obvious behavior.

## Tests

Tests live in the `tests/` directory and are run with:

```bash
lua tests/run.lua
```

When adding tests:

- Add cases to `tests/class_test.lua` for library behavior.
- Add helpers to `tests/test_helper.lua` only when they are generally useful.
- Keep each test name specific and behavior-oriented.
- Test both successful behavior and important failure paths.

## Reporting Bugs

Use the bug report issue template and include:

- A clear description of the problem.
- Minimal Lua code that reproduces the issue.
- The Lua version you used.
- The expected behavior.
- The actual behavior, including error messages.

Small, reproducible examples are the fastest path to a fix.

## Requesting Features

Use the feature request issue template and include:

- The problem the feature solves.
- A short example of the desired API or behavior.
- Any compatibility concerns.
- Whether the feature can be implemented outside the core library.

Because Class is designed to remain lightweight, features should justify their
complexity and fit the existing API style.

## Pull Request Guidelines

Before submitting a pull request:

- Rebase or merge the latest main branch if needed.
- Run syntax checks and tests locally.
- Fill in the pull request template.
- Link related issues when applicable.
- Include documentation updates for user-facing changes.
- Disclose AI-assisted contributions in the PR template when applicable.

Maintainers may ask for changes to keep the project consistent, small, and easy
to maintain. Review comments are part of the collaboration, not a judgment of
the contributor.

## AI-Assisted Contributions

AI tools are allowed, but contributors remain responsible for the result.

- Review all generated code before submitting it.
- Make sure generated code matches the project style.
- Do not submit code you do not understand.
- Mention AI usage in the pull request template.

## License

By contributing, you agree that your contributions will be licensed under the
same MIT License used by this project.
