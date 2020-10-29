-- ORIGINAL
function splitToWords(str)
    local t = {};
    for i in str:gmatch("%S+") do
        table.insert(t, i);
    end;
    return t;
end

-- Parsing Patterns/Functions
local parsingPatterns = {
    -- "Hi" <- string
    ["string"] = function(str)
        return str:gmatch('".-"');
    end;
    -- 42 <- number
    ["number"] = function(str)
        -- Replace all strings.
        str = str:gsub('".-"', '');
        -- Match Digits (DOES NOT SUPPORT FLOATS)
        return str:gmatch('%d+');
    end;
    -- lol <- keyword
    ["keyword"] = function(str)
        -- TODO(MAJOR): keyword type
    end;
}

function parseStr(cmdstr)
    local commandUsed = splitToWords(cmdstr)[1];
    
    local parser = { command = cmdstr; commandName = commandUsed; indexes = {}; };
    
    -- Type indexes set to 1
    for k, _ in pairs(parsingPatterns) do parser.indexes[k] = 1 end;
    
    -- Returns a string
    function parser:NextOfType(typeName)
        -- Start at 0 to allow direct-return to not offset NextOfType.
        local currIndex = 0;
        for ofType in parsingPatterns[typeName](self.command) do
            parser.indexes[typeName] = parser.indexes[typeName] + 1;
            if currIndex == parser.indexes[typeName] then
                return ofType;
            end;
            currIndex = currIndex + 1;
        end;
    end
    
    -- Returns a table
    function parser:AllOfType(typeName)
        local results = {};
        for ofType in parsingPatterns[typeName](self.command) do
            table.insert(results, ofType);
        end;
        return results;
    end;
    
    -- Returns an iterator
    function parser:AllOfTypeIter(typeName)
        return parsingPatterns[typeName](self.command);
    end;
    
    return parser;
end;

return parseStr;
