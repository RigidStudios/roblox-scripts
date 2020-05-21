-- Made by RigidStudios

local c = {}

function c.new(typ, par, nam, siz, pos, ext)
	local collapse = true
	local typs = {
		IntValue=true,
		BoolValue=true,
		StringValue=true,
		Part=true,
		MeshPart=true,
		Frame=true,
		TextLabel=true
	}
		if typs[typ] then print("Instance Creating...") else print("Invalid") return "Invalid." end -- If the instance type doesn't exist in our dictionary.
	local obj = Instance.new(typ) -- Creates, adds parent and name.
	obj.Parent = par
	obj.Name = nam
	
	-- This checks the item type, gives it its values if they exist.
	if collapse then -- Literally just a collapser because I couldn't be bothered to always look at this.
		if typ == "IntValue" then
			if siz then obj.Value = siz end
		elseif typ == "BoolValue" then
			if siz then obj.Value = siz end
		elseif typ == "StringValue" then
			if siz then obj.Value = siz end
		elseif typ == "Part" then
			if siz then	obj.Size = siz end
			if pos then obj.Position = pos end
			if ext then obj.Color3 = ext end
		elseif typ == "MeshPart" then
			if siz then obj.Size = siz end
			if pos then obj.Position = pos end
			if ext then obj.MeshId = ext end
		elseif typ == "Frame" then
			if siz then obj.Size = siz end
			if pos then obj.Position = pos end
			if ext[1] then obj.BackgroundTransparency = ext end
			if ext[2] then obj.Visible = false end
		elseif typ == "TextLabel" then
			if siz then obj.Size = siz end
			if pos then obj.Position = pos end
			if ext[1] then obj.Text = ext[1] end
			if ext[2] then obj.TextSize = ext[2] end
			if ext[3] then obj.TextColor3 = ext[3] end
			if ext[4] then obj.Font = ext[4] end
		end
	end
	
	return obj
end



return c
