-- ==============================================================================
-- [ 🛡️ MP FARMING HUB - MASTER CORE (PRO UPGRADE) ]
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

-- 2. ACCESS MANAGEMENT (รักษาข้อมูลลูกค้าและ VIP ไว้ครบถ้วน)
local DeveloperKey = "DEV_MASTER_KANEKI_999"
local WhitelistedUsers = { ["rmko64azqr18"] = true }
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

local Window = Rayfield:CreateWindow({ Name = "MP FARMING HUB | PRO", LoadingTitle = "Loading Advanced System...", ConfigurationSaving = { Enabled = true, FolderName = "MP_Hub" } })

-- [ อัปเกรด: ตัวแปรตั้งค่าการทำงาน (Config Table) ]
local Config = { BaitAmount = 10, SelectedRod = "Basic" }

-- [ อัปเกรด: ฟังก์ชันเคลื่อนที่แบบเนียน (Linear 10s) ]
local function SmartMove(x, y, z, action)
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    root.CFrame = CFrame.new(root.Position.X, y - 8, root.Position.Z)
    local info = TweenService:Create(root, TweenInfo.new(10, Enum.EasingStyle.Linear), {CFrame = CFrame.new(x, y - 8, z)})
    info:Play() info.Completed:Wait()
    if action == "FINISH" then root.CFrame = CFrame.new(x, y, z) end
end

-- [ ส่วนเมนู ]
local KeyTab = Window:CreateTab("🔐 Authentication", 4483362458)
local FarmTab = Window:CreateTab("🚜 MP Farming", 4483362458)
local SetTab = Window:CreateTab("⚙️ Settings", 4483362458)

-- [ เมนูตั้งค่า (อัปเกรดให้ปรับค่าเองได้เหมือน Hermanos) ]
SetTab:CreateSlider({ Name = "จำนวนเหยื่อที่จะซื้อ", Range = {1, 100}, Increment = 1, Callback = function(V) Config.BaitAmount = V end })
SetTab:CreateDropdown({ Name = "เลือกประเภทเบ็ด", Options = {"Basic", "Pro", "Master"}, Callback = function(V) Config.SelectedRod = V end })

-- [ เมนูฟาร์ม ]
FarmTab:CreateSection("--- แหล่งฟาร์ม ---")
FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 40]", Callback = function() SmartMove(-501.5, 255.2, 659.8, "FINISH") end })
FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 70]", Callback = function() SmartMove(-72.6, 255.2, 662.2, "FINISH") end })

FarmTab:CreateSection("--- จัดการสินค้า ---")
FarmTab:CreateButton({ Name = "ไปซื้อเหยื่อ/เบ็ด (ตามจำนวนที่ตั้งค่า)", Callback = function() 
    print("ซื้อเหยื่อจำนวน: " .. Config.BaitAmount .. " ด้วยเบ็ด: " .. Config.SelectedRod)
    SmartMove(-136.5, 255.3, 153.8, "FINISH") 
end })
FarmTab:CreateButton({ Name = "ไปขายปลา", Callback = function() SmartMove(-253.0, 256.3, 380.3, "FINISH") end })

Rayfield:LoadConfiguration()
