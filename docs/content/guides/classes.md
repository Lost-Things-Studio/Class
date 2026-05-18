---
id: classes
title: Classes and Instances
sidebar_position: 1
---

# Classes and Instances

Create a class by passing a definition table to `Class`.

```lua
local Class = require("class")

local Counter = Class({
	__type = "Counter",

	init = function(self, value)
		self.value = value or 0
	end,

	increment = function(self)
		self.value = self.value + 1
		return self.value
	end,
})

local counter = Counter(10)
counter:increment()
```

## Initialization

`init` is called automatically when an instance is created.

```lua
local user = User("Ada")
```

Arguments passed to the class call are forwarded to `init`.

## Type names

Set `__type` when you want readable debug output and clearer error messages.

```lua
local User = Class({
	__type = "User",
})
```

If omitted, the default type is `"Class"`.

## Type identity

Each instance stores its class in `__class`. Prefer class-table checks when you
need reliable validation.

```lua
local user = User()

print(user.__class == User)
print(Class:is(user, User))
print(user:Is(User))
```

`Class:is(value, expected)` returns `true` when `value` is an instance of
`expected`, or when its class includes `expected` as a parent.

```lua
Class:assertIs(user, User, "user")
user:AssertIs(User, "user")
```

`__type` string checks are supported for convenience, but they are less strict
than checking against the class table itself.

## Positional init shorthand

The first item in the definition table can be used as `init`.

```lua
local Point = Class({
	function(self, x, y)
		self.x = x
		self.y = y
	end,
})
```
