local mather = {};

local patterns = {};
patterns.num = "%-?%d+%.?%d*";
patterns.mult = "%s-%*%s-";
patterns.mult2 = "%s-%x%s-";
patterns.plus = "%s-%+%s-";
patterns.minus = "%s-%-%s-";
patterns.div = "%s-%/%s-";
patterns.parentheses = "%b()"

-- Get Numbers.
function mather:GetNums(str)
	local numbers = {};
	local str = str:gsub("%s", "");
	for number in str:gmatch(patterns.num) do
		table.insert(numbers, tonumber(number));
	end;
	return numbers;
end

function mather.plus(str)
	local res, remaining = str:gsub(patterns.num..patterns.plus..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] + newNums[2];
	end);
	return res, remaining;
end

function mather.minus(str)
	local res, remaining = str:gsub(patterns.num..patterns.minus..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] - newNums[2];
	end);
	return res, remaining;
end

function mather.div(str)
	local res, remaining = str:gsub(patterns.num..patterns.div..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] - newNums[2];
	end)
	return res, remaining;
end

function mather.mult(str)
	local res, remaining = str:gsub(patterns.num..patterns.mult..patterns.num, function(secondStr)
		local newNums = mather:GetNums(secondStr);
		return newNums[1] * newNums[2];
	end)
	return res, remaining;
end

function mather.mult2(str)
	return mather.mult(str:gsub("x", "*"));
end

function mather.parentheses(str)
	local res, remaining = str:gsub(patterns.parentheses, function(secondStr)
		secondStr = secondStr:sub(2, -2);
		return mather:Calculate(secondStr);
	end)
	return res, remaining;
end

function mather:Calculate(str)
	local usablePatterns = {
		mather.parentheses;
		mather.mult;
		mather.mult2;
		mather.div;
		mather.plus;
		mather.minus;
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
