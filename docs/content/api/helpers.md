---
id: helpers
title: Helpers
sidebar_position: 2
---

# Helpers

## `Class:include(target, source)`

Recursively copies values from `source` into `target`.

```lua
Class:include(TargetClass, Mixin)
```

Useful for composing behavior manually. Existing keys on `target` are preserved,
so includes do not overwrite methods already defined by the target class.

## `Class:clone(value)`

Creates a deep copy of a class or instance while preserving its metatable.

```lua
local Copy = Class:clone(Original)
```

An error is raised if the value has no metatable.

## `Class:accessor(instance, privateKey, name, defaultValue)`

Adds getter and setter methods to an instance.

```lua
Class:accessor(self, "name", "Name", "Unknown")

self:SetName("Ada")
print(self:GetName())
```

Generated method names are `Get<Name>` and `Set<Name>`.

## `Class:is(value, expected)`

Checks whether a value belongs to a class.

```lua
if Class:is(value, Player) then
	print("player")
end
```

The check accepts direct instances and instances whose class includes the
expected class as a parent. It can also compare with a string type name, but
class-table checks are safer.

## `Class:assertIs(value, expected, name)`

Raises an error when a value does not match the expected class.

```lua
Class:assertIs(value, Player, "value")
```

The optional `name` is used in the error message.

## `instance:Is(expected)`

Instance shortcut for `Class:is(instance, expected)`.

```lua
print(instance:Is(Player))
```

## `instance:AssertIs(expected, name)`

Instance shortcut for `Class:assertIs(instance, expected, name)`.

```lua
instance:AssertIs(Player, "instance")
```

## `instance:DebugInfos()`

Returns a formatted debug string for the instance.

```lua
print(instance:DebugInfos())
```
