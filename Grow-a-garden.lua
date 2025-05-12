-- Grow a Garden UI Script by Kausal

-- Load Wizard UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Grow A Garden Hub")

-- Auto Harvest Section
local AutoTab = Window:NewSection("🌾 Auto Farm")
_G.AutoHarvest = false

AutoTab:CreateToggle("Auto Harvest", function(state)
    _G.AutoHarvest = state
end)

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

-- Seed Shop Section
local SeedTab = Window:NewSection("🌱 Seed Shop")
SeedTab:Button("Open Seed Shop", function()
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Seed_Shop")
    if gui then
        gui.Enabled = true
    end
end)

-- Pet Eggs Section
local PetTab = Window:NewSection("🐣 Pet Eggs")
PetTab:Button("Open Pet UI", function()
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Pet_UI")
    if gui then
        gui.Enabled = true
    end
end)

-- Gear Shop Section
local GearTab = Window:NewSection("⚔️ Gear Shop")
GearTab:Button("Open Gear Shop", function()
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Gear_Shop")
    if gui then
        gui.Enabled = true
    end
end)

-- Event UI Section
local EventTab = Window:NewSection("🎉 Events")
EventTab:Button("Open Event UI", function()
    local gui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Event_UI")
    if gui then
        gui.Enabled = true
    end
end)
