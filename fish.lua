-- ==============================================================================
-- [ 🛡️ MP FARMING HUB - MASTER CORE (RESTORED KEYS + VIP) ]
-- ==============================================================================

-- 1. SYSTEM BYPASS (กันโดนเตะ)
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" or Method == "kick" then return nil end
    return OldNamecall(Self, ...)
end)
setreadonly(MT, true)

-- 2. ACCESS MANAGEMENT (คีย์ลูกค้าครบชุด + VIP พี่)
local DeveloperKey = "DEV_MASTER_KANEKI_999"
local WhitelistedUsers = {
    ["rmko64azqr18"] = true, -- ชื่อพิเศษที่ไม่ต้องใช้คีย์
}
local CustomerKeys = {
    ["KANEKI_USER_7x9B2pQ"] = true, ["KANEKI_USER_1m4V8wK"] = true,
    ["KANEKI_USER_6z3R5tN"] = true, ["KANEKI_USER_9b2X7vL"] = true,
    ["KANEKI_USER_3f8🌸4K"] = true, ["GHOUL_KEY_2w8M4qZ"] = true,
    ["GHOUL_KEY_5t1X9vB"] = true, ["GHOUL_KEY_8n3P7mK"] = true,
    ["GHOUL_KEY_1c6Z4wL"] = true, ["GHOUL_KEY_7v9F2rX"] = true,
}

-- 3. UI & FUNCTIONS
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันตรวจสอบสิทธิ์
local function CheckAccess()
    if WhitelistedUsers[LocalPlayer.Name] then return true end
    return false
end

local Window = Rayfield:CreateWindow({
   Name = "MP FARMING HUB | PRO",
   LoadingTitle = "กำลังโหลดระบบ MP HUB...",
   LoadingSubtitle = "by พี่เอง",
   ConfigurationSaving = { Enabled = true, FolderName = "MP_Hub" }
})

local KeyTab = Window:CreateTab("🔐 Authentication", 4483362458)
local FarmTab = Window:CreateTab("🚜 MP Farming", 4483362458)

-- ระบบล็อก UI (เช็คทั้งชื่อ VIP และคีย์ลูกค้า)
local IsUnlocked = CheckAccess()
if IsUnlocked then
    KeyTab:CreateLabel("สถานะ: คุณคือ VIP เข้าใช้งานได้เลย!")
else
    local InputKey = ""
    KeyTab:CreateInput({ Name = "กรอกคีย์ของคุณ", PlaceholderText = "ใส่คีย์...", Callback = function(V) InputKey = V end })
    KeyTab:CreateButton({ Name = "ตรวจสอบคีย์", Callback = function()
        if InputKey == DeveloperKey or CustomerKeys[InputKey] then
            Rayfield:Notify({Title = "สำเร็จ", Content = "คีย์ถูกต้อง ยินดีต้อนรับ!", Duration = 5})
        else
            Rayfield:Notify({Title = "ผิดพลาด", Content = "คีย์ไม่ถูกต้องครับ", Duration = 5})
        end
    end })
end

-- ฟังก์ชันเคลื่อนที่ (Smart Move)
local function SmartMove(x, y, z, actionType)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local tweenDown = TweenService:Create(root, TweenInfo.new(2), {CFrame = CFrame.new(root.Position.X, y - 8, root.Position.Z)})
        tweenDown:Play() tweenDown.Completed:Wait()
        local tweenMove = TweenService:Create(root, TweenInfo.new(5), {CFrame = CFrame.new(x, y - 8, z)})
        tweenMove:Play() tweenMove.Completed:Wait()
        if actionType then
            local tweenUp = TweenService:Create(root, TweenInfo.new(1), {CFrame = CFrame.new(x, y, z)})
            tweenUp:Play()
        end
    end
end

-- ส่วนฟาร์ม
FarmTab:CreateSection("--- ระบบบอทฟาร์ม ---")
FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 40] (มุดดิน)", Callback = function() SmartMove(-501.5, 255.2, 659.8, nil) end })
FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 70] (มุดดิน)", Callback = function() SmartMove(-72.6, 255.2, 662.2, nil) end })
FarmTab:CreateSection("--- การจัดการสินค้า ---")
FarmTab:CreateButton({ Name = "ไปซื้อเหยื่อ/เบ็ด", Callback = function() SmartMove(-136.5, 255.3, 153.8, "BUY") end })
FarmTab:CreateButton({ Name = "ไปขายปลา", Callback = function() SmartMove(-253.0, 256.3, 380.3, "SELL") end })

Rayfield:LoadConfiguration()
