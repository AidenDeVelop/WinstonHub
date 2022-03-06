repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Player.Character.HumanoidRootPart
local selectedTree = "1"
local tree = {}

for i, v in pairs(game:GetService("Workspace").TargetStorage:GetChildren()) do
	for i2, v2 in pairs(v:GetChildren()) do
		for i3, v3 in pairs(v2:GetChildren()) do
			if v3:IsA("ClickDetector") and not table.find(tree,'Tree '..v.Name.." HP: "..v3.Max_HP.Value) then
				table.insert(tree,'Tree '..v.Name.." HP: "..v3.Max_HP.Value)
			end
		end
	end
end

table.sort(tree ,function(a,b)
	return tonumber(string.match(a,"%d+")) < tonumber(string.match(b,"%d+"))
end)

local l = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local w = l.CreateLib("Winston Hub | Magic Woodcutter", "Midnight")
local f = w:NewTab("Farming")
local fs = f:NewSection("Farming Section")
local s = w:NewTab("Shop")
local ss = s:NewSection("Shop Section")
local m = w:NewTab("Misc")
local ms = m:NewSection("Misc Section")


fs:NewDropdown("Select Tree", "DropdownInf", tree, function(v)
	selectedTree = string.match(v,"%d+")
end)

fs:NewToggle("Farm Tree", "ToggleInfo", function(v)
	_G.farmwood = v

	task.spawn(function()
		while task.wait() do
			if not _G.farmwood then break end
			pcall(function()
				local plr = Player.Character.HumanoidRootPart
				for i, v in pairs(game:GetService("Workspace").TargetStorage[selectedTree]:GetChildren()) do
					if i == 1 and v:FindFirstChild("CST_CD") then
						fireclickdetector(v["CST_CD"])
					end
				end
			end)
		end
	end)
end)

fs:NewToggle("Auto Sell", "ToggleInfo", function(v)
	_G.autosell = v

	task.spawn(function()
		while task.wait() do
			if not _G.autosell then break end
			pcall(function()
				local plr = Player.Character.HumanoidRootPart
				firetouchinterest(plr,game:GetService("Workspace").Map["Sell_Part"].TouchInterest.Parent,0)
				firetouchinterest(plr,game:GetService("Workspace").Map["Sell_Part"].TouchInterest.Parent,1)
			end)
		end
	end)
end)

ss:NewToggle("Auto Upgrade Axe", "ToggleInfo", function(v)
	_G.axe = v

	task.spawn(function()
		while task.wait(1) do
			if not _G.axe then break end
			ReplicatedStorage.RemoteEvent:FireServer({"Rank_Upgrade_Request"})
		end
	end)
end)

ss:NewToggle("Auto Upgrade Storage", "ToggleInfo", function(v)
	_G.storage = v

	task.spawn(function()
		while task.wait(1) do
			if not _G.storage then break end
			ReplicatedStorage.RemoteEvent:FireServer({"Capacity_Upgrade_Request"})
		end
	end)
end)

ms:NewSlider("WalkSpeed", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

ms:NewSlider("JumpPower", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

ms:NewButton("Rejoin", "ButtonInfo", function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
end)

ms:NewButton("Serverhop", "ButtonInfo", function()
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

ms:NewButton("Serverhop Low Server", "ButtonInfo", function()
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
