repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Winston Hub | Smash Legends", "Midnight")

-- Create Tab
local FarmTab = Window:NewTab("Farming")
local ShopTab = Window:NewTab("Shop")

-- Create Section
-- Farm Tab
local FarmSection = FarmTab:NewSection("KOTH Section")
local KothSection = FarmTab:NewSection("KOTH Section")
-- Shop Tab
local ShopSection = ShopTab:NewSection("Shop Section")

FarmSection:NewToggle("Auto Swing", "ToggleInfo", function(v)
	_G.autoSwing = v
	while _G.autoSwing and task.wait() do
	local Event = game:GetService("ReplicatedStorage").Remotes.HammerSwing
	Event:FireServer()
	end
end)

FarmSection:NewToggle("Auto Sell", "ToggleInfo", function(v)
	_G.autoSell = v
	while _G.autoSell and task.wait() do
	local Event = game:GetService("ReplicatedStorage").Remotes.SellRequest
	Event:InvokeServer()
	end
end)

KothSection:NewToggle("Auto KOTH", "ToggleInfo", function(v)
	_G.autoKOTH = v
	while _G.autoKOTH and task.wait(1) do
		local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
		pl.CFrame = game:GetService("Workspace")["_KOTHMap"].Model.Hitbox.CFrame
	end
end)

ShopSection:NewToggle("Auto Buy Hammer", "ToggleInfo", function(v)
	_G.autoBuy = v
	while _G.autoBuy and task.wait() do
	local Event = game:GetService("ReplicatedStorage").Remotes.BuyAllHammers
	Event:FireServer()
	end
end)
