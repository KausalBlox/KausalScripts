-- Load Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🌿 Grow A Garden Hub", "DarkTheme")

-- Auto Farm Tab
local AutoFarmTab = Window:NewTab("🌾 Auto Farm")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm Features")

-- Toggles
_G.AutoHarvest = false
_G.AutoPlant = false
_G.AutoBuy = false
_G.AutoSell = false
_G.SellThreshold = 15
_G.SelectedSeedName = nil

-- Get UI references
local player = game.Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")
local Character = player.Character or player.CharacterAdded:Wait()
local Farm = workspace:WaitForChild("Farm")
local MyFarm = Farm:FindFirstChild(player.Name)
local Important = MyFarm and MyFarm:WaitForChild("Important")
local PlantLocations = Important and Important:WaitForChild("Plant_Locations")
local PlantsPhysical = Important and Important:WaitForChild("Plants_Physical")
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")

-- 🧠 Functions

local function firePrompt(object)
    if object and object:IsA("ProximityPrompt") and object.Enabled then
        fireproximityprompt(object)
    end
end

local function getRandomPoint()
    local lands = PlantLocations:GetChildren()
    if #lands == 0 then return end
    local land = lands[math.random(1, #lands)]
    local pos = land.Position
    return Vector3.new(pos.X + math.random(-2, 2), 0.13, pos.Z + math.random(-2, 2))
end

local function getSeedTool(seedName)
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool.Name == seedName then return tool end
    end
    for _, tool in ipairs(Character:GetChildren()) do
        if tool.Name == seedName then return tool end
    end
end

local function countInventoryCrops()
    local count = 0
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:FindFirstChild("Item_String") then count += 1 end
    end
    for _, tool in ipairs(Character:GetChildren()) do
        if tool:FindFirstChild("Item_String") then count += 1 end
    end
    return count
end

-- 🌿 Auto Harvest
AutoFarmSection:NewToggle("Auto Harvest", "Automatically harvest plants", false, function(state)
    _G.AutoHarvest = state
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoHarvest and PlantsPhysical then
            for _, plant in pairs(PlantsPhysical:GetChildren()) do
                firePrompt(plant:FindFirstChildWhichIsA("ProximityPrompt", true))
            end
        end
    end
end)

-- 🌱 Auto Plant
AutoFarmSection:NewToggle("Auto Plant", "Automatically plants selected seed", false, function(state)
    _G.AutoPlant = state
end)

task.spawn(function()
    while task.wait(2) do
        if _G.AutoPlant and _G.SelectedSeedName and GameEvents then
            local tool = getSeedTool(_G.SelectedSeedName)
            if tool then
                player.Character.Humanoid:EquipTool(tool)
                for i = 1, 5 do
                    GameEvents.Plant_RE:FireServer(getRandomPoint(), _G.SelectedSeedName)
                    wait(0.3)
                end
            end
        end
    end
end)

-- 🧪 Select Seed to Auto Plant/Buy
AutoFarmSection:NewTextbox("Seed Name", "Type seed name (case-sensitive)", function(value)
    _G.SelectedSeedName = value
end)

-- 🛒 Auto Buy Seeds
AutoFarmSection:NewToggle("Auto Buy Seed", "Buys the selected seed repeatedly", false, function(state)
    _G.AutoBuy = state
end)

task.spawn(function()
    while task.wait(2) do
        if _G.AutoBuy and _G.SelectedSeedName and GameEvents then
            GameEvents.BuySeedStock:FireServer(_G.SelectedSeedName)
        end
    end
end)

-- 💰 Auto Sell Crops
AutoFarmSection:NewToggle("Auto Sell", "Sells inventory when crop count exceeds threshold", false, function(state)
    _G.AutoSell = state
end)

AutoFarmSection:NewSlider("Sell Threshold", "Crop count before auto-selling", 1, 200, 15, function(value)
    _G.SellThreshold = value
end)

task.spawn(function()
    while task.wait(1) do
        if _G.AutoSell and countInventoryCrops() >= _G.SellThreshold then
            local before = player.leaderstats.Sheckles.Value
            local root = Character:FindFirstChild("HumanoidRootPart")
            if root then
                local oldPos = root.CFrame
                root.CFrame = CFrame.new(62, 4, -26)
                GameEvents.Sell_Inventory:FireServer()
                wait(1)
                root.CFrame = oldPos
            end
        end
    end
end)
