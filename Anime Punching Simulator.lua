repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

_G.Settings = {
	autoTap =       false;
	autoRebirth =   false;
	autoPractice =  false;
	autoEgg =       false;
	autoEgg2 =      false;
	autoUpgrade =   false;
	autoRank =      false;
	autoAura =      false;
	autoWorld =     false;
	tripleEgg =     "1";
	autoMaxElite =  false;
	autoMaxDivine = false;
}

local codes = {
	"MEQUIS";"SAO";"80KLIKES";"90KLIKES";"100KLIKES";"130KFAVS";"BRONZERBR";
	"55KLIKES";"22MVISITS";"FAIRY";"OPENSAMU";"55KLIKES";"60KLIKES";"VALENTINE";"65KLIKES";"25MVISITS";"BENTOYT";"100KFAVS";
	"70KLIKES";"KINGISAQT";"PLIQUE";"OPM";"CLOVER";"75KLIKES";"110KFAVS";"JAKEPUDDING";"NECROBR";"JOHNSVEN";"30MVISITS";"HUNTER";
	"70KFAVS";"45KLIKES";"16MVISITS";"HERO";"35KLIKES";"50KFAVS";"10MVISITS";"30KLIKES";"8MVISITS";"BOLINHOBLOX";"25KLIKES";"VAGNERGAMES";
	"15klikes";"4MVisits";"2MVISITS";"10KLIKES";"5KLIKES";"1MVISITS";"MASTER";"500KVISITS";"250kvisits";"80KVISITS";"1KLIKES";"Release";
}

pcall(function()
	game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Error:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.EggAnimation:Destroy()
end)

local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local plr = Player.Character.HumanoidRootPart
local reb = {}
local area = {}
local egg = {}

for i, v in pairs(Player.PlayerGui.Ui.CenterFrame.Rebirths.Frame:GetChildren()) do
	if v:IsA("ImageLabel") and not table.find(reb,v.Price.Text) then
		table.insert(reb,v.Price.Text)
	end
end

for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
	if v.Name == "Practice" and not table.find(area,v.Area.Value.." Boost: "..v.Boost.Value) then
		table.insert(area,v.Area.Value.." Boost: "..v.Boost.Value)
	end
end 

for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
	if v.Name == "EGG" and not table.find(egg,v.Tier.Value) then 
		table.insert(egg,v.Tier.Value)
	end
end

function noclip()
	for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("BasePart") and v.CanCollide == true then
			v.CanCollide = false
		end
	end
end

function teleport(mob)
	Player.Character.HumanoidRootPart.CFrame = mob.CFrame
end


-- Create Library & Window
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Winston Hub | Anime Punching Simulator", "Midnight")

-- Create Tab
local FarmTab = Window:NewTab("Farming")               
local HeroTab = Window:NewTab("Heroes")
local ShopTab = Window:NewTab("Shop")
local TeleportTab = Window:NewTab("Teleport")
local MiscTab = Window:NewTab("Misc")

-- Farm Tab
local FarmSection = FarmTab:NewSection("Farming Section")
local RebirthSection = FarmTab:NewSection("Rebirth Section")
local PracticeSection = FarmTab:NewSection("Practice Section")
-- Hero Tab
local HeroSection = HeroTab:NewSection("Hero Section")
local MaxSection = HeroTab:NewSection("Max ELITE & DIVINE Section")
-- Shop Tab
local ShopSection = ShopTab:NewSection("Shop Section")
-- Teleport Tab
local TeleportSection = TeleportTab:NewSection("Traning Area Section")
local WorldSection = TeleportTab:NewSection("World Section")
-- Misc Tab
local MiscSection = MiscTab:NewSection("Misc Section")
local PlayerSection = MiscTab:NewSection("Player Section")

FarmSection:NewToggle("Auto Tap", "ToggleInfo", function(v)
	_G.Settings.autoTap = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoTap then break end
			ReplicatedStorage.Remotes.TappingEvent:FireServer()
		end
	end)
end)

RebirthSection:NewDropdown("Select Rebirth Amount", "DropdownInf", reb, function(value)
	for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Rebirths.Frame:GetChildren()) do
		if v:IsA("ImageLabel") and v.Price.Text == tostring(value) then
			selectedNum = tonumber(v.Name)
		end
	end
end)

RebirthSection:NewToggle("Auto Rebirth", "ToggleInfo", function(v)
	_G.Settings.autoRebirth = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoRebirth then break end
			ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Rebirths",selectedNum)
		end
	end)
end)

PracticeSection:NewDropdown("Select Practice Area", "DropdownInf", area, function(v)
	selectedArea = string.match(v,"%d+")
end)

PracticeSection:NewToggle("Auto Practice", "ToggleInfo", function(v)
	_G.Settings.autoPractice = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoPractice then break end
			for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
				if v.Name == "Practice" and v.Boost.Value == tonumber(selectedArea) then
					pcall(function() 
						teleport(v)
						repeat task.wait()
							VirtualInputManager:SendKeyEvent(true, "E", false, game) task.wait()
							VirtualInputManager:SendKeyEvent(false, "E", false, game)
						until not _G.Settings.autoPractice
					end)
				end
			end
		end
	end)
end)

HeroSection:NewDropdown("Select Egg", "DropdownInf", egg, function(value)
	for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
		if v.Name == "EGG" and v.Tier.Value == value then 
			selectedEgg = v
		end
	end  
end)

HeroSection:NewToggle("Auto Open Egg v1", "Can't use auto delete", function(v)
	_G.Settings.autoEgg = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoEgg then break end
			plr.CFrame = selectedEgg.CFrame * CFrame.new(0,0,5)
			ReplicatedStorage.Remotes.ClientRemote:InvokeServer("EGG",selectedEgg,_G.Settings.tripleEgg,{})
		end
	end)
end)

HeroSection:NewToggle("Auto Open Egg v2", "Can use auto delete", function(v)
	_G.Settings.autoEgg2 = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoEgg2 then break end
			pcall(function() 
				teleport(selectedEgg)
				repeat task.wait()
					VirtualInputManager:SendKeyEvent(true, "E", false, game) task.wait()
					VirtualInputManager:SendKeyEvent(false, "E", false, game)
					if _G.Settings.tripleEgg == "1" then
						firesignal(Player.PlayerGui.Ui.CenterFrame.BuyEgg.Frame.Buy1.Button.MouseButton1Click)
					elseif _G.Settings.tripleEgg == "2" then
						firesignal(Player.PlayerGui.Ui.CenterFrame.BuyEgg.Frame.Buy3.Button.MouseButton1Click)
					end
				until not _G.Settings.autoEgg2
			end)
		end
	end)
end)

HeroSection:NewToggle("Triple Hatch", "ToggleInfo", function(v)
	lulul = v

	if lulul then
		_G.Settings.tripleEgg = "2"
	else
		_G.Settings.tripleEgg = "1"
	end 
end)

MaxSection:NewToggle("Auto Max Elite", "ToggleInfo", function(v)
	_G.Settings.autoMaxElite = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoMaxElite then break end
			ReplicatedStorage.Remotes.NPCSystem:FireServer(true, "MAXELITE")
		end
	end)
end)

MaxSection:NewToggle("Auto Max Divine", "ToggleInfo", function(v)
	_G.Settings.autoMaxDivine = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoMaxDivine then break end
			ReplicatedStorage.Remotes.NPCSystem:FireServer(true, "MAXDIVINE")
		end
	end)
end)

ShopSection:NewToggle("Auto Buy Upgrades", "ToggleInfo", function(v)
	_G.Settings.autoUpgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoUpgrade then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Upgrades:GetChildren()) do
				if v:IsA("ImageLabel") then
					ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Upgrade",tonumber(v.Name))
				end
			end
		end
	end)
end)

ShopSection:NewToggle("Auto Buy Rank", "ToggleInfo", function(v)
	_G.Settings.autoRank = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoRank then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Ranks:GetChildren()) do
				if v:IsA("ImageLabel") then
					ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Ranks",tonumber(v.Name))
				end
			end
		end
	end)
end)
ShopSection:NewToggle("Auto Buy Aura", "ToggleInfo", function(v)
	_G.Settings.autoAura = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoAura then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Auras.Frame:GetChildren()) do
				if v:IsA("ImageLabel") then
					ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Auras",tonumber(v.Name))
				end
			end
		end
	end)
end)

ShopSection:NewToggle("Auto Buy World", "ToggleInfo", function(value)
	_G.Settings.autoWorld = value

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoWorld then break end
			for i, v in pairs(game:GetService("Workspace")["__SETTINGS"]["__AREAS"]:GetChildren()) do
				ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Areas",v.Name)
			end
		end
	end)
end)

ShopSection:NewToggle("Auto Buy Grimoire", "ToggleInfo", function(v)
	_G.Settings.autoGrimoire = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoGrimoire then break end
			ReplicatedStorage.Remotes.ClientRemote:InvokeServer("GRIMOIRE")
		end
	end)
end)

for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
	if v.Name == "Part" and v:FindFirstChild("Gui") and v.Gui:FindFirstChild("Info") then
		TeleportSection:NewButton(v.Gui.Info.Text, "", function()
			teleport(v)
		end)
	end
end

for i, v in pairs(game:GetService("Workspace")["__SETTINGS"]["__AREAS"]:GetChildren()) do
	WorldSection:NewButton(v.Name, "", function()
		teleport(v)
	end)
end

MiscSection:NewToggle("Claim Group Reward", "ToggleInfo", function(v)
	_G.Settings.autoClaim = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoClaim then break end
			ReplicatedStorage.Remotes.ClientRemote:InvokeServer("GroupChest")
		end
	end)
end)

MiscSection:NewButton("Tp To Second World", "ButtonInfo", function()
	for i, v in pairs(game.Workspace.__Map:GetChildren()) do
		if v:FindFirstChild("TouchInterest") then
			firetouchinterest(v,plr,0)
		end
	end
end)

MiscSection:NewButton("Redeem All Codes", "ButtonInfo", function()
	for i, v in pairs(codes) do
		ReplicatedStorage.Remotes.ClientRemote:InvokeServer("Codes",v)
	end
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
