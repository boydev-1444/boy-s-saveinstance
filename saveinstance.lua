--[[
██████╗░░█████╗░██╗░░░██╗██╗░██████╗
██╔══██╗██╔══██╗╚██╗░██╔╝╚█║██╔════╝
██████╦╝██║░░██║░╚████╔╝░░╚╝╚█████╗░
██╔══██╗██║░░██║░░╚██╔╝░░░░░░╚═══██╗
██████╦╝╚█████╔╝░░░██║░░░░░░██████╔╝
╚═════╝░░╚════╝░░░░╚═╝░░░░░░╚═════╝░

░██████╗░█████╗░██╗░░░██╗███████╗██╗███╗░░██╗░██████╗████████╗░█████╗░███╗░░██╗░█████╗░███████╗
██╔════╝██╔══██╗██║░░░██║██╔════╝██║████╗░██║██╔════╝╚══██╔══╝██╔══██╗████╗░██║██╔══██╗██╔════╝
╚█████╗░███████║╚██╗░██╔╝█████╗░░██║██╔██╗██║╚█████╗░░░░██║░░░███████║██╔██╗██║██║░░╚═╝█████╗░░
░╚═══██╗██╔══██║░╚████╔╝░██╔══╝░░██║██║╚████║░╚═══██╗░░░██║░░░██╔══██║██║╚████║██║░░██╗██╔══╝░░
██████╔╝██║░░██║░░╚██╔╝░░███████╗██║██║░╚███║██████╔╝░░░██║░░░██║░░██║██║░╚███║╚█████╔╝███████╗
╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░╚════╝░╚══════╝[[
█▀ █▀█ █░█ █▀█ █▀▀ █▀▀
▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄
]]

local tweenService = game:GetService("TweenService");
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService");
local coreGui = game:GetService("CoreGui");


function Loadstring(string , js)
	if js then
		return httpService:JSONDecode(string)
	end
	return loadstring(string)()
end

function HttpGet(URL , IsJSON)
	local data = ((runService:IsStudio() == true or runService:IsClient() == true) and httpService:GetAsync(URL) or game:HttpGet(URL))
	local string = Loadstring(data,IsJSON)
	return string
end 

local function formatversion(number)
	local numberStr = tostring(number)
	if #numberStr > 1 then
		return tonumber(numberStr:sub(1, -2) .. "." .. numberStr:sub(-1))
	else
		return tonumber(numberStr .. ".0")
	end
end


local Main = {
  Utils = {
		getui = HttpGet("https://github.com/boydev-1444/boy-s-saveinstance/raw/main/Utils/_getui.lua"),
		settings = HttpGet("https://github.com/boydev-1444/boy-s-saveinstance/raw/main/settings.json",true),
		guiInfo = HttpGet("https://github.com/boydev-1444/boy-s-saveinstance/raw/main/Utils/_guidat.lua"),
		loadGui = HttpGet("https://github.com/boydev-1444/boy-s-saveinstance/raw/main/Utils/_loadgui.lua"),
  },
  
  DefaultDecompiler = HttpGet("https://github.com/boydev-1444/boy-s-saveinstance/raw/main/default_decompiler.lua"),
}

local SaveServices = {
	"Workspace",
	"Lighting",
	"ReplicatedFirst",
	"ReplicatedStorage",
	"StarterGui",
	"StarterPack",
	"StarterPlayer",
	"Teams",
	"Chat",
	"TextChatService",
	"MaterialService",
}

local Utils = Main.Utils

function doesExist(parent, str)
	local ok , item = pcall(function()
		return parent[str]
	end)

	return (ok == true and item or nil)
end

local GlobalOptions = {
	["Decompile"] = true,
	["CustomDecompilerURL"] = nil,
	["RemovePlayerCharacters"] = false,
	["SavePlayers"] = true,
	["LoadAttributes"] = true,
	["LoadTags"] = true,
	["IgnoreProperties"] = {
		"UniqueId",
	},
	["IgnoreServices"] = {
		"TextChatService","Chat"
	},
	["NilInstances"] = true,
	["ReadMe"] = true,
	["IngnoreNotArchivable"] = true,
}


local function GetExactTime()
	local t = tick()
	local date = os.date("*t", t)
	local milliseconds = (t % 1) * 1000
	return string.format("%02d:%02d:%02d.%03d", date.hour, date.min, date.sec, milliseconds)
end

function canbeInstanced(classname)
	return pcall(function()
		Instance.new(classname)
	end)
end

local function getAPIData()
	local retries = 0
	local success, data

	while retries < 3 do
		success, data = pcall(function()
			return (runService:IsStudio() == true and httpService:GetAsync("https://anaminus.github.io/rbx/json/api/latest.json") or game:HttpGet("https://anaminus.github.io/rbx/json/api/latest.json"))
		end)

		if success and data then
			return httpService:JSONDecode(data)
		end

		retries = retries + 1
		task.wait(1)
	end

	return nil
end

local Classes = {}
local HttpData = getAPIData()

local function getProperties(className)
	if not HttpData or type(HttpData) ~= "table" then
		return nil
	end

	for _, Table in ipairs(HttpData) do
		local Type = Table.type

		if Type == "Class" then
			local ClassData = {}
			local Superclass = Classes[Table.Superclass]

			if Superclass then
				for j = 1, #Superclass do
					ClassData[j] = Superclass[j]
				end
			end

			Classes[Table.Name] = ClassData
		elseif Type == "Property" then
			if not next(Table.tags) then
				local Class = Classes[Table.Class]
				if Class then
					local Property = Table.Name
					local Inserted = false

					for j = 1, #Class do
						if Property < Class[j] then
							Inserted = true
							table.insert(Class, j, Property)
							break
						end
					end

					if not Inserted then
						table.insert(Class, Property)
					end
				end
			end
		end
	end

	return Classes[className]
end


local function cap(str)
	return string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2)
end

function propertiesMain(originalChild, clonedChild)
	local properties = getProperties(originalChild.ClassName)
	
	if properties then
		for _ , propertyName in pairs(properties) do
			if doesExist(clonedChild , propertyName) then
				if propertyName ~= "Parent" then
					clonedChild[propertyName] = originalChild[propertyName]
				end
			end
		end
	end
end

Main.Init = function(Options)
	if Options == nil then
		Options = GlobalOptions
	end
	
	local CurrentGui , SaveinstanceSettings , StartTime, CurrentAction , SavingItem , Progress , TotalItems , SavedItems
	
	repeat wait() until game:IsLoaded()
	
	CurrentGui = Utils.getui()
	SaveinstanceSettings = Utils.settings
	StartTime = tick()
	CurrentAction = "Loading"
	Progress = 0
	SavingItem = ""
	TotalItems = 0
	SavedItems = 0
	
	print(("Starting %s"):format(SaveinstanceSettings.Name))
	Utils.loadGui(CurrentGui,Utils.guiInfo)
	local saveinsanceGui = coreGui:FindFirstChild("IntroGui")
	local container = saveinsanceGui:WaitForChild("Container")
	
	local ProgressThread = task.spawn(function()
		while true do
			if container then
				local savingData = container:FindFirstChild("SavingData")
				if savingData then
					local progressBar = savingData:FindFirstChild("ProgressBar")
					if progressBar then
						local bar = progressBar:FindFirstChild("Bar")
						if bar then
							local size = UDim2.fromScale(
								TotalItems / SavedItems
								,
								1
							)
							bar.Size = size
						end
						
						if progressBar:FindFirstChild("savingitem") then
							progressBar.savingitem.Text = CurrentAction.." "..SavingItem
						end
						if progressBar:FindFirstChild("progress") then
							progressBar.progress.Text = ("progress: %s"):format(tostring(Progress).."%")
						end
					end
				end
			end
			
			
			
			task.wait()
		end
	end)
	
	
	container.tittle.Text = Utils.settings.Name
	container.version.Text = ("%s: %s"):format(Utils.settings.Type,formatversion(Utils.settings.Version))
	container.author.Text = ("Created by %s"):format(Utils.settings.Creator)
	container:WaitForChild("SavingData"):WaitForChild("ProgressBar"):WaitForChild("Bar").Size = UDim2.fromScale(0,1)
	tweenService:Create(container,TweenInfo.new(0.75,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false),{Position = UDim2.fromScale(0.5,0.5)}):Play()
	
	local fakeFile = Instance.new("Model",game.ServerStorage)
	fakeFile.Name = game:GetFullName()
	
	CurrentAction = "Getting services"
	SavingItem = ""
	
	local log = Instance.new("LocalScript",fakeFile)
	log.Name = "Logs"
	log.Source = "--[[\n--// boy's saveinstance log \n\n"
	
	local function addToLog(message)
		local time = GetExactTime()
		log.Source = log.Source..("-- %s : %s\n"):format(time,message)
	end
	
	local function scriptFunction(newscript , originalSource)
		local decomp , result = pcall(function()
			local source = (Options.CustomDecompilerURL ~= nil and HttpGet(Options.CustomDecompilerURL)(originalSource) or Main.DefaultDecompiler(originalSource))
			return source
		end)
		pcall(function()
			newscript.Source = (decomp == true and ("--// Decompiled with boy's saveinstance unluau decompiler \n%s"):format(result) or ("--// Failed to decompile \nReason:%s"):format(result))
		end)
	end
	
	local function childFunction(originalItem , parent)
		
		
		local children = originalItem:GetChildren()
		
		if #children < 1 then return end
		for _ , item in pairs(children) do
			if item then
				local clonedItem = Instance.new(canbeInstanced(item.ClassName) == true and item.ClassName or "Folder")
				propertiesMain(item , clonedItem)
				clonedItem.Parent = parent
				clonedItem.Name = item.Name
				if item:IsA'LuaSourceContainer' then
					scriptFunction(clonedItem , item.Source)
					CurrentAction = "Decompiling"
				else
					CurrentAction = "Saving"
				end
				SavingItem = item.Name
				addToLog(("%s item %s to %s"):format(CurrentAction:lower(),item.Name,parent.Name))
				childFunction(item , clonedItem)
			end
			task.wait()
		end
	end
	
	
	task.wait(1)
	
	--// save main
	
	for _ , service in pairs(SaveServices) do
		if doesExist(game , service) then
			local realService = game[service]
			addToLog("Getting "..service.." descendants")
			local descdentants = realService:GetDescendants()
			addToLog("Counted all "..service.." descendants")
			
			local fakeService = Instance.new("Folder",fakeFile)
			fakeService.Name = service
			propertiesMain(realService , fakeService)
			
			TotalItems = TotalItems + #descdentants
		end
	end
	
	addToLog("Saving "..tostring(TotalItems).." instances")
	
	for _ , service in pairs(SaveServices) do
		if doesExist(game , service) then
			local realService = game:GetService(service) or game:FindFirstChild(service)
			local descendants = realService:GetDescendants()
			
			if #descendants>0 then
				addToLog(("saving instances %s of %s"):format(#descendants,service))
				
				for _ , child in pairs(realService:GetChildren()) do
					local success , errormsg = pcall(function()
						local clonedChild = Instance.new(canbeInstanced(child.ClassName) == true and child.ClassName or "Folder")
						clonedChild.Name = child.Name
						propertiesMain(child , clonedChild)
						clonedChild.Parent = fakeFile:FindFirstChild(service)
						if child:IsA'LuaSourceContainer' then
							scriptFunction(clonedChild , child.Source)
							CurrentAction = "Decompiling"
						else
							CurrentAction = "Saving"
						end
						addToLog(("%s item %s to %s"):format(CurrentAction:lower(),child.Name,realService.Name))
						SavingItem = child.Name
						childFunction(child , clonedChild)
					end)
					
					task.wait()
					if not success then
						addToLog(("%s item cannot be saved \n reason: (%s)\n"):format(child.Name,errormsg))
					end
				end
				
			else
				addToLog(("%s descendants is empty"):format(service))
			end
		else
			addToLog(("%s service doesn't exists"):format(service))
		end
	end
	
	local finishTime = tick()
	addToLog(("Saved %s in %s seconds"):format(game:GetFullName() , string.format("%.2f",finishTime-StartTime)))
	log.Source = log.Source.."\n]]"
	saveinstance(httpService:GenerateGUID()..game.PlaceId,fakeFile)
	print("Completed boy's saveinstance progress")

	wait(2)
	local tweenDissapear = tweenService:Create(container,TweenInfo.new(0.75,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false),{Position = UDim2.fromScale(0.5,-0.3)})
	tweenDissapear.Completed:Connect(function()
		saveinsanceGui:Destroy()
	end)
	tweenDissapear:Play()
end



return Main.Init()
