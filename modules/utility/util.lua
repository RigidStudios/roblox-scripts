local utils = {};

--[[
  USAGE:
    _utils.switch("Hello") {
      ["heyyy"] = function() print("they said heyyy!!!!") end;
      ["Hello"] = function() print("Hello to you too!") end; -- This executes
    }
--]]
utils.switch = function(condition)
  return function(cases)
    for check, func in pairs(cases) do
      if check == condition and func then
        func();
        break;
      end;
    end;
  end;
end);
