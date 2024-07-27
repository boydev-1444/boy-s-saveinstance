--// boy's saveinstance gui

local function doesExist(parent, str)
	local ok , item = pcall(function()
		return parent[str]
	end)

	return (ok == true and item or nil)
end


function load(data,currentGui)
	local parentMap = {}
	for i, info in pairs(data) do
		local index = info[1]
		local className = info[2]
		local properties = info[3]

		local item = Instance.new(className)
		for property, value in pairs(properties) do
			if property ~= "Parent" then
				item[property] = value
			end
		end

		if properties.Parent then
			item.Parent = parentMap[properties.Parent]

		else
			item.Parent = currentGui
		end

		parentMap[index] = item
	end
end

function newgui(currentGui,data)
	if currentGui then
		if doesExist(currentGui , "IntroGui") then
			currentGui.IntroGui:Destroy()
		end
		
		if not doesExist(currentGui , "IntroGui") then		
			load(data,currentGui)
		end
	else
		warn("Attempt to create gui when currentGui is nil")
	end
end

return newgui
