local a = game:GetService("ReplicatedStorage")
local b = game:GetService("Players").LocalPlayer
local c = b.Character
local d = c:WaitForChild("HumanoidRootPart")
local e = c:WaitForChild("Humanoid")
local f = b.PlayerGui.mainUI.clickerButton
local g = a.Events.Client:FindFirstChild("requestRebirth")
local h = a.Events.Client:FindFirstChild("purchaseEgg2")
local i = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local j = i.CreateLib("Winston Hub | Clicker Simulator", "Midnight")
local k = j:NewTab("Autofarm")
local l = j:NewTab("Eggs")
local m = j:NewTab("Rebirths")
local n = j:NewTab("Teleports")
local o = j:NewTab("Misc")
local p = j:NewTab("Settings")
local q = j:NewTab("Credits")
local r = k:NewSection("AutoFarm")
local s = l:NewSection("Eggs")
local t = m:NewSection("Rebirths (Must have the rebirth amount)")
local u = n:NewSection("Zones")
local v = o:NewSection("Miscellaneous")
local w = p:NewSection("Settings")
local x = q:NewSection("Credits")
getgenv().AutoTap = false
getgenv().AutoRebirth = false
getgenv().AutoEgg = false
local function y()
	for z, A in pairs(getconnections(f.MouseButton1Click)) do
		A.Function()
	end
end
local function B(C)
	local D = C
	local E = false
	local F = false
	g:FireServer(D, E, F)
end
local function G(H)
	local I = game:GetService("Workspace").Eggs:FindFirstChild(H)
	local E = false
	local F = false
	h:InvokeServer(I, E, F)
end
local function J()
	game:GetService("ReplicatedStorage").Events.Client.petsTools.equipBest:FireServer()
end
local function K(L)
	d.CFrame = L.CFrame
end
r:NewToggle(
	"AutoTap",
	"Automatically get taps",
	function(M)
		getgenv().AutoTap = M
	end
)
local N = "Basic"
local O = {}
local P = game:GetService("Workspace").Eggs
s:NewDropdown(
	"Choose Egg",
	"Choose the egg you want to buy",
	O,
	function(Q)
		N = Q
	end
)
s:NewToggle(
	"Auto Buy Eggs",
	"Automatically buys selected egg",
	function(M)
		getgenv().AutoEgg = M
	end
)
s:NewButton(
	"Buy Egg",
	"Buys chosen egg",
	function()
		G(N)
	end
)
s:NewButton(
	"Equip Best",
	"Equips your best pets",
	function()
		J()
	end
)
for z, A in pairs(P:GetChildren()) do
	table.insert(O, A.Name)
end
local R = require(game:GetService("ReplicatedStorage").RebirthShopModule)
local S = {1, 5, 10}
local T = 1
for z, A in pairs(R) do
	if typeof(A) == "table" then
		for U, V in pairs(A) do
			if typeof(V) == "table" then
				for W, X in pairs(V) do
					if W == "rebirthOption" then
						table.insert(S, X)
					end
				end
			end
		end
	end
end
t:NewDropdown(
	"Choose Rebirth",
	"Choose the rebirth amount",
	S,
	function(Q)
		T = Q
	end
)
t:NewToggle(
	"Auto Rebirth",
	"Automatically rebirths the amount chosen",
	function(M)
		getgenv().AutoRebirth = M
	end
)
t:NewButton(
	"Rebirth",
	"Rebirths the chosen amount",
	function()
		B(T)
	end
)
local Y = game:GetService("Workspace").Zones
local Z = {}
for z, A in pairs(Y:GetChildren()) do
	table.insert(Z, A.Name)
end
u:NewDropdown(
	"Teleport To Island",
	"Teleports you to the island chosen",
	Z,
	function(Q)
		if Y:FindFirstChild(Q) then
			K(Y:FindFirstChild(Q).teleport)
		end
	end
)
local _ = game:GetService("Players").LocalPlayer.Data.unlockedZones
local a0 = game:GetService("Players").LocalPlayer.Data.rebirthShopPurchases
v:NewButton(
	"Unlock All Zones",
	"Unlocks all the zones",
	function()
		_.Value = ""
		for z = 1, #Z do
			_.Value = _.Value .. ";" .. Z[z] .. ";"
		end
	end
)
w:NewKeybind(
	"Ui Toggle",
	"Toggles the ui visiblity on and off",
	Enum.KeyCode.LeftControl,
	function()
		i:ToggleUI()
	end
)

v:NewButton(
	"Unlock All Gamepass",
	"ButtonInfo",
	function()
		local b = require(game:GetService("ReplicatedStorage").ShopModule)
		local gpData = game:GetService("Players").LocalPlayer.Data.gamepasses
		for i, v in pairs(b.Gamepasses) do
			gpData.Value = gpData.Value..';'..v.Label..';'
		end
	end
)

v:NewButton("Unlock All Boost","ButtonInfo",function()
	for i, v in pairs(game:GetService("Players").LocalPlayer.Boosts:GetChildren()) do
		v:FindFirstChild("isActive").Value = true
	end
end)
x:NewLabel("Ui - Kavo's Ui Library")
x:NewLabel("Scripting - Winston Hub")
game:GetService("RunService").RenderStepped:Connect(function()
if getgenv().AutoTap then
		y()
	end
end)
while wait() do
	if getgenv().AutoRebirth then
		B(T)
	end
end
while wait(2) do
	if getgenv().AutoEgg then
		G(N)
	end
end
