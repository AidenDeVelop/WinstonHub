local function Attack()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
end

local l = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local w = l.CreateLib("Winston Hub | Attack Simulator", "Midnight")
local f = w:NewTab("Farming")
local b = w:NewTab("Buy")
local c = w:NewTab("Chest")
local e = w:NewTab("Egg")
local fs = f:NewSection("Farming Section")
local bs = b:NewSection("Buy Section")
local cs = c:NewSection("Chest Section")
local es = e:NewSection("Egg Section")

local hum = game.Players.LocalPlayer.Character.HumanoidRootPart

fs:NewDropdown("Select Area", "DropdownInf", {"Spawn", "Snow", "Youtube", "Lava", "Ocean", "Void"}, function(a)
	_G.selectedArea = a
end)

fs:NewToggle("Auto Attack", "ToggleInfo", function(v)
	_G.autoAttack = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoAttack then break end
			for i,v in next, game:GetService("Workspace")["__AREAS"][_G.selectedArea]:GetDescendants() do
				if v.Name == "Health" then wait()
					repeat          
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame wait()
					until v.Value == 0
					wait()
				end
			end
		end
	end)
end)

bs:NewToggle("Auto Buy Weapon", "ToggleInfo", function(v)
	_G.autoBuy = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoBuy then break end
			local tbl = {}
			local order = {}
			for a,b in pairs(game:GetService("ReplicatedStorage")["__CANNONS"]:GetChildren()) do 
				table.insert(tbl, b)
				for i, v in ipairs(tbl) do
					table.insert(order, i)
					wait()
					local args = {
						[1] = (#order),
						[2] = "Cannons"
					}

					game:GetService("ReplicatedStorage").__REMOTES.__Buy_System:InvokeServer(unpack(args))
				end
			end
		end
	end)
end)

cs:NewToggle("Auto Collect Chest", "ToggleInfo", function(v)
	_G.autoCollect = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoCollect then break end
			for i,v in pairs(game:GetService("Workspace")["__CHESTS"]:GetDescendants()) do 
				if v.Name == "TouchInterest" and v.Parent then wait()
					firetouchinterest(hum, v.Parent, 0)
					firetouchinterest(hum, v.Parent, 1)
				end
			end
		end
	end)
end)

es:NewToggle("Auto Open Neareast Egg [Single]", "ToggleInfo", function(v)
	_G.autoOpenSingle = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoOpenSingle then break end
			keypress(0x45)
			keyrelease(0x45)
		end
	end)
end)

es:NewToggle("Auto Open Neareast Egg [Triple]", "ToggleInfo", function(v)
	_G.autoOpenTriple = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoOpenTriple then break end
			keypress(0x52)
			keyrelease(0x52)
		end
	end)
end)
