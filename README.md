cc-require
==========

A standards compatible implementation of [require][link:5.1 require],
and part of the package library, as specified by the [Lua Manual][link:5.1 PIL]

Allows for compatability with many non-CC Lua programs and API.

Examples
--------

### Standards compatible:
```lua
local api = {}
api.hello = function(what)
    print("Hello, " .. what .. "!")
end

return api
```


### The ComputerCraft way:
```lua
function hello(what)
    print("Hello, " .. what .. "!")
end
```

The main difference is that with standard `require`, APIs `return` a table
containing the API, where as in ComputerCraft's `os.loadAPI`, the global
environment of the API file is put into `_G[api_filename]`.

This implementation of require allows you to import either type API.
It will however not place it in the global environment.
```lua
local api = require("/lib/api")

api.hello("World")
```


Contribute
----------
 * [Bug reports go here][link:cc-require issues]
 * [Code can be found here][link:cc-require repo]
 * [Full list of contributors can be found here][link:cc-require commits]



[link:5.1 PIL]: <http://www.lua.org/manual/5.1/manual.html>
[link:5.1 require]: <http://www.lua.org/manual/5.1/manual.html#pdf-require>

[link:cc-require issues]: <https://bitbucket.org/openshell/cc-require/issues>
[link:cc-require repo]: <https://bitbucket.org/openshell/cc-require>
[link:cc-require commits]: <https://bitbucket.org/openshell/cc-require/commits/all>
