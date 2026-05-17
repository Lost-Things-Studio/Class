---
id: private-state
title: Private State
sidebar_position: 3
---

# Private State

Each instance receives a `__private` table during construction. Use it for state
that should not be part of the public API.

```lua
local Account = Class({
    init = function(self)
        self.__private.balance = 0
    end,

    deposit = function(self, amount)
        self.__private.balance = self.__private.balance + amount
    end,
})
```

## Accessors

`Class:accessor` creates `Get<Name>` and `Set<Name>` methods backed by
`__private`.

```lua
local Account = Class({
    init = function(self)
        Class:accessor(self, "balance", "Balance", 0)
        self:SetBalance(0)
    end,
})

local account = Account()
account:SetBalance(100)
print(account:GetBalance())
```

When a setter receives `nil`, it falls back to the default value passed to
`Class:accessor`.
