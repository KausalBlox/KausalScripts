-- Load Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌿 Grow A Garden Hub", "DarkTheme")

-- 🌾 Auto Farm Tab
local AutoFarmTab = Window:NewTab("🌾 Auto Farm")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm")

_G.AutoHarvest = false

AutoFarmSection:NewToggle("Auto Harvest", "Automatically harvest plants", false, function(state)
    _G.AutoHarvest = state
end)

-- Auto Harvest Loop
task.spawn(function()
    while task.wait(1) do
        if not _G.AutoHarvest then continue end
        local player = game.Players.LocalPlayer
        local farmFolder = workspace:FindFirstChild("Farm")
        if not farmFolder then continue end
        local myFarm = farmFolder:FindFirstChild(player.Name)
        if not myFarm then continue end
        local important = myFarm:FindFirstChild("Important")
        if not important then continue end
        local plants = important:FindFirstChild("Plants_Physical")
        if not plants then continue end

        for _, plant in pairs(plants:GetChildren()) do
            local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt and prompt.Enabled then
                fireproximityprompt(prompt)
            end
        end
    end
end)

-- 🌱 Seed Shop Tab
local SeedShopTab = Window:NewTab("🌱 Seed Shop")
local SeedSection = SeedShopTab:NewSection("Seed Shop")

SeedSection:NewButton("Open Seed Shop UI", "Opens the in-game seed shop", function()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Seed_Shop")
    if gui then gui.Enabled = true end
end)

-- 🐣 Pet Eggs Tab
local PetEggsTab = Window:NewTab("🐣 Pet Eggs")
local PetSection = PetEggsTab:NewSection("Pets")

PetSection:NewButton("Open Pet Eggs UI", "Opens the pet interface", function()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Pet_UI")
    if gui then gui.Enabled = true end
end)

-- ⚔️ Gear Shop Tab
local GearTab = Window:NewTab("⚔️ Gear Shop")
local GearSection = GearTab:NewSection("Gear")

GearSection:NewButton("Open Gear Shop UI", "Opens the gear shop UI", function()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Gear_Shop")
    if gui then gui.Enabled = true end
end)

-- 🎉 Event UI Tab
local EventTab = Window:NewTab("🎉 Event UI")
local EventSection = EventTab:NewSection("Event")

EventSection:NewButton("Open Event UI", "Opens the event menu", function()
    local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Event_UI")
    if gui then gui.Enabled = true end
end)
