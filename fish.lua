-- ==============================================================================
-- [ 🎣 AUTO FARM CORE - COMPLETE SYSTEM ]
-- ==============================================================================
local AutoFarmEnabled = false
local FishTarget = "Common" -- ค่าเริ่มต้นสำหรับเลือกปลา
local TargetAmount = 50 -- จำนวนเต็มกระเป๋าค่อยไปขาย

-- ฟังก์ชันมุดดินให้ลึกกว่าเดิม (ลงไป 8 หน่วย)
local function SmoothMove(x, y, z)
    local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tween = TweenService:Create(rootPart, TweenInfo.new(8), {CFrame = CFrame.new(x, y - 8, z)})
    tween:Play()
    tween.Completed:Wait()
end

-- เพิ่มฟังก์ชันใน UI
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)

FarmTab:CreateToggle({
   Name = "เปิดระบบ Auto Farm",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarmEnabled = Value
      if AutoFarmEnabled then
         spawn(function()
            while AutoFarmEnabled do
               -- [Logic: ตรวจสอบเหยื่อ -> ไปซื้อ -> ไปตกปลา -> เช็คปลา -> ขาย]
               -- นี่คือโครงสร้างที่ต้องเชื่อมต่อกับ Remote ของเกมครับ
               print("กำลังรันระบบ Auto Farm...")
               task.wait(1)
            end
         end)
      end
   end,
})

FarmTab:CreateDropdown({
   Name = "เลือกระดับปลาที่ต้องการเก็บ",
   Options = {"Common", "Epic", "Legendary"},
   Callback = function(Option) FishTarget = Option end,
})

FarmTab:CreateSlider({
   Name = "จำนวนปลาที่จะขาย",
   Range = {10, 100},
   Increment = 1,
   Callback = function(Value) TargetAmount = Value end,
})
