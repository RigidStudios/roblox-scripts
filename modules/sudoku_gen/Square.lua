local Square = {}

function Square.new()
	local square = setmetatable({}, {__index=Square});
	
	return square;
end

return Square;
