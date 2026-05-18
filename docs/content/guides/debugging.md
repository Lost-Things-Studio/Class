---
id: debugging
title: Debugging
sidebar_position: 4
---

# Debugging

Every class receives a `DebugInfos` method. It returns a formatted string with
the instance type, private data, and available methods.

```lua
local Debuggable = Class({
	__type = "Debuggable",

	init = function(self)
		self.__private.answer = 42
	end,

	ping = function()
		return "pong"
	end,
})

print(Debuggable():DebugInfos())
```

Use this for diagnostics during development. Avoid depending on the exact string
format for application logic.

For programmatic validation, use `Class:is`, `Class:assertIs`, `instance:Is`, or
`instance:AssertIs` instead of parsing debug output.
