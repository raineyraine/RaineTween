--- Services
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--- Constants
local REMOTE: RemoteFunction = ReplicatedStorage:WaitForChild("TweenModuleRemote")
local LOCAL_PLAYER = Players.LocalPlayer

--- Variables
local Tweens = { }

--- Functions
local FUNCTIONS = {
	["/Tween/CreatePV/"] = function(Data)
		local PVInstance: PVInstance = Data.PVInstance
		local CFrameValue = Instance.new("CFrameValue")
		CFrameValue.Value = PVInstance:GetPivot()
		
		local Tween = TweenService:Create(CFrameValue, TweenInfo.new(table.unpack(Data.TweenInfo)), {Value = Data.CFrame})
		
		print(Tween.TweenInfo)
		print(Data.TweenInfo)
		
		Tweens[Data.TweenId] = Tween
	
		
		local Connection = CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
			PVInstance:PivotTo(CFrameValue.Value)
		end)
		
		if Data.Cleanup then
			Tween.Completed:Once(function()
				CFrameValue:Destroy()
				Tween:Destroy()
				Connection:Disconnect()
			end)
		end
		
		Tween.Destroying:Once(function()
			CFrameValue:Destroy()
			Connection:Disconnect()
		end)
		
		return "MadePVTween"
	end,
	
	["/Tween/Play/"] = function(Data)
		local Tween: Tween = Tweens[Data.TweenId]
		
		Tween:Play()
		
		return "PlayedTween"
	end,
	
	["/Tween/Cancel/"] = function(Data)
		local Tween: Tween = Tweens[Data.TweenId]

		Tween:Cancel()

		return "CanceledTween"
	end,
	
	["/Tween/Pause/"] = function(Data)
		local Tween: Tween = Tweens[Data.TweenId]

		Tween:Pause()

		return "PausedTween"
	end,
	
	["/Tween/Destroy/"] = function(Data)
		local Tween: Tween = Tweens[Data.TweenId]

		Tween:Destroy()

		return "DestroyedTween"
	end,
}


--- Script
REMOTE.OnClientInvoke = function(package)
	if package.Recipient ~= LOCAL_PLAYER then print("invalid") return "InvalidPlayer" end
	
	local Response = FUNCTIONS[package.Message](package.Data)
	
	return Response
end
