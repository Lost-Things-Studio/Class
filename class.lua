local unpack = table.unpack or unpack

return setmetatable({
	includeHelper = function(self, tClass, tOther, tSeen)
		if tOther == nil then
			return tClass
		end

		if type(tOther) ~= "table" then
			return tOther
		end

		if tSeen[tOther] then
			return tSeen[tOther]
		end

		tSeen[tOther] = tClass

		for sKey, vValue in pairs(tOther) do
			if not tSeen[sKey] and sKey ~= "__parents" and tClass[sKey] == nil then
				tClass[sKey] = self:includeHelper({}, vValue, tSeen)
			end
		end

		return tClass
	end,

	debugInfo = function(self, tSelf)
		local tMt = (type(tSelf) == "userdata") and getmetatable(tSelf) or tSelf
		local tMethodSource = tMt

		if type(tSelf) == "table" and rawget(tSelf, "__private") then
			tMethodSource = getmetatable(tSelf) or tSelf
		end

		local tStr = {
			"==========================",
			"=== DEBUG OBJECT INFO ===",
			"==========================",
			"\nType: " .. (tMt.__type or "Unknown"),
			"\n# Private Data:",
		}
		local tPrivateData = {}

		if tMt.__private then
			for k, v in pairs(tMt.__private) do
				table.insert(tPrivateData, string.format("  - %s = %s", k, tostring(v)))
			end
		end

		table.insert(tStr, #tPrivateData > 0 and table.concat(tPrivateData, "\n") or "  (empty)")

		table.insert(tStr, "\n# Methods:")
		table.insert(
			tStr,
			table.concat(
				(function()
					local tMethods = {}

					for sKey, vValue in pairs(tMethodSource) do
						if type(vValue) == "function" then
							table.insert(
								tMethods,
								string.format("  - %s type : %s", sKey, type(vValue))
							)
						end
					end

					return tMethods
				end)(),
				"\n"
			)
		)
		table.insert(tStr, "\n==========================")

		return table.concat(tStr, "\n")
	end,

	accessor = function(self, tSelf, tVarName, tName, tDefaultValue)
		tSelf["Get" .. tName] = function(tSelf)
			return tSelf.__private[tVarName]
		end

		tSelf["Set" .. tName] = function(tSelf, tV)
			tSelf.__private[tVarName] = tV ~= nil and tV or tDefaultValue
		end
	end,

	include = function(self, tClass, tOther)
		return self:includeHelper(tClass, tOther, {})
	end,

	clone = function(self, tOther)
		return setmetatable(
			self:include({}, tOther),
			assert(getmetatable(tOther), "Cannot clone an object without a metatable.")
		)
	end,

	is = function(self, vValue, vExpected)
		local sValueType = type(vValue)
		local tValueMt = (sValueType == "table" or sValueType == "userdata") and getmetatable(vValue) or nil
		local tParents = nil

		if type(vExpected) == "string" then
			if (tValueMt and tValueMt.__type == vExpected)
				or (sValueType == "table" and rawget(vValue, "__type") == vExpected) then
				return true
			end

			tParents = (tValueMt and rawget(tValueMt, "__parents"))
				or (sValueType == "table" and rawget(vValue, "__parents"))
				or nil

			if tParents then
				for tParent in pairs(tParents) do
					if tParent.__type == vExpected then
						return true
					end
				end
			end

			return false
		end

		if type(vExpected) ~= "table" then
			return false
		end

		if vValue == vExpected or tValueMt == vExpected then
			return true
		end

		tParents = (tValueMt and rawget(tValueMt, "__parents"))
			or (sValueType == "table" and rawget(vValue, "__parents"))
			or nil

		return (tParents and tParents[vExpected]) and true or false
	end,

	assertIs = function(self, vValue, vExpected, sName)
		if self:is(vValue, vExpected) then
			return vValue
		end

		local sExpected = type(vExpected) == "table" and (vExpected.__type or "Unknown") or tostring(vExpected)
		local sValueType = type(vValue)
		local tValueMt = (sValueType == "table" or sValueType == "userdata") and getmetatable(vValue) or nil
		local sValue = (tValueMt and tValueMt.__type)
			or (sValueType == "table" and rawget(vValue, "__type"))
			or sValueType

		error("[CLASS] " .. (sName or "value") .. " must be " .. sExpected .. ", got " .. sValue .. ".", 2)
	end,

	overloadOperators = function(self, tClass)
		assert(type(tClass) == "table", "[CLASS] ...")

		tClass.__add = function(tA, tB)
			assert(
				tA.__type == tClass.__type,
				"[CLASS] Attempted to add incompatible types: "
					.. tA.__type
					.. " and "
					.. tB.__type
			)
			assert(
				tB.__type == tClass.__type,
				"[CLASS] Attempted to add incompatible types: "
					.. tA.__type
					.. " and "
					.. tB.__type
			)

			local tResult = {}

			for tKey, tValue in pairs(tA.__private) do
				tResult[tKey] = tValue
			end

			for tKey, tValue in pairs(tB.__private) do
				tResult[tKey] = tResult[tKey] or tValue
			end

			for tKey, tValue in pairs(tA.__privateMethods) do
				tResult[tKey] = tValue
			end

			for tKey, tValue in pairs(tB.__privateMethods) do
				tResult[tKey] = tResult[tKey] or tValue
			end

			return setmetatable(tResult, {
				__type = tA.__type,
				__privateMethods = tResult.__privateMethods or {},
			})
		end
	end,

	new = function(self, tClass)
		tClass = tClass or {}

		local tInc = getmetatable(tClass.__includes) and { tClass.__includes }
			or tClass.__includes
			or {}

		tClass.__parents = tClass.__parents or {}

		for _, tOther in ipairs(tInc) do
			if type(tOther) == "string" then
				tOther = _G[tOther]
			end

			if type(tOther) == "table" then
				self:include(tClass, tOther)

				tClass.__parents[tOther] = true

				if type(tOther.__parents) == "table" then
					for tParent in pairs(tOther.__parents) do
						tClass.__parents[tParent] = true
					end
				end
			end
		end

		tClass.__type = tClass.__type or "Class"
		tClass.__privateMethods = tClass.__privateMethods or {}

		local function classIndex(tSelf, tKey)
			local tPrivateMethods = rawget(tSelf, "__privateMethods") or tClass.__privateMethods

			if tKey == "__privateMethods" then
				return nil
			end

			if tPrivateMethods and tPrivateMethods[tKey] then
				return function(_, ...)
					return tPrivateMethods[tKey](tSelf, ...)
				end
			end

			return rawget(tClass, tKey)
		end

		tClass.__index = classIndex

		local tMethodsToHide = {
			init = tClass.init or tClass[1] or function() end,
			include = tClass.include or function(...)
				return self:include(...)
			end,
			clone = tClass.clone or function(...)
				return self:clone(...)
			end,
			Is = tClass.Is or tClass.__privateMethods.Is or function(tSelf, vExpected)
				return self:is(tSelf, vExpected)
			end,
			AssertIs = tClass.AssertIs or tClass.__privateMethods.AssertIs or function(tSelf, vExpected, sName)
				return self:assertIs(tSelf, vExpected, sName)
			end,
			DebugInfos = tClass.__privateMethods.DebugInfos or function(...)
				return self:debugInfo(...)
			end,
		}

		for sKey, vValue in pairs(tMethodsToHide) do
			if vValue then
				tClass.__privateMethods[sKey] = vValue
				tClass[sKey] = nil
			end
		end

		return setmetatable(tClass, {
			__call = function(tC, ...)
				local tO = setmetatable({}, tC)
				local tArgs = { ... }
				local iArgsCount = select("#", ...)

				tO.__private = {}
				tO.__type = tC.__type
				tO.__class = tC
				tO.__privateMethods = tC.__privateMethods

				assert(xpcall(
					function()
						tO.__privateMethods.init(tO, unpack(tArgs, 1, iArgsCount))
					end,
					function(tErr)
						return "Init Error: " .. tErr
					end
				))

				return tO
			end,

			__gc = function(tO)
				if tO.destroy then
					pcall(function()
						tO:destroy()
					end)
				else
					tO = nil
				end
			end,

			__index = classIndex,
		})
	end,

	registerClass = function(self, tName, tPrototype, tParent)
		local tCls = self:new({ __includes = { tPrototype, tParent } })

		tCls.__type = tName
		self:overloadOperators(tCls)

		return tCls
	end,
}, {
	__call = function(self, ...)
		return self:new(...)
	end,
})
