-- Load Rayfield UI (official source)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the main window
local Window = Rayfield:CreateWindow({
    Name = "🌿 Grow A Garden Hub",
    LoadingTitle = "Starting...",
    LoadingSubtitle = "by Kausal",
    ConfigurationSaving = {
        Enabled = false
    }
})

-- 🌾 Auto Farm Tab
local AutoFarmTab = Window:CreateTab("🌾 Auto Farm", 4483362458)

-- Auto Harvest Toggle
_G.AutoHarvest = false
AutoFarmTab:CreateToggle({
    Name = "Enable Auto Harvest",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoHarvest = Value
    end
})

-- Auto Harvest Logic
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
local SeedShopTab = Window:CreateTab("🌱 Seed Shop", 7734053497)

SeedShopTab:CreateButton({
    Name = "Open Seed Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Seed_Shop")
        if gui then
            gui.Enabled = true
        end
    end
})

-- 🐣 Pet Eggs Tab
local PetTab = Window:CreateTab("🐣 Pet Eggs", 7734005275)

PetTab:CreateButton({
    Name = "Open Pet UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Pet_UI")
        if gui then
            gui.Enabled = true
        end
    end
})

-- ⚔️ Gear Shop Tab
local GearTab = Window:CreateTab("⚔️ Gear Shop", 7733960981)

GearTab:CreateButton({
    Name = "Open Gear Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Gear_Shop")
        if gui then
            gui.Enabled = true
        end
    end
})

-- 🎉 Event UI Tab
local EventTab = Window:CreateTab("🎉 Event UI", 7733960981)

EventTab:CreateButton({
    Name = "Open Event UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Event_UI")
        if gui then
            gui.Enabled = true
        end
    end
})
