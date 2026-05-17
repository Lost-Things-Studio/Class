---
id: operators
title: Operators
sidebar_position: 3
---

# Operators

## `Class:overloadOperators(class)`

Adds operator helpers to a class. The current implementation defines `__add` for
instances of the same type.

```lua
local Bag = Class({
    __type = "Bag",

    init = function(self, left, right)
        self.__private.left = left
        self.__private.right = right
    end,
})

Class:overloadOperators(Bag)

local merged = Bag("A", nil) + Bag(nil, "B")
```

The operation merges private fields from both operands. Values from the left
operand take priority when both sides define the same private key.

Adding incompatible types raises an error.
