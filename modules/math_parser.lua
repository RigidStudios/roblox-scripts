-- Author RigidStudios
-- Date: 09/03/20

local mather = {};

--[[ 
Math Parser Api:

	_math:GetNumbers(string) -->> {number}
	_math.Add(string) -->> ?results and ?remaining | ?number
	_math.Subtract(string) -->> ?results and ?remaining | ?number
	_math.Percent(string) -->> ?results and ?remaining | ?number
	_math.Divide(string) -->> ?results and ?remaining | ?number
	_math.Multiply(string) -->> ?results and ?remaining | ?number
	_math.FormatMultiply(string) -->> string
	_math.Parentheses(string) -->> ?results and ?remaining | ?number
	_math:Caculate(string) -->> string
        _math.patterns --> {string}

-- Proper Usage:
        _math:Calculate(string) -->> string
--]]


-- .. LuaPatterns for numbers and operations.
mather.patterns = {};
mather.patterns.num     = "%-?%d+%.?%d*";
mather.patterns.mult    = "%s-%*%s-";
mather.patterns.mult2   = "%s-%x%s-";
mather.patterns.plus    = "%s-%+%s-";
mather.patterns.percent = "%s-%%%s-";
mather.patterns.minus   = "%s-%-%s-";
mather.patterns.div     = "%s-%/%s-";
mather.patterns.parentheses = "%b()"

-- .. Extract numbers from string where possible.
function mather:GetNumbers(str)
	local numbers = {};
	for number in str:gmatch(patterns.num) do
		table.insert(numbers, tonumber(number));
	end;
	return numbers;
end

-- ADD (+)
function mather.Add(str)
	local res, remaining = str:gsub(patterns.num..patterns.plus..patterns.num, function(secondStr)
		local newNums = mather:GetNumbers(secondStr);
		return newNums[1] + newNums[2];
	end);
	return res, remaining;
end

-- MINUS (-)
function mather.Subtract(str)
	local res, remaining = str:gsub(patterns.num..patterns.minus..patterns.num, function(secondStr)
		-- Remove the matched string minus to not consider negative: 4/9/20
		local newNums = mather:GetNumbers(secondStr:gsub("("..patterns.num.."%s-)(%-)(%s-"..patterns.num..")", function(a, b, c) print(a, b, c) return a.." "..c end));
		return newNums[1] - newNums[2];
	end);
	return res, remaining;
end

-- PERCENT (%)
function mather.Percent(str)
	local res, remaining = str:gsub(patterns.num..patterns.percent, function(secondStr)
		local newNums = mather:GetNumbers(secondStr);
		return newNums[1] / 100;
	end);
	return res, remaining;
end

-- DIVISION (/)
function mather.Divide(str)
	local res, remaining = str:gsub(patterns.num..patterns.div..patterns.num, function(secondStr)
		local newNums = mather:GetNumbers(secondStr);
		return newNums[1] / newNums[2];
	end)
	return res, remaining;
end

-- MULTIPLICATION (*)
function mather.Multiply(str)
	local res, remaining = str:gsub(patterns.num..patterns.mult..patterns.num, function(secondStr)
		local newNums = mather:GetNumbers(secondStr);
		return newNums[1] * newNums[2];
	end)
	return res, remaining;
end

-- FORMAT_MULTIPLICATION (x)
function mather.FormatMultiply(str)
	return mather.Multiply(str:gsub("x", "*"));
end

-- PARENTHESES ((...))
function mather.Parentheses(str)
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
		mather.Parentheses;
		
		mather.Percent;
		mather.Multiply;
		mather.FormatMultiply;
		mather.Divide;
		
		mather.Subtract;
		mather.Add;
	};
	
	local remainingOperations = 0;
	for _, v in pairs(usablePatterns) do
		repeat
			str, remainingOperations = v(str);
		until not remainingOperations or remainingOperations == 0;
	end;
	
	return str;
end;

return mather;
