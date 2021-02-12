local Board = {};
local Square = require(script.Parent.Square);
local Util = require(script.Parent.Util);

-- Create a board.
function Board.new()
	return setmetatable({}, {__index = Board}):generateStart();
end;

-- Ran Automatically.
function Board:generateStart(amountToFree)
	self.squares = table.create(81, {});
	self.available = table.create(81, {});
	self.count = 1;
	
	for i = 1, #self.squares do
		self.available[i] = {1,2,3,4,5,6,7,8,9};
	end;
	
	return self;
end;

function Board:checkSquareConflicting(squares, square)
	for i, check in pairs(squares) do
		if check.value == square.value and (check.column == square.column
			or check.row == square.row
			or check.subGrid == square.subGrid) then
			return true;
		end
	end
	return false;
end

function Board:createSquare(index, value)
	local square = Square.new();
	square.column = Util.getColumn(index);
	square.row = Util.getRow(index);
	square.subGrid = Util.getSubGrid(index);
	square.value = value;
	square.index = index;
	
	return square;
end;

-- Generates board.
function Board:generate()
	while self.count <= 81 do
		if #self.available[self.count] ~= 0 then
			local currIndex = math.random(1, #self.available[self.count]);
			local value = self.available[self.count][currIndex];
			
			local potentialNewSquare = self:createSquare(self.count, value);
			
			if not self:checkSquareConflicting(self.squares, potentialNewSquare) then
				self.squares[self.count]=potentialNewSquare;
				table.remove(self.available[self.count], currIndex);
				self.count += 1;
			else
				table.remove(self.available[self.count], currIndex);
			end;
		else
			self.available[self.count] = {1,2,3,4,5,6,7,8,9};
			self.squares[self.count - 1] = {};
			self.count -= 1;
		end
	end
	return self;
end

function Board:print()
	Util.printGrid(self.squares);
end

return Board;
