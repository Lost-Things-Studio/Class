---
id: inheritance
title: Inheritance
sidebar_position: 2
---

# Inheritance

Class uses `__includes` to copy behavior from one or more classes or tables.
Included classes are also tracked as parents for `Class:is` and
`instance:Is` checks.

## Single include

```lua
local Named = Class({
	__type = "Named",

	getName = function(self)
		return self.name
	end,
})

local Player = Class({
	__type = "Player",
	__includes = Named,

	init = function(self, name)
		self.name = name
	end,
})

local player = Player("Ada")

print(player:getName())
print(player:Is(Player))
print(player:Is(Named))
```

## Multiple includes

```lua
local CanFly = Class({
	__type = "CanFly",

	fly = function()
		return "flying"
	end,
})

local CanSwim = Class({
	__type = "CanSwim",

	swim = function()
		return "swimming"
	end,
})

local Duck = Class({
	__type = "Duck",
	__includes = { CanFly, CanSwim },
})

local duck = Duck()

print(duck:fly())
print(duck:swim())
print(duck:Is(CanFly))
print(duck:Is(CanSwim))
```

Includes are applied in order. Existing keys on the target class are preserved.
If two included tables define the same key, the first included value is kept.
The class definition itself has priority over included values.

## Transitive parents

Parent links are transitive. If `Dog` includes `Animal`, and `Animal` includes
`Entity`, then `Dog()` is recognized as `Dog`, `Animal`, and `Entity`.

```lua
local Entity = Class({
	__type = "Entity",
})

local Animal = Class({
	__type = "Animal",
	__includes = Entity,
})

local Dog = Class({
	__type = "Dog",
	__includes = Animal,
})

local dog = Dog()

print(Class:is(dog, Dog))
print(Class:is(dog, Animal))
print(Class:is(dog, Entity))
```

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

When a string include resolves to a table, it is copied and tracked like any
other included table.
