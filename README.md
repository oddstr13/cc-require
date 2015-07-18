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
function api.hello(what)
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
-- API file: /lib/api.lua
local api = require("api")

api.hello("World")

```
```lua
-- API file: /lib/test/api.lua
local api = require("test.api")

api.hello("ComputerCraft")
```

The search paths, where require looks for the API, can be found [at the top of require.lua][link:cc-require require.lua]


Contribute
----------
 * [Bug reports go here][link:cc-require issues]
 * [Code can be found here][link:cc-require repo]
 * [Full list of contributors can be found here][link:cc-require commits]


Download and installation
-------------------------
Resource pack can be downloaded from the [Bitbucket download section][link:cc-require downloads].
Put the downloaded zip into the directory `resourcepacks/`, innside your minecraft directory, creating it if needed.



[link:5.1 PIL]: <http://www.lua.org/manual/5.1/manual.html>
[link:5.1 require]: <http://www.lua.org/manual/5.1/manual.html#pdf-require>

[link:cc-require issues]: <https://bitbucket.org/openshell/cc-require/issues>
[link:cc-require repo]: <https://bitbucket.org/openshell/cc-require>
[link:cc-require commits]: <https://bitbucket.org/openshell/cc-require/commits/all>
[link:cc-require downloads]: <https://bitbucket.org/openshell/cc-require/downloads>

[link:cc-require require.lua]: <https://bitbucket.org/openshell/cc-require/src/default/assets/computercraft/lua/rom/autorun/require.lua>
