-- Create Library & Window
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Winston Hub | Magnet Simulator", "Midnight")

-- Create Tab
local FarmTab = Window:NewTab("Farming")
local MiscTab = Window:NewTab("Misc")

-- Create Section
local FarmSection = FarmTab:NewSection("Farming Section")
local RebirthSection = FarmTab:NewSection("Rebirth Section")
-- Misc
local MiscSection = MiscTab:NewSection("Misc Section")
local PlayerSection = MiscTab:NewSection("Player Section")

FarmSection:NewToggle("Auto Coin", "ToggleInfo", function(v)
	AutoCoin = v
end)

FarmSection:NewToggle("Auto Sell", "ToggleInfo", function(v)
	AutoSell = v
end)

FarmSection:NewToggle("Auto Clover", "ToggleInfo", function(v)
	AutoClover = v
end)

RebirthSection:NewDropdown("Select Rebirth Amount", "DropdownInf", {"1","5","25","50","100","250","500","1000","2500","5000","10000","25000","50000","75000","100000","125000","200000"}, function(v)
	Rebirth = tonumber(v)
end)

RebirthSection:NewToggle("Auto Rebirth", "ToggleInfo", function(v)
	AutoRebirth = v
end)

MiscSection:NewButton("Disable Notification", "ButtonInfo", function()
	game:GetService("Players").LocalPlayer.PlayerGui.GameHUD.FullBackpack:Destroy() 
end)

PlayerSection:NewSlider("WalkSpeed", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

PlayerSection:NewSlider("JumpPower", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

PlayerSection:NewButton("Rejoin", "ButtonInfo", function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
end)

PlayerSection:NewButton("Serverhop", "ButtonInfo", function()
	while task.wait() do
		local Servers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
		for i,v in pairs(Servers.data) do
			if v.id ~= game.JobId then
				task.wait()
				game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
			end
		end
	end
end)

PlayerSection:NewButton("Serverhop Low Server", "ButtonInfo", function()
	while task.wait() do
		local Servers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
		for i,v in pairs(Servers.data) do
			if v.id ~= game.JobId and v.playing <= 3 then
				task.wait()
				game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
			end
		end
	end
end)

spawn(function()
	while wait() do
		if AutoCoin then
			local args = {
				[1] = "6080000000",
				[2] = game:GetService("ReplicatedStorage").Tools["Lucky Long Tri-Magnet"]
			}
			game:GetService("ReplicatedStorage").Events.MagnetEvents.requestGrab:FireServer(unpack(args))
			wait()
		end
	end
end)

spawn(function()
	while wait() do
		if AutoSell then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-419.514709, 5.21380043, -849.897949) + Vector3.new(1, 1, 0)
		end
	end
end)

spawn(function()
	while wait() do
		if AutoRebirth then
			local args = {
				[1] = Rebirth
			}
			game:GetService("ReplicatedStorage").RebirthEvents.requestRebirth:InvokeServer(unpack(args))
			wait()
		end
	end
end)

spawn(function()
	while wait() do
		if AutoClover then
			local args = {
				[1] = "Clover1",
				[2] = game.ReplicatedStorage.Tools['Lucky Long Tri-Magnet']
			}

			game:GetService("ReplicatedStorage").Events.MagnetEvents.requestGrab:FireServer(unpack(args))
			wait()
		end
	end
end)
