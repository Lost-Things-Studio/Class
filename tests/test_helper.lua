local TestHelper = {
    tests = {},
}

local function repr(value)
    if type(value) == "string" then
        return string.format("%q", value)
    end

    return tostring(value)
end

local function fail(message, level)
    error(message, (level or 1) + 1)
end

function TestHelper.test(name, fn)
    table.insert(TestHelper.tests, {
        name = name,
        fn = fn,
    })
end

function TestHelper.assert_equal(expected, actual, message)
    if expected ~= actual then
        fail(
            string.format(
                "%sExpected %s, got %s.",
                message and (message .. "\n") or "",
                repr(expected),
                repr(actual)
            ),
            2
        )
    end
end

function TestHelper.assert_not_equal(unexpected, actual, message)
    if unexpected == actual then
        fail(
            string.format(
                "%sDid not expect %s.",
                message and (message .. "\n") or "",
                repr(actual)
            ),
            2
        )
    end
end

function TestHelper.assert_true(value, message)
    if not value then
        fail(message or "Expected value to be truthy.", 2)
    end
end

function TestHelper.assert_nil(value, message)
    if value ~= nil then
        fail(
            string.format(
                "%sExpected nil, got %s.",
                message and (message .. "\n") or "",
                repr(value)
            ),
            2
        )
    end
end

function TestHelper.assert_type(expectedType, value, message)
    TestHelper.assert_equal(expectedType, type(value), message)
end

function TestHelper.assert_contains(value, needle, message)
    local haystack = tostring(value)

    if not haystack:find(needle, 1, true) then
        fail(
            string.format(
                "%sExpected %q to contain %q.",
                message and (message .. "\n") or "",
                haystack,
                needle
            ),
            2
        )
    end
end

function TestHelper.assert_error(fn, expectedMessage)
    local ok, err = pcall(fn)

    if ok then
        fail("Expected function to raise an error.", 2)
    end

    if expectedMessage then
        TestHelper.assert_contains(err, expectedMessage, "Unexpected error message.")
    end

    return err
end

function TestHelper.run()
    local failed = 0
    local total = #TestHelper.tests

    for i, testCase in ipairs(TestHelper.tests) do
        io.write(string.format("[%d/%d] %s ... ", i, total, testCase.name))

        local ok, err = pcall(testCase.fn)

        if ok then
            print("ok")
        else
            failed = failed + 1
            print("FAILED")
            io.stderr:write(string.format("\n%s\n%s\n", testCase.name, tostring(err)))
        end
    end

    if failed > 0 then
        error(string.format("%d/%d tests failed.", failed, total), 0)
    end

    print(string.format("\n%d tests passed.", total))
end

return TestHelper
