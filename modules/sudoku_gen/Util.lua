local Util = {};

function Util.getRow(index: number): number
	return index % 9 == 0 and math.floor(index / 9) or math.floor(index / 9) + 1;
end

function Util.getColumn(index: number): number
	return index % 9 == 0 and 9 or index % 9;
end

function Util.getSubGrid(index: number): number
	local row = Util.getRow(index);
	local column = Util.getColumn(index);
	local gridNum = row < 4 and 1 or (row < 7 and 4 or (row < 10 and 7));
	return gridNum + math.ceil(column/3) - 1;
end

function Util.printGrid(grid)
	local str = "";
	for i, v in pairs(grid) do
		str ..= i % 9 == 0 and v.value or (i % 3 == 0 and (v.value .. "|") or v.value);
		if i % 9 == 0 then
			print(str);
			if i / 9 == 0 then
				print("-----------")
			end
			str = "";
		end
	end
end

return Util;
