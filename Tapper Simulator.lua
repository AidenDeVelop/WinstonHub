local l = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local w = l.CreateLib("Winston Hub | Tapper Simulator", "Midnight")
local m = w:NewTab("Main")
local ms = m:NewSection("Main Section")
local es = m:NewSection("Egg Section")
local rs = m:NewSection("Rebirth Section")
local m2 = w:NewTab("Misc")
local m2s = m2:NewSection("Misc Section")

local list = {}

for i,v in pairs(game:GetService("Workspace").Resources.Eggs:GetChildren()) do
	if string.match(v.Name,"Robux") then
		v:Remove()
	end
end

for i,v in next, game.Workspace.Resources.Eggs:GetChildren() do
	table.insert(list,v.Name)
end

ms:NewToggle("Auto Click", "ToggleInfo", function(a)
	aa = a
	while aa do task.wait()
		game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer()
	end
end)

es:NewDropdown("Select Egg", "DropdownInf", list, function(eggList)
	wa = eggList
end)

es:NewToggle("Auto Open Egg", "ToggleInfo", function(b)
	bb = b
	while bb do task.wait()
		local args = {[1] = tostring(wa),[2] = 1}
		game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.PurchaseEgg:InvokeServer(unpack(args))
	end
end)

rs:NewTextBox("Rebirth Amount", "TextboxInfo", function(ab)
	reb = ab
end)

rs:NewToggle("Auto Rebirth", "ToggleInfo", function(abc)
	abcd = abc
	while abcd do task.wait()
		game:GetService("ReplicatedStorage").Packages.Knit.Services.RebirthService.RF.Rebirth:InvokeServer(tonumber(reb))
	end
end)

m2s:NewSlider("WalkSpeed", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

m2s:NewSlider("JumpPower", "SliderInfo", 100, 0, function(v) -- 500 (MaxValue) | 0 (MinValue)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

m2s:NewButton("Rejoin", "ButtonInfo", function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game.Players.LocalPlayer)
end)

m2s:NewButton("Serverhop", "ButtonInfo", function()
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

m2s:NewButton("Serverhop Low Server", "ButtonInfo", function()
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
