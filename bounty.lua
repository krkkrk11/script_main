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

join = game.Players.localPlayer.Neutral == false
	if (_G.Team == "Pirates" or _G.Team == "Marines") and not join then
		repeat wait()
			pcall(function()
				join = game.Players.localPlayer.Neutral == false
				if _G.Team == "Pirates" then
					for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
						for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton[v])) do
							v.Function()
						end
					end
				elseif _G.Team == "Marines" then
					for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
						for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton[v])) do
							v.Function()
						end
					end
				else
					for i,v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
						for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton[v])) do
							v.Function()
						end
					end
				end
			end)
		until join == true and game.Players.LocalPlayer.Team ~= nil and game:IsLoaded() 
	end
