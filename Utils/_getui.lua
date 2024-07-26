--// run service to detect the PlayerGui or StarterGui
local runService = game:GetService("RunService")

--// main
function _getui()
	local IsStudio = runService:IsStudio()
	local IsServer = runService:IsServer()
	local IsClient = runService:IsClient()

	local CurrentGui = (IsStudio == true and game:GetService("StarterGui") or (IsClient == true and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") or game:GetService("StarterGui")))
	return CurrentGui

end

return _getui
