-- [[ หากต้องการปิดใช้งานสคริปต์ทั้งหมดคามือ ให้พิมพ์คำว่า return ไว้หน้าบรรทัดนี้ ]]

-- =================================================================
-- [🔒 DELTA EXECUTOR ONLY - ล็อคให้รันเฉพาะบน Delta เท่านั้น]
-- =================================================================
local current_executor = identifyexecutor and identifyexecutor() or "Unknown"
if not string.find(string.lower(current_executor), "delta") then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Access Denied!",
        Text = "สคริปต์นี้อนุญาตให้รันบน 'Delta' เท่านั้น!",
        Duration = 10
    })
    return 
end

-- =================================================================
-- [🔑 1. ส่วนของ DEVELOPER (คีย์ผู้พัฒนา - ไม่มีวันหมดอายุ)]
-- =================================================================
local DeveloperKey     = "DEV_MASTER_KANEKI_999"  -- คีย์ผู้พัฒนาอันที่ 1 (ถ้าหลุดมาแก้ชื่อที่นี่ได้เลย)
local DeveloperKey_Alt = "DEV_ADMIN_POWER_777"   -- คีย์ผู้พัฒนาอันที่ 2
local MyUsername       = "ชื่อในเกมของคุณ"            -- ใส่ชื่อในเกมของพี่เพื่อข้ามหน้าใส่คีย์อัตโนมัติ

-- =================================================================
-- [🎫 2. ส่วนของ CUSTOMER (คีย์สำหรับลูกค้า 10 คีย์พร้อมใช้)]
-- ระบบจะเริ่มนับถอยหลัง 1 วัน (24 ชั่วโมง) ทันทีหลังจากการกดใช้งานครั้งแรก
-- =================================================================
local CustomerKeys = {
    ["KANEKI_USER_7x9B2pQ"] = true,
    ["KANEKI_USER_1m4V8wK"] = true,
    ["KANEKI_USER_6z3R5tN"] = true,
    ["KANEKI_USER_9b2X7vL"] = true,
    ["KANEKI_USER_3f8👁️4k"] = true,
    ["GHOUL_KEY_2w8M4qZ"]   = true,
    ["GHOUL_KEY_5t1X9vB"]   = true,
    ["GHOUL_KEY_8n3P7mK"]   = true,
    ["GHOUL_KEY_1c6Z4wL"]   = true,
    ["GHOUL_KEY_7v9F2rX"]   = true,
}

-- รูปภาพ Kaneki Ken สำหรับใช้เป็นพื้นหลัง UI (ลิงก์จาก Roblox Asset)
local KanekiBackgroundImage = "rbxassetid://1000059213"

-- =================================================================
-- [🛡️ PART 1: SYSTEM BYPASS & ANTI-CHEAT]
-- =================================================================
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
        if Key == "WalkSpeed" then return 16 end
        if Key == "JumpPower" then return 50 end
    end
    return OldIndex(Self, Key)
end)
setreadonly(MT, true)

-- =================================================================
-- [🎨 PART 2: MAIN SCRIPT FUNCTION (DELTA FISH V6)]
-- =================================================================
local player = game.Players.LocalPlayer

local function StartMainScript()
    local TweenService = game:GetService("TweenService")
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("ImageLabel") 
    local MainScroll = Instance.new("ScrollingFrame")
    local Title = Instance.new("TextLabel")

    local ToggleSizeBtn = Instance.new("TextButton") 
    local ToggleMinBtn = Instance.new("TextButton")  

    local MoveTitle = Instance.new("TextLabel")
    local GoShopBtn = Instance.new("TextButton")
    local GoSea40Btn = Instance.new("TextButton")
    local GoSea70Btn = Instance.new("TextButton")
    local GoSellBtn = Instance.new("TextButton")

    local ToggleUG = Instance.new("TextButton")
    local ToggleAutoFish = Instance.new("TextButton")

    local FilterTitle = Instance.new("TextLabel")
    local TakeGray = Instance.new("TextButton")
    local TakeGreen = Instance.new("TextButton")
    local TakePurple = Instance.new("TextButton")
    local TakeGold = Instance.new("TextButton")

    local ShopTitle = Instance.new("TextLabel")
    local SelectRodBtn = Instance.new("TextButton")
    local SelectBaitBtn = Instance.new("TextButton")

    MainFrame.Name = "MyDeltaExclusiveFisher"
    MainFrame.Parent = ScreenGui
    MainFrame.Image = KanekiBackgroundImage
    MainFrame.ImageColor3 = Color3.fromRGB(180, 180, 180) 
    MainFrame.ScaleType = Enum.ScaleType.Crop
    MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
    MainFrame.Size = UDim2.new(0, 250, 0, 460) 
    MainFrame.Active = true
    MainFrame.Draggable = true

    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, -75, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Title.BackgroundTransparency = 0.3 
    Title.Text = " 💀 DELTA FISH V6"
    Title.TextColor3 = Color3.fromRGB(255, 85, 85)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextSize = 13

    MainScroll.Parent = MainFrame
    MainScroll.Position = UDim2.new(0, 0, 0, 40)
    MainScroll.Size = UDim2.new(1, 0, 1, -40)
    MainScroll.BackgroundTransparency = 1
    MainScroll.CanvasSize = UDim2.new(0, 0, 0, 800)
    MainScroll.ScrollBarThickness = 6

    local isMinimized = false
    local isLargeSize = false

    ToggleMinBtn.Parent = MainFrame
    ToggleMinBtn.Size = UDim2.new(0, 35, 0, 40)
    ToggleMinBtn.Position = UDim2.new(1, -35, 0, 0)
    ToggleMinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleMinBtn.BackgroundTransparency = 0.3
    ToggleMinBtn.Text = "-"
    ToggleMinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleMinBtn.TextSize = 18

    ToggleSizeBtn.Parent = MainFrame
    ToggleSizeBtn.Size = UDim2.new(0, 40, 0, 40)
    ToggleSizeBtn.Position = UDim2.new(1, -75, 0, 0)
    ToggleSizeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ToggleSizeBtn.BackgroundTransparency = 0.3
    ToggleSizeBtn.Text = "🔍"
    ToggleSizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleSizeBtn.TextSize = 14

    ToggleMinBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            MainScroll.Visible = false
            ToggleSizeBtn.Visible = false
            Title.Text = ""
            MainFrame.Size = UDim2.new(0, 40, 0, 40)
            ToggleMinBtn.Position = UDim2.new(0, 0, 0, 0)
            ToggleMinBtn.Text = "+"
            ToggleMinBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
            ToggleMinBtn.BackgroundTransparency = 0.6
        else
            MainScroll.Visible = true
            ToggleSizeBtn.Visible = true
            Title.Text = " 💀 DELTA FISH V6"
            ToggleMinBtn.Text = "-"
            ToggleMinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ToggleMinBtn.BackgroundTransparency = 0.3
            if isLargeSize then
                MainFrame.Size = UDim2.new(0, 350, 0, 600)
                ToggleMinBtn.Position = UDim2.new(1, -35, 0, 0)
            else
                MainFrame.Size = UDim2.new(0, 250, 0, 460)
                ToggleMinBtn.Position = UDim2.new(1, -35, 0, 0)
            end
        end
    end)

    ToggleSizeBtn.MouseButton1Click:Connect(function()
        if isMinimized then return end 
        isLargeSize = not isLargeSize
        if isLargeSize then
            MainFrame.Size = UDim2.new(0, 350, 0, 600)
            MainScroll.CanvasSize = UDim2.new(0, 0, 0, 1000)
            Title.Text = " 💀 DELTA FISH V6 (โหมดจอใหญ่)"
        else
            MainFrame.Size = UDim2.new(0, 250, 0, 460)
            MainScroll.CanvasSize = UDim2.new(0, 0, 0, 800)
            Title.Text = " 💀 DELTA FISH V6"
        end
    end)

    local Locations = {
        Shop = Vector3.new(-136.5, 255.3, 153.8),     
        Sea_Lv70 = Vector3.new(-72.6, 255.2, 662.2),  
        SellNPC = Vector3.new(-253.0, 256.3, 380.3),   
        Sea_Lv40 = Vector3.new(-501.5, 255.2, 659.8)   
    }

    local Config = {
        Common = false, Uncommon = false, Epic = true, Legendary = true,
        SelectedRod = "Pro Fishing Rod",
        SelectedBait = "Wormtec Ultimate"
    }

    local RodList = {"Pro Fishing Rod", "Advanced Fishing Rod", "Ultimate Fishing Rod"}
    local BaitList = {"Wormtec Ultimate", "Prawntec Regular", "Prawntec Pro", "Prawntec Ultimate"}
    local currentRodIndex = 1
    local currentBaitIndex = 1

    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    function _G.FlyTo(targetPosition, speed)
        if not hrp then return end
        local distance = (hrp.Position - targetPosition).Magnitude
        local duration = distance / speed
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 4, 0)
        task.wait(0.1)
        local bv = Instance.new("BodyVelocity")
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = hrp
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPosition)})
        tween:Play()
        tween.Completed:Wait()
        bv:Destroy()
    end

    MoveTitle.Parent = MainScroll; MoveTitle.Position = UDim2.new(0, 0, 0.01, 0); MoveTitle.Size = UDim2.new(1, 0, 0, 25); MoveTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MoveTitle.BackgroundTransparency = 0.4; MoveTitle.Text = "--- โหมดลอยตัวเดินทาง ---"; MoveTitle.TextColor3 = Color3.fromRGB(150, 255, 150); MoveTitle.TextSize = 11
    GoShopBtn.Parent = MainScroll; GoShopBtn.Position = UDim2.new(0.05, 0, 0.05, 0); GoShopBtn.Size = UDim2.new(0.42, 0, 0, 35); GoShopBtn.BackgroundColor3 = Color3.fromRGB(50, 80, 130); GoShopBtn.BackgroundTransparency = 0.2; GoShopBtn.Text = "ลอยไปร้านของ"; GoShopBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GoShopBtn.MouseButton1Click:Connect(function() _G.FlyTo(Locations.Shop, 40) end)
    GoSellBtn.Parent = MainScroll; GoSellBtn.Position = UDim2.new(0.53, 0, 0.05, 0); GoSellBtn.Size = UDim
