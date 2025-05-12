-- ✅ Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ✅ Create Main UI Window
local Window = Rayfield:CreateWindow({
    Name = "🌿 Grow A Garden Hub",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by Kausal",
    ConfigurationSaving = {
        Enabled = false
    },
    MinimumSize = UDim2.new(0, 650, 0, 600) -- Big enough to prevent cutting
})

-- ✅ Main Controls Tab (everything grouped here)
local MainTab = Window:CreateTab("📋 Controls", 4483362458)

--------------------------------------------------
-- 🌾 AUTO FARM SECTION
--------------------------------------------------
MainTab:CreateSection("🌾 Auto Farm")

_G.AutoHarvest = false

MainTab:CreateToggle({
    Name = "Enable Auto Harvest",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoHarvest = Value
    end
})

-- 🔁 Auto Harvest Loop
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

--------------------------------------------------
-- 🌱 SEED SHOP SECTION
--------------------------------------------------
MainTab:CreateSection("🌱 Seed Shop")

MainTab:CreateButton({
    Name = "Open Seed Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Seed_Shop")
        if gui then gui.Enabled = true end
    end
})

--------------------------------------------------
-- 🐣 PET EGGS SECTION
--------------------------------------------------
MainTab:CreateSection("🐣 Pet Eggs")

MainTab:CreateButton({
    Name = "Open Pet Eggs UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Pet_UI")
        if gui then gui.Enabled = true end
    end
})

--------------------------------------------------
-- ⚔️ GEAR SHOP SECTION
--------------------------------------------------
MainTab:CreateSection("⚔️ Gear Shop")

MainTab:CreateButton({
    Name = "Open Gear Shop UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Gear_Shop")
        if gui then gui.Enabled = true end
    end
})

--------------------------------------------------
-- 🎉 EVENT UI SECTION
--------------------------------------------------
MainTab:CreateSection("🎉 Event UI")

MainTab:CreateButton({
    Name = "Open Event UI",
    Callback = function()
        local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Event_UI")
        if gui then gui.Enabled = true end
    end
})
