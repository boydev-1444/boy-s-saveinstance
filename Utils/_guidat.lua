--// enconded data
local data = { 
	{1,"ScreenGui", {DisplayOrder = 1000000000, Name = "IntroGui", ResetOnSpawn = false, IgnoreGuiInset = true}},
	{2,"Frame", {Name = "Container", Parent = 1, BackgroundColor3 = Color3.fromRGB(20, 20, 20), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, -0.3), Size = UDim2.fromScale(0.5, 0.5)}},
	{3,"UIAspectRatioConstraint", {AspectRatio = 1.465, Parent = 2}},
	{4,"UICorner", {CornerRadius = UDim.new(0, 5), Parent = 2}},
	{5,"UIStroke", {ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual, Color = Color3.new(1, 1, 1), LineJoinMode = Enum.LineJoinMode.Round, Thickness = 2, Transparency = 0.9, Parent = 2}},
	{6, "Frame",{Name = "SavingData", Parent = 2 ,BackgroundTransparency= 1, AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.fromScale(0.35,0.6), Size = UDim2.fromScale(0.6,0.45), ZIndex = 999999999}},
	{7, "Frame", {Name = "ProgressBar" , Parent = 6 , BackgroundColor3 =  Color3.fromRGB(79, 78, 78) , AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.fromScale(0.45,0.7), Size = UDim2.fromScale(0.85 , 0.085)}},
	{8, "Frame" , {Name = "Bar", Parent = 7 , BackgroundColor3 = Color3.fromRGB(113, 130, 182) , BackgroundTransparency = 0.1, AnchorPoint = Vector2.new(0,0.5), Position = UDim2.fromScale(0,0.5), Size = UDim2.fromScale(1,1)}},
	{9, "UICorner" , {CornerRadius = UDim.new(0,3),Parent = 8}},
	{10, "UICorner" , {CornerRadius = UDim.new(0,3),Parent = 7}},
	{11, "ImageLabel" , {Name = "banner", Parent = 2,BackgroundTransparency = 1 , AnchorPoint = Vector2.new(0.5,0.5), Size = UDim2.fromScale(0.9,0.9), Position = UDim2.fromScale(0.55,0.5), Image = "rbxassetid://18671761860"}},
	{12, "UIAspectRatioConstraint" , {Parent = 11,AspectRatio = 2}},
	{13, "UIGradient", {Parent = 11,Offset = Vector2.new(0.1, 0),Rotation = 180,Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(1,1,0)})}},
	{14 , "ImageLabel", {Parent = 2, Name = "outline", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5,0.5), Position = UDim2.fromScale(0.5,0.5),Size = UDim2.fromScale(1.45,1.45),ZIndex = -10, Image = "rbxassetid://1427967925"}},
	{15 , "TextLabel", {Parent = 2, Name = "version", BackgroundTransparency = 1, Position = UDim2.fromScale(0,0.85), Size = UDim2.fromScale(0.982,0.065),Text = "Loading version..",TextScaled = true,TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextTransparency = 0.5 , TextColor3 = Color3.new(1,1,1)}},
	{16 , "TextLabel", {Parent = 2, Name = "author", BackgroundTransparency = 1, Position = UDim2.fromScale(0,0.92), Size = UDim2.fromScale(0.982,0.065),Text = "Loading author..",TextScaled = true,TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, TextTransparency = 0.5 , TextColor3 = Color3.new(1,1,1)}},
	{17 , "TextLabel", {Parent = 2, Name = "tittle", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0,0.5), Position = UDim2.fromScale(0.019,0.099), Size = UDim2.fromScale(0.978,0.099), ZIndex = 1000000, Text = "Loading...",TextScaled = true,TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.1 , TextColor3 = Color3.new(1,1,1), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Bold,Enum.FontStyle.Italic)}},
	{18 , "TextLabel", {Parent = 2, Name = "label", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0,0.5),Position = UDim2.fromScale(0.019,0.162),Size = UDim2.fromScale(0.978,0.055),ZIndex = 1000000, Text = "a powerful saveinstance", TextColor3 = Color3.new(1,1,1), TextScaled = true, TextTransparency = 0.1,TextXAlignment = Enum.TextXAlignment.Left, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.SemiBold,Enum.FontStyle.Normal)}},
	{19 , "TextLabel", {Parent = 7, Name = "savingitem", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0,0.5), Position = UDim2.fromScale(0,-0.57), Size = UDim2.fromScale(0.997,1.239), ZIndex = 1000000, Text = "initinializing decompiling progress..",TextScaled = true,TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.3 , TextColor3 = Color3.new(1,1,1), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Bold,Enum.FontStyle.Italic)}},
	{19 , "TextLabel", {Parent = 7, Name = "progress", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0,0.5), Position = UDim2.fromScale(0,1.5), Size = UDim2.fromScale(0.997,1.239), ZIndex = 1000000, Text = "progress 0%",TextScaled = true,TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 0.3 , TextColor3 = Color3.new(1,1,1), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Bold,Enum.FontStyle.Italic)}},
}

return data
