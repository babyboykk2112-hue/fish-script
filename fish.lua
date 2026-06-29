-- ==============================================================================
-- [ 🛡️ MP FARMING HUB - MASTER CORE (ALL SYSTEMS INTEGRATED) ]
-- ==============================================================================

-- 1. SYSTEM BYPASS (กันเตะ)
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" or Method == "kick" then return nil end
    return OldNamecall(Self, ...)
end)
setreadonly(MT, true)

-- 2. WHITELIST SYSTEM
local WhitelistedUsers = { ["rmko64azqr18"] = true }
local LocalPlayer = game:GetService("Players").LocalPlayer

-- 3. CORE FUNCTIONS (มุดดิน + เดินเนียน)
-- ฟังก์ชันนี้รวมการมุดดิน (Y-8) และการเดินแบบ Linear 10 วินาทีเข้าด้วยกัน
local function SmartMove(x, y, z)
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- มุดลง
    root.CFrame = CFrame.new(root.Position.X, y - 8, root.Position.Z)
    
    -- เดินทางด้วยความเร็วคงที่
    local TweenService = game:GetService("TweenService")
    local info = TweenService:Create(root, TweenInfo.new(10, Enum.EasingStyle.Linear), {CFrame = CFrame.new(x, y - 8, z)})
    info:Play()
    info.Completed:Wait()
    
    -- โผล่ขึ้นมาที่พิกัดปลายทาง
    root.CFrame = CFrame.new(x, y, z)
end

-- 4. UI CONSTRUCTION (รันเฉพาะคนใน Whitelist)
if WhitelistedUsers[LocalPlayer.Name] then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({ Name = "MP FARMING HUB | FINAL", LoadingTitle = "System Ready." })
    local FarmTab = Window:CreateTab("🚜 ระบบฟาร์ม", 4483362458)

    FarmTab:CreateSection("--- แหล่งตกปลา (มุดดิน) ---")
    FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 40]", Callback = function() SmartMove(-501.5, 255.2, 659.8) end })
    FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 70]", Callback = function() SmartMove(-72.6, 255.2, 662.2) end })
    
    FarmTab:CreateSection("--- จัดการ ---")
    FarmTab:CreateButton({ Name = "ไปซื้อเหยื่อ", Callback = function() SmartMove(-136.5, 255.3, 153.8) end })
    FarmTab:CreateButton({ Name = "ไปขายปลา", Callback = function() SmartMove(-253.0, 256.3, 380.3) end })
    
    Rayfield:LoadConfiguration()
else
    warn("Unauthorized User")
end
