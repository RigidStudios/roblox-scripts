local utils = {};

--[[
  USAGE:
    _utils.switch("Hello") {
      ["heyyy"] = function() print("they said heyyy!!!!") end;
      ["Hello"] = function() print("Hello to you too!") end; -- This executes
    }
--]]
utils.switch = function(condition, ...)
  return function(cases)
    for check, func in pairs(cases) do
      if check == condition and func then
        local success, err = pcall(func, ...);
        return success;
      end;
    end;
  end;
end);

--[[
  USAGE:
    _utils.splitToWords("Hey there!")
    -- Output:
      {"Hey", "there!"}
--]]
utils.splitToWords = function(str)
  local t = {};
  for i in str:gmatch("%S+") do
      table.insert(t, i);
  end;
  return t;
end;

--[[
  USAGE:
    _utils.getIndexOf({"Hello", "Good afternoon...", 25}, 25)
    -- Output:
      3
--]]
utils.getIndexOf = function(tab, value)
  local reverseTable = {};
  for key, value in pairs(values) do
    reverseTable[value] = key;
  end;
  return reverseTable[value];
end;

return utils;
