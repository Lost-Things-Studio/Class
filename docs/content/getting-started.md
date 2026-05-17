---
id: getting-started
title: Getting Started
sidebar_position: 2
---

# Getting Started

Class is a single Lua file. Copy `class.lua` into your project and load it with
Lua's `require`.

```lua
local Class = require("class")
```

## Requirements

- Lua 5.1 or newer.
- No runtime dependency.

The CI suite checks Lua 5.1, 5.2, 5.3, and 5.4.

## Create a class

```lua
local Animal = Class({
    init = function(self, name)
        self.name = name
    end,

    speak = function(self)
        return self.name .. " makes a sound"
    end,
})

local animal = Animal("Milo")
print(animal:speak())
```

## Run tests

From the repository root:

```bash
lua tests/run.lua
```

Check syntax:

```bash
luac -p class.lua tests/*.lua
```
