-- ========================================================
-- MERIDIAN HUB : ULTIMATE PRO SERVER HOPPER & DIAGNOSTICS
-- Theme: Dark-Red Premium | Designed for Mobile & PC
-- ========================================================

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local serverList = {}
local currentIndex = 1
local targetJobId = ""
local isScanning = false
local autoHopActive = false

-- สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MeridianHub_Ultimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- ปุ่มเปิด/ปิด UI (Floating Toggle Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0.02, 0, 0.15, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
ToggleButton.Text = "M"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

-- หน้าต่างหลัก Meridian Hub
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- ขอบเรืองแสงสีแดง Meridian Hub
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(220, 30, 30)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- หัวข้อ Hub
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MERIDIAN HUB : ULTIMATE PRO ⚡"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- ปุ่มปิดหน้าต่าง (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 3)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

-- [ระบบ AI Assistant] กล่องแจ้งสถานะอัจฉริยะ
local StatusBox = Instance.new("Frame")
StatusBox.Size = UDim2.new(0.92, 0, 0, 95)
StatusBox.Position = UDim2.new(0.04, 0, 0, 40)
StatusBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
StatusBox.Parent = MainFrame
Instance.new("UICorner", StatusBox).CornerRadius = UDim.new(0, 8)

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 1, 0)
StatusLabel.Position = UDim2.new(0, 5, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🤖 AI Assistant: ยินดีต้อนรับสู่ Meridian Hub! ระบบพร้อมสแกนหาเซิร์ฟเวอร์ 1 คนแบบเจาะลึกและปลอดภัยสูงสุดแล้วครับ!"
StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextWrapped = true
StatusLabel.Parent = StatusBox

-- [ฟังก์ชัน 1] ปุ่มสแกนหาเซิร์ฟเวอร์ 1 คน (Turbo Scan)
local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(0.92, 0, 0, 38)
ScanBtn.Position = UDim2.new(0.04, 0, 0, 145)
ScanBtn.BackgroundColor3 = Color3.fromRGB(180, 25, 25)
ScanBtn.Text = "🔥 [1] สแกนหาห้อง 1 คน (Turbo Scan)"
ScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanBtn.TextSize = 12
ScanBtn.Font = Enum.Font.SourceSansBold
ScanBtn.Parent = MainFrame
Instance.new("UICorner", ScanBtn).CornerRadius = UDim.new(0, 8)

-- [ฟังก์ชัน 2] ปุ่มสลับห้องถัดไป (→)
local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0.44, 0, 0, 38)
NextBtn.Position = UDim2.new(0.04, 0, 0, 190)
NextBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
NextBtn.Text = "👉 เปลี่ยนห้องถัดไป (→)"
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.TextSize = 11
NextBtn.Font = Enum.Font.SourceSansBold
NextBtn.Parent = MainFrame
Instance.new("UICorner", NextBtn).CornerRadius = UDim.new(0, 8)

-- [ฟังก์ชัน 3] ปุ่มวาปเจาะจง
local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(0.44, 0, 0, 38)
HopBtn.Position = UDim2.new(0.52, 0, 0, 190)
HopBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
HopBtn.Text = "🚀 วาปเจาะจงทันที"
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HopBtn.TextSize = 11
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Parent = MainFrame
Instance.new("UICorner", HopBtn).CornerRadius = UDim.new(0, 8)

-- [ฟังก์ชัน 4] ปุ่มเปิด/ปิด Auto Hop (สลับห้องอัตโนมัติวนไปเรื่อยๆ จนกว่าจะเจอห้องว่าง)
local AutoHopBtn = Instance.new("TextButton")
AutoHopBtn.Size = UDim2.new(0.92, 0, 0, 38)
AutoHopBtn.Position = UDim2.new(0.04, 0, 0, 235)
AutoHopBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
AutoHopBtn.Text = "⚡ [4] ระบบ Auto-Hop ต่อเนื่อง (OFF)"
AutoHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoHopBtn.TextSize = 12
AutoHopBtn.Font = Enum.Font.SourceSansBold
AutoHopBtn.Parent = MainFrame
Instance.new("UICorner", AutoHopBtn).CornerRadius = UDim.new(0, 8)

-- [ฟังก์ชัน 5] แผงข้อมูลเชิงลึก (Diagnostics Info)
local DiagBox = Instance.new("Frame")
DiagBox.Size = UDim2.new(0.92, 0, 0, 105)
DiagBox.Position = UDim2.new(0.04, 0, 0, 280)
DiagBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
DiagBox.Parent = MainFrame
Instance.new("UICorner", DiagBox).CornerRadius = UDim.new(0, 8)

local DiagLabel = Instance.new("TextLabel")
DiagLabel.Size = UDim2.new(1, -10, 1, 0)
DiagLabel.Position = UDim2.new(0, 5, 0, 0)
DiagLabel.BackgroundTransparency = 1
DiagLabel.Text = "📊 Server Diagnostics:\n🌐 ปิง: กำลังโหลด... | FPS: กำลังโหลด...\n🆔 JobID: กำลังตรวจสอบ...\n📌 สถานะแมพ: พร้อมทำงานทุกแพลตฟอร์ม"
DiagLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
DiagLabel.TextSize = 10
DiagLabel.Font = Enum.Font.SourceSans
DiagLabel.TextWrapped = true
DiagLabel.Parent = DiagBox

-- อัปเดตข้อมูลเชิงลึกแบบเรียลไทม์
task.spawn(function()
    local lastTick = tick()
    local frameCount = 0
    local currentFps = 60
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTick >= 1 then
            currentFps = frameCount
            frameCount = 0
            lastTick = tick()
        end
    end)

    while true do
        pcall(function()
            local pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            local shortJob = string.sub(game.JobId, 1, 8) .. "..."
            DiagLabel.Text = string.format("📊 Server Diagnostics:\n🌐 ปิง: %d ms | ⚡ FPS: %d\n🆔 JobID: %s\n📌 สถานะแมพ ID: %s (รองรับทุกแมพ)", 
                pingVal, currentFps, shortJob, tostring(game.PlaceId))
        end)
        task.wait(1)
    end
end)

-- ฟังก์ชันสแกนเซิร์ฟเวอร์แบบเจาะจง
local function fetchServers()
    if isScanning then return end
    isScanning = true
    serverList = {}
    
    StatusLabel.Text = "🤖 AI Assistant: Meridian Hub กำลังกวาดล้างและดึงข้อมูลเซิร์ฟเวอร์ทั้งหมดเพื่อค้นหาห้องที่มีผู้เล่น 1 คนถ้วน โปรดรอสักครู่..."
    
    local success, result = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    isScanning = false
    
    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.playing == 1 and server.id ~= game.JobId then
                table.insert(serverList, {
                    id = server.id,
                    maxPlayers = server.maxPlayers,
                    ping = server.ping or math.random(30, 85)
                })
            end
        end
        
        if #serverList > 0 then
            currentIndex = 1
            targetJobId = serverList[currentIndex].id
            StatusLabel.Text = string.format("🤖 AI Assistant: 🎯 สำเร็จ! เจอห้องที่มีผู้เล่น 1 คน ทั้งหมด %d ห้อง! ล็อคเป้าหมายห้องที่ 1 เรียบร้อย", #serverList)
        else
            -- กรณีแมพนั้นไม่มีเซิร์ฟเวอร์ 1 คนเลย
            StatusLabel.Text = "🤖 AI Assistant: ❌ แจ้งเตือน: เกมนี้ไม่รองรับหรือไม่มีเซิร์ฟเวอร์ที่มี 1 คนในขณะนี้ ลองเปลี่ยนแมพหรือกดสแกนใหม่อีกครั้งครับ!"
            targetJobId = ""
        end
    else
        StatusLabel.Text = "🤖 AI Assistant: ⚠️ เกิดข้อผิดพลาดในการเชื่อมต่อเซิร์ฟเวอร์ API ลองกดใหม่อีกรอบนะ!"
    end
end

ScanBtn.MouseButton1Click:Connect(fetchServers)

-- ปุ่มเปลี่ยนห้อง (→)
NextBtn.MouseButton1Click:Connect(function()
    if #serverList > 0 then
        currentIndex = currentIndex + 1
        if currentIndex > #serverList then
            currentIndex = 1
        end
        targetJobId = serverList[currentIndex].id
        StatusLabel.Text = string.string or string.format("🤖 AI Assistant: 🔄 สลับไปห้องที่ [%d / %d] | 👥 ผู้เล่น: 1 คน | 📶 ปิงจำลอง: ~%d ms", 
            currentIndex, #serverList, serverList[currentIndex].ping)
    else
        StatusLabel.Text = "🤖 AI Assistant: ⚠️ กรุณากดปุ่มสแกนหาห้องก่อนใช้งานปุ่มนี้ครับ!"
    end
end)

-- ปุ่มวาปเจาะจง
HopBtn.MouseButton1Click:Connect(function()
    if targetJobId ~= "" then
        StatusLabel.Text = "🤖 AI Assistant: 🚀 กำลังวาป กรุณารอสักครู่"
        pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, targetJobId, Player)
        end)
    else
        StatusLabel.Text = "🤖 AI Assistant: ⚠️ ยังไม่มีห้องเป้าหมายให้วาป กรุณาสแกนหาก่อนครับ!"
    end
end)

-- ระบบ Auto-Hop ต่อเนื่อง
AutoHopBtn.MouseButton1Click:Connect(function()
    autoHopActive = not autoHopActive
    if autoHopActive then
        AutoHopBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        AutoHopBtn.Text = "⚡ [4] ระบบ Auto-Hop ต่อเนื่อง (ON)"
        StatusLabel.Text = "🤖 AI Assistant: ⚡ เปิดระบบ Auto-Hop แล้ว! ระบบจะทำการสุ่มวาปเปลี่ยนเซิร์ฟเวอร์ไปเรื่อยๆ จนกว่าจะเจอห้องว่างครับ"
        
        task.spawn(function()
            while autoHopActive do
                pcall(function()
                    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                    local res = HttpService:JSONDecode(game:HttpGet(url))
                    if res and res.data then
                        for _, srv in ipairs(res.data) do
                            if srv.playing == 1 and srv.id ~= game.JobId then
                                TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, Player)
                                task.wait(5)
                            end
                        end
                    end
                end)
                task.wait(3)
            end
        end)
    else
        AutoHopBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
        AutoHopBtn.Text = "⚡ [4] ระบบ Auto-Hop ต่อเนื่อง (OFF)"
        StatusLabel.Text = "🤖 AI Assistant: ปิดระบบ Auto-Hop เรียบร้อย."
    end
end)
