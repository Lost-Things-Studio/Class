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

Set `__type` when you want readable debug output or type checks.

```lua
local User = Class({
    __type = "User",
})
```

If omitted, the default type is `"Class"`.

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
