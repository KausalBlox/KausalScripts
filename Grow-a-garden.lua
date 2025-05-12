-- Auto Harvest Script by Kausal

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Grow A Garden Script")

local Tab = Window:NewSection("Auto Farm")

_G.AutoHarvest = false
Tab:CreateToggle("Auto Harvest", function(state)
    _G.AutoHarvest = state
end)

-- Check if a plant has an active proximity prompt
local function CanHarvest(plant)
    local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
    return prompt and prompt.Enabled
end

-- Try to harvest the plant
local function HarvestPlant(plant)
    local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
    if prompt then
        fireproximityprompt(prompt)
    end
end

-- Auto harvesting loop
local function AutoHarvestLoop()
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
            if CanHarvest(plant) then
                HarvestPlant(plant)
            end
        end
    end
end

-- Start harvesting
task.spawn(AutoHarvestLoop)
