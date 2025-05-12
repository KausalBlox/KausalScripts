-- Load Orion UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/OrionLibrary/Orion/main/source.lua
"))()

-- Create the main window
local Window = OrionLib:MakeWindow({
    Name = "Grow A Garden Hub",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "🌿 Welcome to Grow A Garden Hub!"
})

-- 🌾 Auto Farm Tab
local autoTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://7734068321",
    PremiumOnly = false
})

_G.AutoHarvest = false

autoTab:AddToggle({
    Name = "Auto Harvest",
    Default = false,
    Callback = function(Value)
        _G.AutoHarvest = Value
    end
})

-- Harvesting logic
local function CanHarvest(plant)
    local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
    return prompt and prompt.Enabled
end

local function HarvestPlant(plant)
    local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        fireproximityprompt(prompt)
    end
end

task.spawn(function()
    while task.wait(1) do
        if not _G.AutoHarvest then continue end
        local player = game.Players.LocalPlayer
        local farm = workspace:FindFirstChild("Farm")
        if not farm then continue end
        local myFarm = farm:FindFirstChild(player.Name)
        if not myFarm then continue end
        local important = myFarm:FindFirstChild("Important")
        if not important then continue end
        local plants = important:FindFirstChild("Plants_Physical")
        if not plants then continue end

        for _, plant in pairs(plants:GetChildren()) do
            if CanHarvest(plant) then
                HarvestPlant(plant)
            end
        end
    end
end)

-- 🌱 Seed Shop Tab
local seedTab = Window:MakeTab({
    Name = "Seed Shop",
    Icon = "rbxassetid://7734053497",
    PremiumOnly = false
})

seedTab:AddButton({
    Name = "Open Seed Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Seed_Shop")
        if gui then
            gui.Enabled = true
        end
    end
})

-- 🐣 Pet Eggs Tab
local petTab = Window:MakeTab({
    Name = "Pet Eggs",
    Icon = "rbxassetid://7734005275",
    PremiumOnly = false
})

petTab:AddButton({
    Name = "Open Pet UI",
    Callback = function()
        local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Pet_UI")
        if gui then
            gui.Enabled = true
        end
    end
})

-- ⚔️ Gear Shop Tab
local gearTab = Window:MakeTab({
    Name = "Gear Shop",
    Icon = "rbxassetid://7733960981",
    PremiumOnly = false
})

gearTab:AddButton({
    Name = "Open Gear Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Gear_Shop")
        if gui then
            gui.Enabled = true
        end
    end
})

-- 🎉 Event UI Tab
local eventTab = Window:MakeTab({
    Name = "Events",
    Icon = "rbxassetid://7733960981",
    PremiumOnly = false
})

eventTab:AddButton({
    Name = "Open Event UI",
    Callback = function()
        local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Event_UI")
        if gui then
            gui.Enabled = true
        end
    end
})

-- Initialize Orion
OrionLib:Init()
