title: StackOverflowLua
date: 2015-01-29 11:54:53
tags:
---


## table element
	
Maybe you will get the error _ `'}' expected near '='  `_ when use the syntax like `local tab = { 1 = "sth"}` or `local tab = { "key" = "sth"}`.Here is the right way:

	```
	local tab = tab = { [1] = "sth", [2] = "sth", name = "table", ["name1"] = "table"}  -- right
	```

##




