---
id: inheritance
title: Inheritance
sidebar_position: 2
---

# Inheritance

Class uses `__includes` to copy behavior from one or more classes or tables.

## Single include

```lua
local Named = Class({
    getName = function(self)
        return self.name
    end,
})

local Player = Class({
    __includes = Named,

    init = function(self, name)
        self.name = name
    end,
})
```

## Multiple includes

```lua
local CanFly = Class({
    fly = function()
        return "flying"
    end,
})

local CanSwim = Class({
    swim = function()
        return "swimming"
    end,
})

local Duck = Class({
    __includes = { CanFly, CanSwim },
})
```

Includes are applied in order. If two included tables define the same key, the
later include can replace the earlier value.

## Global string include

String includes are resolved through `_G`.

```lua
_G.SharedBehavior = {
    shared = function()
        return true
    end,
}

local Example = Class({
    __includes = "SharedBehavior",
})
```
