repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isTriple = "Single"

function GetNearestEgg()
	local nearr = math.huge
	local near
	local plr = Player.Character.HumanoidRootPart

	for i, v in pairs(game:GetService("Workspace").Scripts.Eggs:GetChildren()) do
		if (plr.CFrame.p - v.Egg.Egg.CFrame.p).Magnitude < nearr then
			near = v.Name
			nearr = (plr.CFrame.p - v.Egg.Egg.CFrame.p).Magnitude
		end
	end
	return near
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Winston Hub | Rebirth Champion X", "Midnight")

-- Create Tab
local FarmTab = Window:NewTab("Farming")
local PetsTab = Window:NewTab("Pet")
local TeleportTab = Window:NewTab("Teleport")
local MiscTab = Window:NewTab("Misc")

-- Create Section
-- Farm Tab
local FarmSection = FarmTab:NewSection("Farming Section")
local GamepassSection = FarmTab:NewSection("Gamepass Section")
-- Pets Tab
local PetsSection = PetsTab:NewSection("Pets Section")
local EquipCraftSection = PetsTab:NewSection("Equip Best & Craft All Section")
-- Teleport Tab
local TeleportSection = TeleportTab:NewSection("Teleport Section")
-- Misc Tab
local MiscSection = MiscTab:NewSection("Misc Section")
local PlayerSection = MiscTab:NewSection("Player Section")

FarmSection:NewToggle("Auto Click", "ToggleInfo", function(v)
	_G.autoclick = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoclick then break end
			ReplicatedStorage.Events.Click3:FireServer()
		end
	end)
end)

GamepassSection:NewButton("Unlock Gamepass", "ButtonInfo", function()
	for i, v in pairs(Player.Passes:GetChildren()) do
		v.Value = true
	end
end)

PetsSection:NewToggle("Auto Open Nearest Egg", "ToggleInfo", function(v)
	_G.autoegg = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoegg then break end    
			local eggy = GetNearestEgg() 
			ReplicatedStorage.Functions.Unbox:InvokeServer(eggy,isTriple)
		end
	end)
end)

PetsSection:NewToggle("Triple Egg", "ToggleInfo", function(v)
	asd = v

	if asd then
		isTriple = "Triple"
	else
		isTriple = "Single"
	end
end)

EquipCraftSection:NewToggle("Equip Best (10 Second)", "ToggleInfo", function(v)
	_G.autobest = v

	task.spawn(function()
		while task.wait(10) do
			if not _G.autobest then break end
			firesignal(Player.PlayerGui.MainUI.PetsFrame.Additional.EquipBest.Click.MouseButton1Up)
		end
	end)
end)

EquipCraftSection:NewToggle("Craft All (3 Second)", "ToggleInfo", function(v)
	_G.autocraft = v

	task.spawn(function()
		while task.wait(3) do
			if not _G.autocraft then break end
			firesignal(Player.PlayerGui.MainUI.PetsFrame.Additional.CraftAll.Click.MouseButton1Up)
		end
	end)
end)

for i, v in pairs(game:GetService("Workspace").Scripts.TeleportTo:GetChildren()) do
	TeleportSection:NewButton(v.Name, "ButtonInfo", function()
			Player.Character.HumanoidRootPart.CFrame = v.CFrame
			ReplicatedStorage.Events.WorldBoost:FireServer(v.Name)
	end)
end

MiscSection:NewButton("Hide Error", "ButtonInfo", function()
	Player.PlayerGui.MainUI.Error:Destroy()
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
