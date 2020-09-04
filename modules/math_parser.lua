local mather = {};

-- LuaPatterns for numbers and operations.
local patterns = {};
patterns.num     = "%-?%d+%.?%d*";
patterns.mult    = "%s-%*%s-";
patterns.mult2   = "%s-%x%s-";
patterns.plus    = "%s-%+%s-";
patterns.percent = "%s-%%%s-";
patterns.minus   = "%s-%-%s-";
patterns.div     = "%s-%/%s-";
patterns.parentheses = "%b()"

-- Extract numbers from string where possible.
function mather:GetNums(str)
	local numbers = {};
	for number in str:gmatch(patterns.num) do
		table.insert(numbers, tonumber(number));
	end;
	return numbers;
end


-- PLUS (+)
function mather.plus(str)
	local res, remaining = str:gsub(patterns.num..patterns.plus..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] + newNums[2];
	end);
	return res, remaining;
end

-- MINUS (-)
function mather.minus(str)
	local res, remaining = str:gsub(patterns.num..patterns.minus..patterns.num, function(secondStr)
		-- Remove the matched string minus to not consider negative: 4/9/20
		local newNums = mather:GetNums(secondStr:gsub("("..patterns.num.."%s-)(%-)(%s-"..patterns.num..")", function(a, b, c) print(a, b, c) return a.." "..c end));
		return newNums[1] - newNums[2];
	end);
	return res, remaining;
end

-- PERCENT (%)
function mather.percent(str)
	local res, remaining = str:gsub(patterns.num..patterns.percent, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] / 100;
	end);
	return res, remaining;
end

-- DIVISION (/)
function mather.div(str)
	local res, remaining = str:gsub(patterns.num..patterns.div..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] / newNums[2];
	end)
	return res, remaining;
end

-- MULTIPLICATION (*)
function mather.mult(str)
	local res, remaining = str:gsub(patterns.num..patterns.mult..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] * newNums[2];
	end)
	return res, remaining;
end

-- MULTIPLICATION (x)
function mather.mult2(str)
	return mather.mult(str:gsub("x", "*"));
end

-- PARENTHESES ((...))
function mather.parentheses(str)
	local res, remaining = str:gsub(patterns.parentheses, function(secondStr)
		-- Remove parentheses to re-calculate.
		secondStr = secondStr:sub(2, -2);
		return mather:Calculate(secondStr);
	end)
	return res, remaining;
end

-- Calculate whole string.
function mather:Calculate(str)
	-- Patterns to perform.
	local usablePatterns = {
		mather.parentheses;
		
		mather.percent;
		mather.mult;
		mather.mult2;
		mather.div;
		
		mather.minus;
		mather.plus;
	};
	
	local remainingOperations = 0;
	for k, v in pairs(usablePatterns) do
		repeat
			str, remainingOperations = v(str);
		until not remainingOperations or remainingOperations == 0;
	end;
	
	return str;
end;

return mather;
