repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players")
repeat wait() until game:GetService("Players").LocalPlayer

if not game:IsLoaded() then
	local GameLoadGui = Instance.new("Message",workspace);
	GameLoadGui.Text = 'Wait Game Loading';
	game.Loaded:Wait();
	GameLoadGui:Destroy();
	task.wait(10);
end;

_G.RoyxSpecialMode = "Hell Factory";
_G["External Config"] = {
    ["Kai Gems"] = true, -- true / false
    ["Kai Story"] = false, -- true / false
    ["Kai Battle Pass"] = false, -- true / false
    ["Kai Infinity Castle"] = false, -- true / false
    ["Auto Set Resource"] = true, -- true / false
    ["Select End Game Mode"] = "Instant Leave", -- "Instant Leave" / "Auto Sell"
    ["End Wave"] = 10, -- number
    ["Use World Jumper"] = true, -- true / false
    ["Auto Clam Battle Pass"] = true, -- true / false
    ["Maximum Added Gems"] = 10000, -- number
    ["Close Roblox When Maximum Added Gems"] = false, -- true / false
    ["Using Limit Farming"] = true, -- true / false
    ["Stop Farming When The Limit Is Reached"] = false, -- true / false
    ["Send Webhook When The Limit Is Reached"] = false, -- true / false
    ["Webhook Url"] = "https://discord.com/api/webhooks/1158022592196784198/J46Hf6wTlKY5k4lPy-IMfeO-CMoTl74twPramvKxTyjqMiDDuZLsGy0bKy1MX-Dic5_w", -- string
    ["RAM Port"] = "7963", -- string
    ["RAM Password"] = "", -- string
    ["RAM Private Server Url"] = "", -- string
    ["RAM Auto Description"] = true, -- true / false
    ["RAM Auto Private Server"] = false, -- true / false
    ["RAM Auto Exit"] = false, -- true / false
    ["Fps Limit"] = 15, -- number
    ["Lock Fps"] = true, -- true / false
    ["Release Fps When Rejoin"] = false, -- true / false
    ["Select Unit"] = {"Slot 1", "Slot 2", "Slot 3", "Slot 4"}, -- table  {"Slot 1", "Slot 2", "Slot 3", "Slot 4", "Slot 5", "Slot 6"}
};

_G.Key = "FBNGU-ZQ6J1-65ZW1"
_G.DiscordId = "921628832556011571"
loadstring(game:HttpGet("https://raw.githubusercontent.com/Natsuhanaki/Royx_PC/main/loader.lua"))();
