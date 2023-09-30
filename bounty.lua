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

Fruits = {
"Bird: Falcon Fruit",
"Diamond Fruit",
"Light Fruit",
"Rubber Fruit",
"Barrier Fruit",
"Magma Fruit",
"Quake Fruit",
"Blizzard Fruit",
"Portal Fruit",
"String Fruit",
"Dark Fruit",
"Sand Fruit",
"Ice Fruit",
"Spin Fruit",
"Flame Fruit",
"Bomb Fruit",
"Smoke Fruit",
"Spin Fruit",
"Spring Fruit",
"Kilo Fruit",
"Revive Fruit",
"Chop Fruit",
"Human: Buddha Fruit",
"Bird: Phoenix Fruit",
"Rumble Fruit",
"Paw Fruit",
"Gravity Fruit",
"Dough Fruit",
"Control Fruit",
"Venom Fruit",
"Shadow Fruit",
"Dragon Fruit" ,
"Soul Fruit",
"Leopard Fruit",
"Fruit ",
"Fruit"
}
Valuable = {"Kilo Fruit","Spin Fruit","Spring Fruit","Bomb Fruit","Smoke Fruit","Spike Fruit","Flame Fruit","Bird: Falcon Fruit","Ice Fruit","Sand Fruit","Dark Fruit","Diamond Fruit","Light Fruit","Rubber Fruit","Barrier Fruit","Magna Fruit","Quake Fruit","String Fruit","Portal Fruit","Blizzard Fruit","Revive Fruit","Chop Fruit, Dough Fruit","Shadow Fruit","Venom Fruit","Control Fruit","Dragon Fruit","Soul Fruit","Leopard Fruit","Fruit ","Fruit"} ------ it will stop the script if you got this fruit
Webhook = "https://discord.com/api/webhooks/1145282565255725056/HnP8mTnR0icgkCWF6DdQzahuIIasSIVv79hR_kHwSxMcqBNUd_W3o7yoGHSivb1D7AoU" --------------------------------Optional
Store = true  --------------------------------Auto Store after it got the fruit
Safeplace = true ----------------------------- Safeplace 
Repeat = true --------------------------------- Repeat continues hopping
-----------------------------------------------------------------------
loadstring(game:HttpGet"https://gist.githubusercontent.com/NotHubris/4e6fdc88d84c30afa9b28c590f273bbf/raw")()
