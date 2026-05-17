---
id: testing
title: Testing
sidebar_position: 5
---

# Testing

The test suite uses plain Lua and lives in `tests/`.

```bash
lua tests/run.lua
```

The suite covers:

- Class creation and initialization.
- Accessors and private state.
- Single and multiple inheritance.
- Includes and cloning.
- Registered classes.
- Operator behavior.
- Debug output.

GitHub Actions runs the tests on Lua 5.1, 5.2, 5.3, and 5.4.
