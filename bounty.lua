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

getgenv().Setting = {
    ["Start"] = true,
    ["Team"] = "Pirates",
    ["MasteryFarm"] = "Half",
    ["PlayerHuntQuest"] = true,
    ["HopwhileManyPlayer"] = true,
    ["Ignore Hop"] = false,
    ["Disabled3dRender"] = true,
    ["LowGraphicQuality"] = true,
    ["FastAttackDelay"] = "0.175",
    ["Lock Fragments"] = 10000,
    ["AutoBuyFruit"] = true,
    ["ImportantFruit"] = {
        [1] = "Dragon-Dragon",
        [2] = "Venom-Venom",
        [3] = "Dough-Dough",
        [4] = "Rumble-Rumble",
        [5] = "Soul-Soul",
        [6] = "Human-Human: Buddha",
        [7] = "Quake-Quake",
        [8] = "Dark-Dark",
        [9] = "String-String"
    },
    ["RBXAcc"] = {
        ["AutoDescription"] = true,
        ["Delay"] = 3,
        ["Alias"] = true
    }
}
loadstring(game:HttpGet'https://api.quartyz.com/script/BitHub.lua')()
