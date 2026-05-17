---
id: class-factory
title: Class Factory
sidebar_position: 1
---

# Class Factory

The module returns a callable table.

```lua
local Class = require("class")
```

## `Class(definition)`

Creates a class from a definition table.

```lua
local Example = Class({
    init = function(self)
        self.ready = true
    end,
})
```

Equivalent to `Class:new(definition)`.

## `Class:new(definition)`

Creates a class and prepares its metatable.

### Definition fields

| Field | Description |
| --- | --- |
| `init` | Optional constructor called for each instance. |
| `__type` | Optional readable type name. Defaults to `"Class"`. |
| `__includes` | Optional table, class, string, or list of includes. |
| methods | Any function fields become instance methods. |

## `Class:registerClass(name, prototype, parent)`

Creates a typed class from a prototype and optional parent.

```lua
local Registered = Class:registerClass("Registered", {
    hello = function()
        return "hello"
    end,
})
```

The returned class has `__type` set to `name` and operator helpers enabled.
