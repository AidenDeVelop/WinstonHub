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
local FarmSection = FarmTab:NewSection("Farming Section")
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

ShopSection:NewToggle("Auto Buy Hammer", "ToggleInfo", function(v)
	_G.autoBuy = v
	while _G.autoBuy and task.wait() do
	local Event = game:GetService("ReplicatedStorage").Remotes.BuyAllHammers
	Event:FireServer()
	end
end)
