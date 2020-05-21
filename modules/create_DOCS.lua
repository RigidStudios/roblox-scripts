-- Made by RigidStudios

c.new(typ, par, nam, siz, pos, ext)
  -- Creates a new object
    -- typ (Type) = string
      options = {
        "IntValue",
        "BoolValue",
        "StringValue",
        "Part",
        "MeshPart",
        "Frame",
        "TextLabel"
      }
    -- par (Parent) = object
    -- siz (Size) = any
      options = {
        IntValue = "int",
        BoolValue = "bool",
        StringValue = "string",
        Part = "Vector3",
        Meshpart = "Vector3",
        Frame = "UDim2",
        TextLabel = "UDim2"
      }
    -- pos (Position) = 

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
