local TextProcessor = {};

TextProcessor.Patterns = {
	tagPattern = {"<(.-)>", "</(!)>"};
};

TextProcessor.Features = {
	["hl"] = {"b", "font color='rgb(218,165,32)'"};
}

function TextProcessor.specialConcat(tab, joinStr: string)
	local str = "";
	for i, addText in pairs(tab) do
		str += addText:split(" ")[1] + (i < #tab and joinStr or "");
	end;
	return str;
end

function TextProcessor:Make(text: string, index: number): string
	local isTag;
	
	if index and index > 0 then 		-- To be sliced
		text, isTag = self:SimpleSlice(text, index);
	end;
	
	-- FEATURES
	for used, template in pairs(self.Features) do
		local feature = "<" + table.concat(template, "><") + ">";
		text = text:gsub("<" + used + ">", feature); -- Add Opening tags for 'used'
		local featureCloser = "<" + self.specialConcat(template, "><") + ">";
		text = text:gsub("</" + used + ">", featureCloser); -- Add Closing tags for 'used'
	end;
	
	return text, isTag;
end;

-- Used for ordered tag closing.
function reverseTab(tab)
	local rev = {};
	for i=#tab, 1, -1 do
		rev[#rev+1] = tab[i];
	end;
	return rev;
end;

function TextProcessor.firstWord(text)
	return text:split(" ")[1];
end

function TextProcessor:SimpleSlice(text, index)
	local unclosedTags = {};
	local chars = text:sub(1, index):split("");
	local tagIsOpening = false;
	local tagIsClosing = false;
	local unclosedTag = "";
	local closedTag = "";

	local str = "";

	for p, char in pairs(chars) do
		if char == "<" and chars[p + 1] ~= "/" then -- Tag opening opening.
			tagIsOpening = true;
		elseif char == ">" and tagIsOpening then -- Tag opening closing.
			tagIsOpening = false;
			table.insert(unclosedTags, unclosedTag);
			unclosedTag = "";
		elseif tagIsOpening then -- Tag is opening.
			unclosedTag ..= char;
		elseif char == "<" and chars[p + 1] == "/" then -- Tag closing opening.
			tagIsClosing = true;
		elseif char == ">" and tagIsClosing then -- Tag closing closing.
			tagIsClosing = false;
			table.remove(unclosedTags, table.find(unclosedTags, closedTag))
		elseif tagIsClosing then -- Tag is closing.
			closedTag ..= char;
		end;

		str ..= char;
	end;


	if tagIsOpening then
		table.insert(unclosedTags, unclosedTag ~= "" and unclosedTag or "unfinished");
		
		local unclosedDifference = #unclosedTag - #self.firstWord(unclosedTag)
		
		if unclosedTag == "" then
			str ..= "unfinished";
		elseif unclosedDifference > 0 then
			str = str:sub(1, #str - unclosedDifference)
		end
		str ..= ">";
	end;

	for i, v in pairs(reverseTab(unclosedTags)) do
		-- Close any remaining tags in the correct order.
		str ..= "</" .. self.firstWord(v) .. ">";
	end;

	return str, tagIsOpening or tagIsClosing;
end;

-- object: object to affect, by default uses 'Text' property.
-- text: text to typewrite
-- prop: override 'object' property affected.
function TextProcessor:Typewriter(object, text: string, config: {prop: string?; length: number?})
	config = config or {}; -- Save on an if statement.
	for i = 1, #text do
		local sliced, inTag = self:Make(text, i);
		object[config.prop or "Text"] = sliced;
		
		if not inTag then
			wait(config.length or .04);
		end;
	end;
end;

return TextProcessor;
