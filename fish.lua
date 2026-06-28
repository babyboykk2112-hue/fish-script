-- ==============================================================================
-- [ 🛡️ 1. SYSTEM BYPASS & ANTI-CHEAT ]
-- ==============================================================================
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" or Method == "kick" then return nil end
    return OldNamecall(Self, ...)
end)
setreadonly(MT, true)

-- ==============================================================================
-- [ 🔑 2. SECURITY & CUSTOMER KEYS ]
-- ==============================================================================
local DeveloperKey = "DEV_MASTER_KANEKI_999"
local CustomerKeys = {
    ["KANEKI_USER_7x9B2pQ"] = true,
    ["KANEKI_USER_1m4V8wK"] = true,
    ["KANEKI_USER_6z3R5tN"] = true,
    ["KANEKI_USER_9b2X7vL"] = true,
    ["KANEKI_USER_3f8🌸4K"] = true,
    ["GHOUL_KEY_2w8M4qZ"] = true,
    ["GHOUL_KEY_5t1X9vB"] = true,
    ["GHOUL_KEY_8n3P7mK"] = true,
    ["GHOUL_KEY_1c6Z4wL"] = true,
    ["GHOUL_KEY_7v9F2rX"] = true,
}

-- ==============================================================================
-- [ 🖥️ 3. RAYFIELD UI & TELEPORT FUNCTIONS ]
-- ==============================================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "DELTA FISH V6 - COMPLETE EDITION",
   LoadingTitle = "กำลังตรวจสอบความปลอดภัย...",
   LoadingSubtitle = "by พี่เอง",
   ConfigurationSaving = { Enabled = true, FolderName = "FishFarm" }
})

local Tab = Window:CreateTab("Teleport", 4483362458)

local function Teleport(x, y, z)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end

-- เพิ่มปุ่มวาร์ปครบทุกจุด
Tab:CreateButton({ Name = "ไปร้านซื้อเหยื่อ", Callback = function() Teleport(-136.5, 255.3, 153.8) end })
Tab:CreateButton({ Name = "ไปตกปลา Lv 70", Callback = function() Teleport(-72.6, 255.2, 662.2) end })
Tab:CreateButton({ Name = "ไปตกปลา Lv 40", Callback = function() Teleport(-501.5, 255.2, 659.8) end })
Tab:CreateButton({ Name = "ไปขายปลา", Callback = function() Teleport(-253.0, 256.3, 380.3) end })

Rayfield:LoadConfiguration()
