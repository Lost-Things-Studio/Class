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

### Generated instance fields

| Field | Description |
| --- | --- |
| `__private` | Per-instance table for private state. |
| `__type` | Readable type copied from the class. |
| `__class` | Direct reference to the class table that created the instance. |

### Generated instance methods

| Method | Description |
| --- | --- |
| `Is(expected)` | Returns whether the instance matches a class, parent class, or type name. |
| `AssertIs(expected, name)` | Raises an error when the instance does not match `expected`. |
| `DebugInfos()` | Returns formatted diagnostic information. |

## `Class:is(value, expected)`

Returns `true` when `value` matches `expected`.

```lua
local Player = Class({
	__type = "Player",
})

local player = Player()

print(Class:is(player, Player))
print(player:Is(Player))
```

`expected` can be a class table or a string. Class-table checks are stricter and
should be preferred for validation.

## `Class:assertIs(value, expected, name)`

Validates a value and returns it when it matches the expected class.

```lua
player = Class:assertIs(player, Player, "player")
```

When validation fails, an error is raised with the expected and received type.

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
Prototype and parent tables are included and tracked for type checks.
