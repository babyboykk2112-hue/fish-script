-- [[ หากต้องการปิดใช้งานสคริปต์ทั้งหมดตามือ ให้พิมพ์คำว่า return ไว้หน้าบรรทัดนี้ ]]

-- ==============================================================================
-- [ 🔒 DELTA EXECUTOR ONLY - ล็อคให้รันเฉพาะบน Delta เท่านั้น]
-- ==============================================================================
local current_executor = identifyexecutor and identifyexecutor() or "Unknown"
if not string.find(string.lower(current_executor), "delta") then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Access Denied!",
        Text = "สคริปต์นี้อนุญาตให้รันบน 'Delta' เท่านั้น!",
        Duration = 10
    })
    return
end

-- ==============================================================================
-- [ 🔑 1. ส่วนของ DEVELOPER (คีย์ผู้พัฒนา - ไม่มีวันหมดอายุ)]
-- ==============================================================================
local DeveloperKey = "DEV_MASTER_KANEKI_999"
local DeveloperKey_Alt = "DEV_ADMIN_POWER_777"
local MyUsername = "rmko64azqr18" -- ใส่ชื่อในเกมของพี่

-- ==============================================================================
-- [ 📦 2. ส่วนของ CUSTOMER (คีย์สำหรับลูกค้า)]
-- ==============================================================================
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
-- [ 🛡️ PART 1: SYSTEM BYPASS & ANTI-CHEAT]
-- ==============================================================================
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
local OldIndex = MT.__index
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()
    if Method == "Kick" or Method == "kick" then return nil end
    if Method == "FireServer" and (Self.Name:lower():find("cheat") or Self.Name:lower():find("detection")) then return nil end
    return OldNamecall(Self, ...)
end)
MT.__index = newcclosure(function(Self, Key)
    if Self:IsA("Humanoid") and (Key == "WalkSpeed" or Key == "JumpPower") then
        return OldIndex(Self, Key)
    end
    return OldIndex(Self, Key)
end)
setreadonly(MT, true)

-- ==============================================================================
-- [ 🖥️ PART 2: UI & AUTO FARM FUNCTIONS]
-- ==============================================================================
local Library = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", Library)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Text = "DELTA FISH V6"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = Frame

local AutoFarmBtn = Instance.new("TextButton", Frame)
AutoFarmBtn.Text = "เปิด/ปิด ออโต้ฟาร์ม"
AutoFarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
AutoFarmBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
AutoFarmBtn.Parent = Frame

local AutoFarmEnabled = false
AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    AutoFarmBtn.Text = AutoFarmEnabled and "กำลังฟาร์ม..." or "เปิด/ปิด ออโต้ฟาร์ม"
end)

spawn(function()
    while wait(1) do
        if AutoFarmEnabled then
            print("ระบบกำลังฟาร์มให้พี่ครับ...")
        end
    end
end)
