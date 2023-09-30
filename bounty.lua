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

repeat wait()
	if game.Players.LocalPlayer.Team == nil and game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible == true then
		if _G.Settings.Configs["Select Team"] == "Pirate" then
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		elseif _G.Settings.Configs["Select Team"] == "Marine" then
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		else
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		end
	end
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
