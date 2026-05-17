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

Useful for composing behavior manually.

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

## `instance:DebugInfos()`

Returns a formatted debug string for the instance.

```lua
print(instance:DebugInfos())
```
