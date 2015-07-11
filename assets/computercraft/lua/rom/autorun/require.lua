package = {}

package.cpath = ""
package.loaded = {}
package.loadlib = function() error("NotImplemented: package.loadlib") end
package.path = "?;?.lua;/lib/?;/lib/?.lua;/rom/apis/?;/rom/apis/turtle/?"
package.preload = {}
package.seeall = function(module) error("NotImplemented: package.seeall") end
module = function(m) error("NotImplemented: module") end

local _package_path_loader = function(name)
    
    local fname = name:gsub("%.", "/")
    
    for pattern in package.path:gmatch("[^;]+") do
        
        local fpath = pattern:gsub("%?", fname)
        
        if fs.exists(fpath) and not fs.isDir(fpath) then
            
            local apienv = {}
            setmetatable(apienv, {__index = _G})
            
            local apifunc, err = loadfile(fpath)
            local ok
            
            if apifunc then
                setfenv(apifunc, apienv)
                ok, err = pcall(apifunc)
            end
            
            if not apifunc or not ok then
                error("error loading module '" .. name .. "' from file '" .. fpath .. "'\n\t" .. err)
            end
            
            local api = {}
            for k,v in pairs( apienv ) do
                api[k] = v
            end
            
            return api
        end
    end
end

package.loaders = {
    function(name)
        if package.preload[name] then
            return package.preload[name]
        else
            return "\tno field package.preload['" .. name .. "']"
        end
    end,
    
    function(name)
        local _errors = {}
        
        local fname = name:gsub("%.", "/")
        
        for pattern in package.path:gmatch("[^;]+") do
            
            local fpath = pattern:gsub("%?", fname)
            if fs.exists(fpath) and not fs.isDir(fpath) then
                return _package_path_loader
            else
                table.insert(_errors, "\tno file '" .. fpath .. "'")
            end
        end
        
        return table.concat(_errors, "\n")
    end
}

function require(name)
    if package.loaded[name] then
        return package.loaded[name]
    end
    
    local _errors = {}
    
    for _, searcher in pairs(package.loaders) do
        local loader = searcher(name)
        if type(loader) == "function" then
            local res = loader(name)
            if res ~= nil then
                package.loaded[name] = res
            end
            
            if package.loaded[name] == nil then
                package.loaded[name] = true
            end
            
            return package.loaded[name]
        elseif type(loader) == "string" then
            table.insert(_errors, loader)
        end
    end
    
    error("module '" .. name .. "' not found:\n" .. table.concat(_errors, "\n"))
end