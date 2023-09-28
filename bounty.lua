local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()
local SelectWeapon = "Melee" --"Melee","Sword","Fruit"
local NameP = loadstring(game:HttpGet('https://pastebin.com/raw/QkcvnDvE'))()
_G.Settings = {
    Main = {
        ["Distance Mob Aura"] = 1000
    },
	Configs = {
		["Bypass TP"] = true,
		}
}
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

task.spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
		    if true then
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
	
	local id = game.PlaceId
    if id == 2753915549 then World1 = true; elseif id == 4442272183 then World2 = true; elseif id == 7449423635 then World3 = true; else game:Shutdown() end;
	if World1 then
	    DistanceSky1 = (RealTarget.Position - Vector3.new(-4607.82275390625, 874.3905029296875, -1667.556884765625)).Magnitude
	    DistanceSky2 = (RealTarget.Position - Vector3.new(-7894.61767578125, 5547.1416015625, -380.29119873046875)).Magnitude
	    DistanceWhirlpool = (RealTarget.Position - Vector3.new(3864.6884765625, 6.736950397491455, -1926.214111328125)).Magnitude
	    DistanceUnderwater = (RealTarget.Position - Vector3.new(61163.8515625, 11.6796875, 1819.7841796875)).Magnitude
	end
	if World2 then
        DistanceCafe = (RealTarget.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Café"].Position).Magnitude
        DistanceShip = (RealTarget.Position - game:GetService("Workspace")["_WorldOrigin"].Locations["Cursed Ship"].Position).Magnitude
        DistanceShipdoor = (RealTarget.Position - game:GetService("Workspace").Map.GhostShip.Teleport.Position).Magnitude
	end

	if World3 then
	    
	end
	--[[if World1 then
        if Distance >= DistanceSky1 and DistanceWhirlpool >= DistanceSky1 and DistanceSky1 <= DistanceSky2 and DistanceUnderwater >= DistanceSky1 then --DistanceSky1
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275390625, 874.3905029296875, -1667.556884765625))
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4650.48095703125, 930.5040283203125, -1751.639404296875)
        end
        if Distance >= DistanceSky2 and DistanceSky1 >= DistanceSky2 and DistanceWhirlpool >= DistanceSky2 and DistanceUnderwater >= DistanceSky2 then --DistanceSky2
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.61767578125, 5547.1416015625, -380.29119873046875))
        end
        if Distance >= DistanceWhirlpool and DistanceWhirlpool <= DistanceSky1 and DistanceWhirlpool <= DistanceSky2 and DistanceWhirlpool <= DistanceUnderwater then --DistanceWhirlpool
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.6884765625, 6.736950397491455, -1926.214111328125))
        end
        if Distance >= DistanceUnderwater and DistanceUnderwater <= DistanceSky1 and DistanceUnderwater <= DistanceSky2 and DistanceUnderwater <= DistanceWhirlpool then --DistanceUnderwater
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
        end
    end
    
    
	if World2 then
    	if Distance >= DistanceCafe and DistanceCafe <= DistanceShip and DistanceShipdoor >= DistanceCafe then --DistanceCafe
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-286.98907470703125, 306.1379089355469, 597.7627563476562))
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-387.8039855957031, 359.985595703125, 553.7474365234375)
    	end
    	if Distance >= DistanceShip and DistanceShip <= DistanceCafe and DistanceShipdoor >= DistanceShip then --DistanceShip
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.2125244140625, 126.97600555419922, 32852.83203125))
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(919.0318603515625, 125.08289337158203, 32921.94140625)
    	end
    	if Distance >= DistanceShipdoor and DistanceCafe >= DistanceShipdoor and DistanceShipdoor <= DistanceCafe then --DistanceShipdoor
    	    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.55810546875, 89.03499603271484, -132.83953857421875))
    	end
	end]]
    wait(1)
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
while wait() do
	pcall(function()
		for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
			for i2,v2 in pairs(NameP) do
				repeat wait()
					if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == true then
							local args = {
								[1] = "EnablePvp"
							}
		
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							repeat wait() until game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == false
						if v.Name == v2 then
							if  game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == false then
								toTarget(v.HumanoidRootPart.CFrame*CFrame.new(0,0,-5))
							end
						end
					end
				until game.Players.LocalPlayer.Character.Humanoid.Health == 0
			end
		end
	end)
end
