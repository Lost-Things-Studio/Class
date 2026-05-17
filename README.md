<p align="center">
  <img src=".github/social_preview.jpg" alt="Class social preview" width="75%" />
</p>

<p align="center">
  <a href="https://github.com/Lost-Things-Studio/Class/releases">Releases</a> |
  <a href="https://github.com/Lost-Things-Studio/Class/releases/latest">Download</a> |
  <a href="https://luarocks.org/search?q=lost-class">LuaRocks</a> |
  <a href="https://lost-things-studio.github.io/Class/">Documentation</a> |
  <a href="https://lost-things-studio.github.io/Class/api/class-factory">API</a> |
  <a href="https://github.com/Lost-Things-Studio/Class/issues">Issues</a> |
  <a href="https://github.com/Lost-Things-Studio/Class/blob/main/CONTRIBUTING.md">Contributing</a>
</p>

<p align="center">
  <a href="https://github.com/Lost-Things-Studio/Class/actions/workflows/tests.yml">
    <img alt="tests" src="https://img.shields.io/github/actions/workflow/status/Lost-Things-Studio/Class/tests.yml?branch=main&label=tests&style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class/actions/workflows/documentation.yml">
    <img alt="documentation" src="https://img.shields.io/github/actions/workflow/status/Lost-Things-Studio/Class/documentation.yml?branch=main&label=docs&style=flat-square" />
  </a>
  <a href="https://www.lua.org/">
    <img alt="lua" src="https://img.shields.io/badge/Lua-5.1%2B-2C2D72?style=flat-square&logo=lua&logoColor=white" />
  </a>
  <a href="https://luarocks.org/search?q=lost-class">
    <img alt="LuaRocks" src="https://img.shields.io/badge/LuaRocks-lost--class-2c3e50?style=flat-square" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/Lost-Things-Studio/Class/releases/latest">
    <img alt="release" src="https://img.shields.io/github/v/release/Lost-Things-Studio/Class?include_prereleases&style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class/releases">
    <img alt="downloads" src="https://img.shields.io/github/downloads/Lost-Things-Studio/Class/total?color=green&style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class">
    <img alt="repo size" src="https://img.shields.io/github/repo-size/Lost-Things-Studio/Class?style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class/blob/main/LICENSE">
    <img alt="license" src="https://img.shields.io/github/license/Lost-Things-Studio/Class?color=green&style=flat-square" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/Lost-Things-Studio/Class/issues">
    <img alt="issues" src="https://img.shields.io/github/issues-raw/Lost-Things-Studio/Class?color=yellow&style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class/pulls">
    <img alt="pull requests" src="https://img.shields.io/github/issues-pr-raw/Lost-Things-Studio/Class?color=yellow&style=flat-square" />
  </a>
  <a href="https://github.com/Lost-Things-Studio/Class/stargazers">
    <img alt="stars" src="https://img.shields.io/github/stars/Lost-Things-Studio/Class?style=flat-square" />
  </a>
</p>

# Class

**Class** is a lightweight object-oriented helper for Lua projects that need class creation, instance initialization, inheritance-style includes, private instance state, accessor helpers, cloning, operator helpers, and debug output in a single `class.lua` file.

It is designed for projects that want OOP ergonomics without pulling a framework into the runtime.

## Why Class?

- **Single file** : Drop `class.lua` into your project or install it with LuaRocks.
- **No runtime dependency** : Pure Lua, no framework required.
- **Composable classes** : Reuse behavior with inheritance-style includes.
- **Private instance state** : Store internal data through `self.__private`.
- **Useful helpers** : Accessors, cloning, operators, and debug tools.
- **Lua 5.1+ compatible** : Tested across Lua 5.1, 5.2, 5.3, and 5.4.

## Installation

### LuaRocks

```bash
luarocks install lost-class
```

Then require the module:

```lua
local mClass = require("class")
```

> The LuaRocks package is named `lost-class`, but the Lua module remains `class`.

### Manual Installation

Copy `class.lua` into your project:

```bash
cp class.lua path/to/your/project/class.lua
```

Then require it:

```lua
local mClass = require("class")
```

## Quick Start

```lua
local mClass = require("class")

local cPlayer = mClass({
	__type = "Player",

	init = function(self, sName)
		self.name = sName
		self.__private.score = 0
	end,

	addScore = function(self, nAmount)
		self.__private.score = self.__private.score + nAmount
	end,

	getScore = function(self)
		return self.__private.score
	end,
})

local oPlayer = cPlayer("Ada")

oPlayer:addScore(10)

print(oPlayer.name)
print(oPlayer:getScore())
```

Expected output:

```txt
Ada
10
```

## Includes

Includes let you compose behavior from another class-like definition.

```lua
local mClass = require("class")

local cNamed = mClass({
	getName = function(self)
		return self.name
	end,
})

local cUser = mClass({
	__includes = cNamed,

	init = function(self, sName)
		self.name = sName
	end,
})

print(cUser("Ada"):getName())
```

## Feature Overview

| Feature | Description |
| --- | --- |
| Class creation | Build callable classes from Lua tables. |
| Instance initialization | Define an `init` method for constructor-like behavior. |
| Includes | Share methods between class definitions. |
| Private state | Use `self.__private` for per-instance internal data. |
| Accessors | Generate and manage structured access to values. |
| Cloning | Duplicate class instances when needed. |
| Operators | Add helper behavior for Lua metamethod-driven patterns. |
| Debug output | Inspect class and instance information more easily. |

## Documentation

The documentation is available here:

**[https://lost-things-studio.github.io/Class/](https://lost-things-studio.github.io/Class/)**

Run it locally:

```bash
cd docs
npm install
npm run start
```

Build the static site:

```bash
cd docs
npm run build
```

The generated site is written to `docs/build`.

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

## Release

The latest release is available here:

**[https://github.com/Lost-Things-Studio/Class/releases/latest](https://github.com/Lost-Things-Studio/Class/releases/latest)**

## Contributing

Contributions are welcome.

Please read:

- [Contributing guide](CONTRIBUTING.md)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

Class is released under the [MIT License](LICENSE).
