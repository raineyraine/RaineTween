--- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--- Functions
local function SendPackage(package: { }, recipient: Player): nil
	local Remote: RemoteFunction = ReplicatedStorage:FindFirstChild("TweenModuleRemote")
	
	if package.Recipient ~= recipient then return "InvalidPlayer" end
	
	local Success, Result = pcall(function()
		Remote:InvokeClient(recipient, package)
	end)
	
	return Success, Result
end
	
local function TableFromTweenInfo(tweenInfo: TweenInfo): { }
	return {
		[1] = tweenInfo.Time,
		[2] = tweenInfo.EasingStyle,
		[3] = tweenInfo.EasingDirection,
		[4] = tweenInfo.RepeatCount,
		[5] = tweenInfo.Reverses,
		[6] = tweenInfo.DelayTime
	}
end

--- Module
local RaineTween = {}

function RaineTween:PVTween(pvInstance: PVInstance, tweenInfo: TweenInfo | { }, tgp: PVInstance | CFrame, cleanup: boolean?)	
	local Id = tostring(os.clock())
	local To = nil
	if typeof(tgp) == "CFrame" then
		To = tgp
	elseif typeof(tgp) == "PVInstance" then
		To = tgp:GetPivot()
	else
		error("Invalid tgp")
	end
	
	local Info = nil
	Info = TableFromTweenInfo(tweenInfo)
	--[[if typeof(tweenInfo) == "TweenInfo" then
		Info = TableFromTweenInfo(tweenInfo)	
	else
		Info = tweenInfo
	end]]--
	
	local Returned = {
		TweenId = Id
	}
	
	function Returned:Play()
		local Package = { }
		Package.Recipient = nil
		Package.Message = "/Tween/Play/"
		Package.Data = {
			TweenId = self.TweenId
		}
		
		for _, Player: Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				Package.Recipient = Player

				SendPackage(Package, Player)
			end)
		end
	end
	
	function Returned:Pause()
		local Package = { }
		Package.Recipient = nil
		Package.Message = "/Tween/Pause/"
		Package.Data = {
			TweenId = self.TweenId
		}
		
		for _, Player: Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				Package.Recipient = Player

				SendPackage(Package, Player)
			end)
		end
	end
	
	function Returned:Cancel()
		local Package = { }
		Package.Recipient = nil
		Package.Message = "/Tween/Cancel/"
		Package.Data = {
			TweenId = self.TweenId
		}
		
		for _, Player: Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				Package.Recipient = Player

				SendPackage(Package, Player)
			end)
		end
	end
	
	function Returned:Destroy()
		local Package = { }
		Package.Recipient = nil
		Package.Message = "/Tween/Destroy/"
		Package.Data = {
			TweenId = self.TweenId
		}
		
		for _, Player: Player in pairs(Players:GetPlayers()) do
			task.spawn(function()
				Package.Recipient = Player

				SendPackage(Package, Player)
			end)
		end
		
		Returned = nil
	end
	
	local Package = { }
	Package.Recipient = nil
	Package.Message = "/Tween/CreatePV/"
	Package.Data = {
		PVInstance = pvInstance,
		CFrame = To,
		TweenInfo = Info,
		TweenId = nil,
		Cleanup = cleanup
	}
	
	for _, Player: Player in pairs(Players:GetPlayers()) do
		task.spawn(function()
			Package.Recipient = Player
			Package.Data.TweenId = Id

			SendPackage(Package, Player)
		end)
	end
	
	return Returned
end

function RaineTween:Tween(pvInstance: PVInstance, tweenInfo: TweenInfo | { }, tgp: PVInstance | CFrame)
	
end

return function()
	local RemoteFunction = ReplicatedStorage:FindFirstChild("TweenModuleRemote")
	if not RemoteFunction then
		RemoteFunction = Instance.new("RemoteFunction")
		RemoteFunction.Name = "TweenModuleRemote"
		RemoteFunction.Parent = ReplicatedStorage
	end
	
	return RaineTween, RemoteFunction
end
