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
- Single, multiple, and transitive inheritance.
- Includes and cloning.
- Registered classes.
- Type identity with `Class:is` and `instance:Is`.
- Type assertions with `Class:assertIs` and `instance:AssertIs`.
- Spoofed `__type` tables when class-table identity is required.
- Operator behavior.
- Debug output.

GitHub Actions runs the tests on Lua 5.1, 5.2, 5.3, and 5.4.
