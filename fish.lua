-- ==============================================================================
-- [ 🛡️ MP FARMING HUB - MASTER CORE (BYPASS + WHITELIST) ]
-- ==============================================================================

-- [ 1. SYSTEM BYPASS (ใส่กลับมาให้ครบถ้วนแล้วครับ) ]
local MT = getrawmetatable(game)
local OldNamecall = MT.__namecall
setreadonly(MT, false)
MT.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if Method == "Kick" or Method == "kick" then 
        return nil 
    end
    return OldNamecall(Self, ...)
end)
setreadonly(MT, true)

-- [ 2. WHITELIST SYSTEM ]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local WhitelistedUsers = { ["rmko64azqr18"] = true } -- ใส่รายชื่อลูกค้าที่นี่

-- [ 3. CORE FUNCTIONS (เดินเนียน) ]
local function SmartMove(targetPos)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then hum:MoveTo(targetPos) end
end

-- [ 4. UI CONSTRUCTION (รันเฉพาะ VIP) ]
if WhitelistedUsers[LocalPlayer.Name] then
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({ Name = "MP FARMING HUB | PRO", LoadingTitle = "System Initializing..." })
    
    local FarmTab = Window:CreateTab("🚜 ระบบฟาร์ม", 4483362458)
    FarmTab:CreateButton({ Name = "ไปตกปลา [Lv. 40]", Callback = function() SmartMove(Vector3.new(-501, 255, 659)) end })
    FarmTab:CreateButton({ Name = "ไปขายปลา", Callback = function() SmartMove(Vector3.new(-253, 256, 380)) end })
    
    Rayfield:LoadConfiguration()
else
    warn("Unauthorized Access")
end
