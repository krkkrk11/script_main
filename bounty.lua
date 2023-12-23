repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players")
repeat wait() until game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.PlayerGui
repeat wait() until game:GetService("ReplicatedStorage").Effect.Container

if not game:IsLoaded() then
	local GameLoadGui = Instance.new("Message",workspace);
	GameLoadGui.Text = 'Wait Game Loading';
	game.Loaded:Wait();
	GameLoadGui:Destroy();
	task.wait(10);
end;

local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()
local SelectWeapon = "Melee" --"Melee","Sword","Fruit"
_G.havefruitspawn = false
_G.Settings = {
    Main = {
        ["Auto Grab Fruit"] = true,
        ["Auto Farm Level"] = true,
        ["Distance Mob Aura"] = 1000
    },
	Configs = {
		["Fast Attack"] = true,
		["Fast Attack Type"] = {"Fast"}, --{Normal,Fast,Slow}
		["Bypass TP"] = false,
		["Distance Auto Farm"] = 20,
		["Auto Haki"] = true
	},
	Raids = {
		["Auto Raids"] = true,

		["Kill Aura"] = false,
		["Auto Awakened"] = false,
		["Auto Next Place"] = false,
	}
}



repeat wait()
	if game.Players.LocalPlayer.Team == nil and game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible == true then
		game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
		game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
		game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
		wait(.5)
		game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
		game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
	end
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()


--anit afk
game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
--function
local id = game.PlaceId
if id == 2753915549 then World1 = true; elseif id == 4442272183 then World2 = true; elseif id == 7449423635 then World3 = true; else game:Shutdown() end;

-- [Body Gyro]

spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
		    if _G.havefruitspawn or _G.Settings.Raids["Auto Raids"] then
			if syn then
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
				end
			else
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
						if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
							game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
						end
						local BodyVelocity = Instance.new("BodyVelocity")
						BodyVelocity.Name = "BodyVelocity1"
						BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
						BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
						BodyVelocity.Velocity = Vector3.new(0, 0, 0)
					end
				end
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false    
					end
				end
				end
			else
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy();
				end
			end
		end)
	end)
end)

function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then 
			return true
		end
		return false
	end
end

-- [Function (Abandoned Quest , Others)]

function Com(com,...)
	local Remote = game:GetService('ReplicatedStorage').Remotes:FindFirstChild("Comm"..com)
	if Remote:IsA("RemoteEvent") then
		Remote:FireServer(...)
	elseif Remote:IsA("RemoteFunction") then
		Remote:InvokeServer(...)
	end
end

-- [Tween Functions]

local function GetIsLand(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end

	local ReturnValue
	local CheckInOut = math.huge;
	if game.Players.LocalPlayer.Team then
		for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do 
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude < CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue = v.Name
			end
		end
		if ReturnValue then
			return ReturnValue
		end 
	end
end

--BTP

function BTP(Position)
	game.Players.LocalPlayer.Character.Head:Destroy()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	wait(1)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
end
local function toTarget(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; wait(0.2) end

	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 1000 then
		Speed = 315
	elseif Distance >= 1000 then
		Speed = 300
	end

	if _G.Settings.Configs["Bypass TP"] then
		if Distance > 3000 then
			pcall(function()
				tween:Cancel()
				fkwarp = false

				if game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("SpawnPoint").Value == tostring(GetIsLand(RealTarget)) then 
					wait(.1)
					Com("F_","TeleportToSpawn")
				elseif game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("LastSpawnPoint").Value == tostring(GetIsLand(RealTarget)) then
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					wait(0.1)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
				else
					if game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
						if fkwarp == false then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RealTarget
						end
						fkwarp = true
					end
					wait(.08)
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
					wait(.1)
					Com("F_","SetSpawnPoint")
				end
				wait(0.2)

				return
			end)
		end
	end

	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		tween:Cancel()
	end 

	function tweenfunc:Wait()
		tween.Completed:Wait()
	end 

	return tweenfunc
end
function EquipWeapon(Tool)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then 
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) 
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
		end
	end)
end
function toTargetP(CFgo)
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then tween:Cancel() repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return end
	if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude <= 150 then
		pcall(function()
			tween:Cancel()

			game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = CFgo

			return
		end)
	end
	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/325, Enum.EasingStyle.Linear)
	tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
	tween:Play()

	local tweenfunc = {}

	function tweenfunc:Stop()
		tween:Cancel()
	end

	return tweenfunc
end
function getAllBladeHitsPlayers(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i=1,#Characters do local v = Characters[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end
function CurrentWeapon()
	local ac = CombatFrameworkR.activeController
	local ret = ac.blades[1]
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	pcall(function()
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
	end)
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	return ret
end
function getAllBladeHits(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i=1,#Enemies do local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end
function AttackFunction()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHits(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end                 
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
				end
			end
		end
	end
end
function AttackPlayers()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHitsPlayers(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end                 
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
				end
			end
		end
	end
end
coroutine.wrap(function()
	while task.wait(0.065) do
		local ac = CombatFrameworkR.activeController
		if ac and ac.equipped then
			if FastAttack and _G.Settings.Configs["Fast Attack"] then
				AttackFunction()
				if _G.Settings.Configs["Fast Attack Type"] == "Normal" then
					if tick() - cooldownfastattack > .9 then wait(.1) cooldownfastattack = tick() end
				elseif _G.Settings.Configs["Fast Attack Type"] == "Fast" then
					if tick() - cooldownfastattack > 1.5 then wait(.01) cooldownfastattack = tick() end
				elseif _G.Settings.Configs["Fast Attack Type"] == "Slow" then
					if tick() - cooldownfastattack > .3 then wait(.7) cooldownfastattack = tick() end
				end
			elseif FastAttack and _G.Settings.Configs["Fast Attack"] == false then
				if ac.hitboxMagnitude ~= 55 then
					ac.hitboxMagnitude = 55
				end
				ac:attack()
			end
		end
	end
end)()
----weapon
task.spawn(function()
	while wait() do
		pcall(function()
			if SelectWeapon == "Melee" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			elseif SelectWeapon == "Sword" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			elseif SelectWeapon == "Fruit" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			else
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.Settings.Configs["Select Weapon"] = v.Name
						end
					end
				end
			end
		end)
	end
end)
-- [Bring Mob]

task.spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if StartMagnet then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
						end
					end
				end
			end
		end)
	end
end)


----farmbone
spawn(function()
	while wait() do
		pcall(function()--game:GetService("Workspace")["Fruit "].Handle
		    _G.havefruitspawn = false
    		if _G.Settings.Main["Auto Grab Fruit"] then
    		    if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
        			if game:GetService("Workspace"):FindFirstChild("Fruit ") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Fruit "]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Bomb Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Bomb Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Spike Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Spike Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Chop Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Chop Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Spring Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Spring Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Kilo Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Kilo Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Smoke Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Smoke Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Spin Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Spin Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Flame Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Flame Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Bird: Falcon Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Bird: Falcon Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Ice Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Ice Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Sand Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Sand Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Dark Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Dark Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Revive Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Revive Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Diamond Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Diamond Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Light Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Light Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Love Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Love Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Rubber Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Rubber Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Barrier Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Barrier Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Magma Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Magma Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Portal Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Portal Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Quake Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Quake Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Human-Human: Buddha Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Human-Human: Buddha Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Spider Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Spider Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Bird: Phoenix Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Bird: Phoenix Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Rumble Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Rumble Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Paw Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Paw Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Gravity Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Gravity Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Dough Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Dough Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Shadow Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Shadow Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Venom Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Venom Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Control Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Control Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Dragon Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Dragon Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Soul Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Soul Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Leopard Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Leopard Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			elseif game:GetService("Workspace"):FindFirstChild("Blizzard Fruit") then
        			    _G.havefruitspawn = true
        				_G.Settings.Main["Auto Farm Level"] = false
        				for i,v in pairs(game:GetService("Workspace")["Blizzard Fruit"]:GetChildren()) do
        					if v.Name == "Handle" then
        					   toTarget(v.CFrame)
        					end
        				end
        			else
        				wait(6)
        				_G.Settings.Main["Auto Farm Level"] = true
        				_G.havefruitspawn = false
        			end
    			end
    		end
    		if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
                repeat wait() until game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
                _G.havefruitspawn = false
            end
		end)
	end
end)


spawn(function()
	pcall(function()
		while wait() do
			if _G.Settings.Raids["Auto Next Place"] then
			    if _G.havefruitspawn == false then
    				if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true and game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
    					if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
    					    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Island 5"].Position).Magnitude <= 6500 then
            				    toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 5"].CFrame*CFrame.new(4,65,10))
            				end
    					elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
    					    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Island 4"].Position).Magnitude <= 6500 then
    						    toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 4"].CFrame*CFrame.new(4,65,10))
    						end
    					elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
    					    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Island 3"].Position).Magnitude <= 6500 then
    						    toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 3"].CFrame*CFrame.new(4,65,10))
    						end
    					elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
    					    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Island 2"].Position).Magnitude <= 6500 then
    						    toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 2"].CFrame*CFrame.new(4,65,10))
    						end
    					elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
    					    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Island 1"].Position).Magnitude <= 6500 then
    						    toTarget(game:GetService("Workspace")["_WorldOrigin"].Locations["Island 1"].CFrame*CFrame.new(4,65,10))
    						end
    					end
    				end
    			end
			end
		end
	end)
end)



spawn(function()
	while wait() do
    		if _G.Settings.Raids["Auto Raids"] and not _G.Settings.Main["Auto Farm Level"]  then 
    			if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") then
    				if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
    					if World2 then
    						fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
    						game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible = true
    					elseif World3 then
    						fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
    						game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible = true
    					end
    				end
    				if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then				
    				    _G.Settings.Raids["Auto Next Place"] = true
    				    _G.Settings.Raids["Kill Aura"] = true
    				end           
    			elseif _G.havefruitspawn == false and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
                    local args = {
                    	[1] = "RaidsNpc",
                    	[2] = "Select",
                    	[3] = "Flame"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    				if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then				
    				    _G.Settings.Raids["Auto Next Place"] = true
    				    _G.Settings.Raids["Kill Aura"] = true
    				end
    			end
    		end
	end
end)

spawn(function()
	while wait() do
		if _G.Settings.Raids["Kill Aura"] then
			for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
				if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					pcall(function()
						repeat wait()
							v.Humanoid.Health = 0
							v.HumanoidRootPart.CanCollide = false
							v.HumanoidRootPart.Size = Vector3.new(50,50,50)
							v.HumanoidRootPart.Transparency = 0.8
						until not _G.Settings.Raids["Kill Aura"] or not v.Parent or v.Humanoid.Health <= 0
					end)
				end
			end
		end
	end
end)
function HopLowServer()
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            function TPReturner()
                local Site;
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0;
                for i,v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _,Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        -- delfile("NotSameServers.json")
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                    end)
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(function()
                                -- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                                wait()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                            end)
                            wait(.1)
                        end
                    end
                end
            end
            function Teleport()
                while wait(.2) do
                    pcall(function()
                        TPReturner()
                        if foundAnything ~= "" then
                            TPReturner()
                        end
                    end)
                end
            end
            Teleport()
        end
_G.hop = 0
while wait(1) do
    if _G.havefruitspawn or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
        _G.hop = 0
    else
        _G.hop = _G.hop+1
        if not _G.havefruitspawn and _G.hop >= 20 and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
            HopLowServer()
        end
    end
    print(_G.hop,_G.havefruitspawn)
end
