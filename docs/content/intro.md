---
id: intro
title: Overview
sidebar_position: 1
---

# Class

Class is a small object-oriented helper for Lua. It provides class creation,
instance initialization, inheritance through includes, private instance storage,
operator helpers, and debug output from a single `class.lua` file.

Use it when you want a compact OOP layer without adding a framework or runtime
dependency.

## Core ideas

- A class is created with `Class({...})` or `Class:new({...})`.
- Instance initialization is handled by `init`.
- Inheritance is expressed with `__includes`.
- Private state is stored in `self.__private`.
- Accessors can be generated with `Class:accessor`.
- Tests run with plain Lua from `tests/run.lua`.

## Minimal example

```lua
local Class = require("class")

local Player = Class({
    __type = "Player",

    init = function(self, name)
        self.name = name
        self.__private.score = 0
    end,

    addScore = function(self, amount)
        self.__private.score = self.__private.score + amount
    end,
})

local player = Player("Ada")
player:addScore(10)
```
