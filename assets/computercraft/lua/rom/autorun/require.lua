function require(fn)
    local apienv = {}
    
    setmetatable(apienv, {__index = _G})
    
    local apifunc, err = loadfile( fn )
    
    if apifunc then
        setfenv(apifunc, apienv)
        apifunc()
    else
        printError( err )
        return nil
    end
    
    local api = {}
    for k,v in pairs( apienv ) do
        api[k] = v
    end
    
    return api
end
