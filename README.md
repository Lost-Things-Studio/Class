# Class

[![Tests](https://github.com/Gopmyc/Class/actions/workflows/tests.yml/badge.svg)](https://github.com/Gopmyc/Class/actions/workflows/tests.yml)
[![Documentation](https://github.com/Gopmyc/Class/actions/workflows/documentation.yml/badge.svg)](https://github.com/Gopmyc/Class/actions/workflows/documentation.yml)
[![License: MIT](https://img.shields.io/github/license/Gopmyc/Class.svg)](LICENSE)

Class is a small object-oriented helper for Lua. It gives you class creation,
instance initialization, inheritance-style includes, private instance state,
operator helpers, and debug output in a single `class.lua` file.

## Why Use It

- Single-file Lua module.
- No runtime dependency.
- Compatible with Lua 5.1+.
- Simple class and instance syntax.
- Built-in helpers for includes, private state, accessors, cloning, and debug info.

## Installation

Copy `class.lua` into your project and require it:

```lua
local Class = require("class")
```

## Quick Start

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

    getScore = function(self)
        return self.__private.score
    end,
})

local player = Player("Ada")
player:addScore(10)

print(player.name)       -- Ada
print(player:getScore()) -- 10
```

## Inheritance-Style Includes

```lua
local Named = Class({
    getName = function(self)
        return self.name
    end,
})

local User = Class({
    __includes = Named,

    init = function(self, name)
        self.name = name
    end,
})

print(User("Ada"):getName())
```

## Tests

Run the Lua test suite from the repository root:

```bash
lua tests/run.lua
```

Check syntax:

```bash
luac -p class.lua tests/*.lua
```

The GitHub Actions test workflow runs on Lua 5.1, 5.2, 5.3, and 5.4.

## Documentation

The Docusaurus documentation lives in `docs/`.

```bash
cd docs
npm install
npm run start
```

Build the static documentation:

```bash
cd docs
npm run build
```

The generated static site is written to `docs/build`.

Published documentation: [https://gopmyc.github.io/Class/](https://gopmyc.github.io/Class/)

## Contributing

Contributions are welcome. Please read:

- [Contributing guide](CONTRIBUTING.md)
- [Code of conduct](CODE_OF_PRODUCT.md)

## License

Class is released under the [MIT License](LICENSE).
