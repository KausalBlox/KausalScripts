-- Grow a Garden Auto Harvest Script by Kausal

-- Load Wizard UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Grow A Garden Script")

local Tab = Window:NewSection("Auto Farm")

print("✅ Kausal's script started")
task.wait(1)

-- Toggle state
_G.AutoHarvest = false
Tab:CreateToggle("Auto Harvest", function(state)
    _G.AutoHarvest = state
end)

-- Check if a plant is harvestable
local function CanHarvest(plant)
    local prompt = plant:FindFirstChild("ProximityPrompt", true)
    return prompt and prompt.Enabled
end

-- Harvest a single plant
local function HarvestPlant(plant)
    local prompt = plant:FindFirstChild("ProximityPrompt", true)
    if prompt then
        fireproximityprompt(prompt)
    end
end

-- Auto harvest loop
local function AutoHarvestLoop()
    while true do
        if _G.AutoHarvest then
            local player = game.Players.LocalPlayer
            local farm = workspace:FindFirstChild("Farm")
            if farm then
                local myFarm = farm:FindFirstChild(player.Name)
                if myFarm and myFarm:FindFirstChild("Important") then
                    local plantsFolder = myFarm.Important:FindFirstChild("Plants_Physical")
                    if plantsFolder then
                        for _, plant in ipairs(plantsFolder:GetChildren()) do
                            if CanHarvest(plant) then
                                HarvestPlant(plant)
                            end
                        end
                    end
                end
            end
        end
        wait(1)
    end
end

-- Start the loop
spawn(AutoHarvestLoop)

