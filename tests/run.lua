package.path = "./?.lua;./tests/?.lua;" .. package.path

require("class_test")

local test = require("test_helper")

test.run()
