local test = require("test_helper")
local Class = require("class")

test.test("module exposes the class factory helpers", function()
	test.assert_type("table", Class)
	test.assert_type("function", Class.new)
	test.assert_type("function", Class.include)
	test.assert_type("function", Class.clone)
	test.assert_type("function", Class.is)
	test.assert_type("function", Class.assertIs)
	test.assert_type("function", getmetatable(Class).__call)
end)

test.test("Class(...) creates a class and initializes instances with arguments", function()
	local Person = Class({
		__type = "Person",

		init = function(self, name, age)
			self.name = name
			self.__private.age = age
		end,

		greet = function(self)
			return "Hello " .. self.name
		end,
	})

	local ada = Person("Ada", 42)

	test.assert_equal("Person", Person.__type)
	test.assert_equal("Person", ada.__type)
	test.assert_equal(Person, ada.__class)
	test.assert_equal("Ada", ada.name)
	test.assert_equal(42, ada.__private.age)
	test.assert_equal("Hello Ada", ada:greet())
	test.assert_equal(true, Class:is(ada, Person))
	test.assert_equal(true, ada:Is(Person))
	test.assert_equal(ada, Class:assertIs(ada, Person, "ada"))
	test.assert_equal(ada, ada:AssertIs(Person, "ada"))
	test.assert_nil(rawget(Person, "init"))
end)

test.test("Class:new supports positional init shorthand", function()
	local Counter = Class:new({
		function(self, value)
			self.value = value
		end,

		increment = function(self)
			self.value = self.value + 1
			return self.value
		end,
	})

	local counter = Counter(10)

	test.assert_equal(11, counter:increment())
	test.assert_equal(11, counter.value)
end)

test.test("init errors are wrapped with context", function()
	local Broken = Class({
		init = function()
			error("boom")
		end,
	})

	local err = test.assert_error(function()
		Broken()
	end, "Init Error:")

	test.assert_contains(err, "boom")
end)

test.test("accessor creates getters and setters backed by __private", function()
	local Account = Class({
		init = function(self)
			Class:accessor(self, "balance", "Balance", 0)
			self:SetBalance(nil)
		end,
	})

	local account = Account()

	test.assert_equal(0, account:GetBalance())

	account:SetBalance(125)
	test.assert_equal(125, account:GetBalance())
	test.assert_equal(125, account.__private.balance)

	account:SetBalance(nil)
	test.assert_equal(0, account:GetBalance())
end)

test.test("single inheritance copies parent methods and tracks parent classes", function()
	local Animal = Class({
		__type = "Animal",

		speak = function(self)
			return self.sound
		end,
	})

	local Dog = Class({
		__type = "Dog",
		__includes = Animal,

		init = function(self)
			self.sound = "woof"
		end,
	})

	local dog = Dog()

	test.assert_equal("Dog", Dog.__type)
	test.assert_equal("Dog", dog.__type)
	test.assert_equal("woof", dog:speak())
	test.assert_equal(true, Class:is(dog, Dog))
	test.assert_equal(true, Class:is(dog, Animal))
	test.assert_equal(true, Class:is(dog, "Dog"))
	test.assert_equal(true, Class:is(dog, "Animal"))
end)

test.test("multiple inheritance copies methods from every included class", function()
	local Flyer = Class({
		__type = "Flyer",

		fly = function()
			return "flying"
		end,
	})

	local Swimmer = Class({
		__type = "Swimmer",

		swim = function()
			return "swimming"
		end,
	})

	local Duck = Class({
		__type = "Duck",
		__includes = { Flyer, Swimmer },
	})

	local duck = Duck()

	test.assert_equal("flying", duck:fly())
	test.assert_equal("swimming", duck:swim())
	test.assert_equal(true, Class:is(duck, Duck))
	test.assert_equal(true, Class:is(duck, Flyer))
	test.assert_equal(true, Class:is(duck, Swimmer))
end)

test.test("transitive inheritance is tracked by Class:is", function()
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

	test.assert_equal(true, Class:is(dog, Dog))
	test.assert_equal(true, Class:is(dog, Animal))
	test.assert_equal(true, Class:is(dog, Entity))
	test.assert_equal(true, dog:Is(Entity))
end)

test.test("Class:is rejects unrelated classes and spoofed tables", function()
	local Player = Class({
		__type = "Player",
	})

	local Enemy = Class({
		__type = "Enemy",
	})

	local player = Player()
	local fakePlayer = {
		__type = "Player",
	}

	test.assert_equal(true, Class:is(player, Player))
	test.assert_equal(false, Class:is(player, Enemy))
	test.assert_equal(false, Class:is(fakePlayer, Player))
	test.assert_equal(false, Class:is(nil, Player))
	test.assert_equal(false, Class:is(player, nil))
end)

test.test("Class:assertIs returns matching values and reports mismatches", function()
	local Bag = Class({
		__type = "Bag",
	})

	local Box = Class({
		__type = "Box",
	})

	local bag = Bag()
	local box = Box()

	test.assert_equal(bag, Class:assertIs(bag, Bag, "item"))
	test.assert_equal(bag, bag:AssertIs(Bag, "item"))

	local err = test.assert_error(function()
		Class:assertIs(box, Bag, "item")
	end, "[CLASS] item must be Bag")

	test.assert_contains(err, "got Box")
end)

test.test("included parents do not override child fields", function()
	local Parent = Class({
		__type = "Parent",

		init = function(self)
			self.name = "parent"
		end,

		value = "parent-value",
	})

	local Child = Class({
		__type = "Child",
		__includes = Parent,

		init = function(self)
			self.name = "child"
		end,

		value = "child-value",
	})

	local child = Child()

	test.assert_equal("Child", Child.__type)
	test.assert_equal("Child", child.__type)
	test.assert_equal("child", child.name)
	test.assert_equal("child-value", Child.value)
	test.assert_equal(true, Class:is(child, Parent))
end)

test.test("string includes resolve classes from the global table", function()
	_G.__ClassTestMixin = {
		globalMethod = function()
			return "from global"
		end,
	}

	local ok, err = pcall(function()
		local UsesGlobalMixin = Class({
			__includes = "__ClassTestMixin",
		})

		test.assert_equal("from global", UsesGlobalMixin():globalMethod())
	end)

	_G.__ClassTestMixin = nil

	if not ok then
		error(err)
	end
end)

test.test("include recursively copies nested tables", function()
	local source = {
		config = {
			enabled = true,
			retries = 3,
		},
	}
	local target = {}

	Class:include(target, source)
	source.config.enabled = false
	source.config.retries = 9

	test.assert_equal(true, target.config.enabled)
	test.assert_equal(3, target.config.retries)
end)

test.test("clone deep-copies data while preserving the metatable", function()
	local Original = Class({
		nested = {
			value = 1,
		},

		getNestedValue = function(self)
			return self.nested.value
		end,
	})

	local Copy = Class:clone(Original)

	test.assert_not_equal(Original, Copy)
	test.assert_equal(getmetatable(Original), getmetatable(Copy))
	test.assert_equal(1, Copy.nested.value)

	Copy.nested.value = 2

	test.assert_equal(1, Original.nested.value)
	test.assert_equal(2, Copy.nested.value)
end)

test.test("registerClass creates a typed class with prototype and parent methods", function()
	local Parent = {
		parentMethod = function()
			return "parent"
		end,
	}
	local Prototype = {
		childMethod = function()
			return "child"
		end,
	}

	local Registered = Class:registerClass("RegisteredType", Prototype, Parent)
	local instance = Registered()

	test.assert_equal("RegisteredType", Registered.__type)
	test.assert_equal("RegisteredType", instance.__type)
	test.assert_equal("parent", instance:parentMethod())
	test.assert_equal("child", instance:childMethod())
	test.assert_equal(true, Class:is(instance, Registered))
	test.assert_equal(true, Class:is(instance, Parent))
	test.assert_equal(true, Class:is(instance, Prototype))
end)

test.test("operator overloading merges private data for compatible instances", function()
	local Bag = Class({
		__type = "Bag",

		init = function(self, left, right)
			self.__private.left = left
			self.__private.right = right
		end,
	})

	Class:overloadOperators(Bag)

	local merged = Bag("A", nil) + Bag(nil, "B")

	test.assert_equal("A", merged.left)
	test.assert_equal("B", merged.right)
	test.assert_equal("Bag", getmetatable(merged).__type)
end)

test.test("operator overloading rejects incompatible instance types", function()
	local Bag = Class({
		__type = "Bag",
	})
	local Box = Class({
		__type = "Box",
	})

	Class:overloadOperators(Bag)
	Class:overloadOperators(Box)

	test.assert_error(function()
		local _ = Bag() + Box()
	end, "Attempted to add incompatible types")
end)

test.test("DebugInfos returns type, private data, and public methods", function()
	local Debuggable = Class({
		__type = "Debuggable",

		init = function(self)
			self.__private.answer = 42
		end,

		ping = function()
			return "pong"
		end,
	})

	local info = Debuggable():DebugInfos()

	test.assert_contains(info, "DEBUG OBJECT INFO")
	test.assert_contains(info, "Type: Debuggable")
	test.assert_contains(info, "answer = 42")
	test.assert_contains(info, "ping type : function")
end)
