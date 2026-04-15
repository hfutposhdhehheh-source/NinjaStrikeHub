-- [[ MERIDIAN HUB | ระบบล่าโจร V2 ]] --

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "💎 MERIDIAN HUB | ระบบล่าโจร",
   LoadingTitle = "กำลังค้นหาเป้าหมาย...",
   LoadingSubtitle = "by MERIDIAN TEAM",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MeridianData", 
      FileName = "OrbitConfig"
   },
   KeySystem = false -- ปิดระบบคีย์ตามที่แจ้งไว้
})

-- // ตัวแปรตั้งค่า
local Orbiting = false
local SelectedTarget = nil
local Speed = 10
local Radius = 8
local Height = 0

-- // ระบบเช็คไอ้พวกทีมโจร (เช็คละเอียด)
local function isCriminal(player)
    if not player.Team then return false end
    local teamName = player.Team.Name:lower()
    local color = player.TeamColor.Name
    
    -- เช็คชื่อทีม
    if string.find(teamName, "crim") or string.find(teamName, "robber") or string.find(teamName, "bandit") then
        return true
    end
    -- เช็คสีทีม (แดงแบบต่างๆ)
    local redList = {"Bright red", "Really red", "Scarlet", "Persimmon", "Dusty Rose"}
    for _, v in pairs(redList) do
        if color == v then return true end
    end
    return false
end

-- // ดึงรายชื่อโจรสดๆ
local function getCriminalNames()
    local names = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and isCriminal(p) then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then table.insert(names, "ไม่พบโจรในเซิร์ฟ") end
    return names
end

-- // --- [ หน้าหลัก ] --- //
local Tab = Window:CreateTab("🚨 ล่าโจร", 4483362458)

local PlayerDropdown = Tab:CreateDropdown({
   Name = "เลือกเป้าหมาย",
   Options = getCriminalNames(),
   CurrentOption = "",
   MultipleOptions = false,
   Callback = function(Option)
       local targetName = type(Option) == "table" and Option[1] or Option
       SelectedTarget = game.Players:FindFirstChild(targetName)
   end,
})

-- รีเฟรชรายชื่อทุก 3 วิ (กันรายชื่อค้าง)
task.spawn(function()
    while task.wait(3) do
        pcall(function()
            PlayerDropdown:Refresh(getCriminalNames(), true)
        end)
    end
end)

Tab:CreateButton({
   Name = "🎲 สุ่มเป้าหมายโจรทันที",
   Callback = function()
       local criminals = {}
       for _, p in pairs(game.Players:GetPlayers()) do
           if p ~= game.Players.LocalPlayer and isCriminal(p) then table.insert(criminals, p) end
       end
       if #criminals > 0 then
           SelectedTarget = criminals[math.random(1, #criminals)]
           Rayfield:Notify({Title = "MERIDIAN HUB", Content = "ล็อคเป้าหมาย: "..SelectedTarget.Name, Duration = 3})
       else
           Rayfield:Notify({Title = "MERIDIAN HUB", Content = "ตอนนี้ไม่มีโจรให้ล่าเลย", Duration = 3})
       end
   end,
})

Tab:CreateToggle({
   Name = "เริ่มการหมุน (Orbit)",
   CurrentValue = false,
   Callback = function(Value)
       Orbiting = Value
       if Orbiting then
           task.spawn(function()
               while Orbiting do
                   pcall(function()
                       if SelectedTarget and SelectedTarget.Character then
                           local lp = game.Players.LocalPlayer
                           local char = lp.Character
                           local targetRoot = SelectedTarget.Character:FindFirstChild("HumanoidRootPart")
                           local myRoot = char:FindFirstChild("HumanoidRootPart")
                           
                           if targetRoot and myRoot then
                               local targetPos = targetRoot.Position
                               -- เช็คว่ามันขับรถหนีอยู่ไหม
                               local hum = SelectedTarget.Character:FindFirstChild("Humanoid")
                               if hum and hum.SeatPart then
                                   targetPos = hum.SeatPart.Position
                               end

                               local time = tick() * Speed
                               myRoot.CFrame = CFrame.new(targetPos + Vector3.new(math.cos(time) * Radius, Height, math.sin(time) * Radius), targetPos)
                           end
                       end
                   end)
                   task.wait()
               end
           end)
       end
   end,
})

-- // --- [ ปรับแต่ง ] --- //
local ConfigTab = Window:CreateTab("⚙️ ปรับค่า", 4483362458)

ConfigTab:CreateSlider({
    Name = "ความเร็วหมุน",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(V) Speed = V end
})

ConfigTab:CreateSlider({
    Name = "ระยะห่าง",
    Range = {0, 50},
    Increment = 1,
    CurrentValue = 8,
    Callback = function(V) Radius = V end
})

ConfigTab:CreateSlider({
    Name = "ความสูง (ลอยตัว)",
    Range = {-20, 20},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(V) Height = V end
})

Rayfield:Notify({
   Title = "MERIDIAN HUB",
   Content = "สคริปต์พร้อมใช้งานแล้ว ลุยเลย!",
   Duration = 5,
})

