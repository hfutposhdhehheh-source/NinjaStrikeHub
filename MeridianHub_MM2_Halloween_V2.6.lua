----------------------------------------------------------------------------------------------------
-- 🎃 MERIDIAN HUB // HALLOWEEN GOD MODE EDITION (V4.3 - FINAL STABLE APEX) 👻
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- [1] ระบบเซฟการตั้งค่าอัตโนมัติ (Config Manager)
local CONFIG_FILE = "MeridianHub_MM2_Config_V4.3.json"
local HubConfig = {
    WalkSpeed = 16,
    JumpPower = 50,
    FOVRadius = 120,
    FlySpeed = 16,
    FlyMode = "ปกติ",
    GunGrabMode = "วาปปืนเข้าตัว",
    HitboxSize = 12
}

pcall(function()
    if readfile and isfile and isfile(CONFIG_FILE) then
        local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
        for k, v in pairs(data) do HubConfig[k] = v end
    end
end)

local function saveConfig()
    pcall(function()
        if writefile then
            writefile(CONFIG_FILE, HttpService:JSONEncode(HubConfig))
        end
    end)
end

-- ป้องกันซ้ำและเคลียร์ของเดิมทิ้งแบบปลอดภัย 100%
pcall(function()
    if CoreGui:FindFirstChild("MeridianApexStructuralContainer") then CoreGui.MeridianApexStructuralContainer:Destroy() end
    if CoreGui:FindFirstChild("MM2FloatButtonsGui") then CoreGui.MM2FloatButtonsGui:Destroy() end
    if CoreGui:FindFirstChild("MeridianLoadingGui") then CoreGui.MeridianLoadingGui:Destroy() end
    if CoreGui:FindFirstChild("MeridianLangGui") then CoreGui.MeridianLangGui:Destroy() end
    if CoreGui:FindFirstChild("MeridianTracersGui") then CoreGui.MeridianTracersGui:Destroy() end
    if CoreGui:FindFirstChild("MeridianToggleHubGui") then CoreGui.MeridianToggleHubGui:Destroy() end
end)

----------------------------------------------------------------------------------------------------
-- [2] รากฐาน GUI & ระบบหน้าต่าง
----------------------------------------------------------------------------------------------------
local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "MeridianApexStructuralContainer"
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RootContainerNode.Enabled = false
pcall(function() RootContainerNode.Parent = CoreGui end)
if not RootContainerNode.Parent then RootContainerNode.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local FloatGui = Instance.new("ScreenGui")
FloatGui.Name = "MM2FloatButtonsGui"
FloatGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FloatGui.Enabled = false
pcall(function() FloatGui.Parent = CoreGui end)
if not FloatGui.Parent then FloatGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local TracersGui = Instance.new("ScreenGui")
TracersGui.Name = "MeridianTracersGui"
TracersGui.IgnoreGuiInset = true
TracersGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TracersGui.Enabled = false
pcall(function() TracersGui.Parent = CoreGui end)
if not TracersGui.Parent then TracersGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

----------------------------------------------------------------------------------------------------
-- [3] ระบบ Toast แจ้งเตือนสไตล์ฮาโลวีน (แสดงผล 1 วินาทีเป๊ะๆ ตามสั่ง)
----------------------------------------------------------------------------------------------------
local ToastNotificationHub = Instance.new("Frame")
ToastNotificationHub.Name = "ToastHub"
ToastNotificationHub.Parent = RootContainerNode
ToastNotificationHub.BackgroundTransparency = 1
ToastNotificationHub.Position = UDim2.new(1, -310, 0, 20)
ToastNotificationHub.Size = UDim2.new(0, 290, 0, 300)
ToastNotificationHub.ZIndex = 50

local toastLayout = Instance.new("UIListLayout")
toastLayout.Parent = ToastNotificationHub
toastLayout.SortOrder = Enum.SortOrder.LayoutOrder
toastLayout.Padding = UDim.new(0, 6)
toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local function triggerHalloweenToast(messageTitle, messageBody, notificationType)
    task.spawn(function()
        local accentColor = Color3.fromRGB(255, 140, 0)
        if notificationType == "SUCCESS" then accentColor = Color3.fromRGB(255, 140, 0)
        elseif notificationType == "WARNING" then accentColor = Color3.fromRGB(168, 85, 247)
        elseif notificationType == "ERROR" then accentColor = Color3.fromRGB(239, 68, 68) end

        local toastCard = Instance.new("Frame")
        toastCard.Parent = ToastNotificationHub
        toastCard.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
        toastCard.Size = UDim2.new(1, 0, 0, 48)
        toastCard.Position = UDim2.new(1, 50, 0, 0)
        toastCard.ZIndex = 51
        Instance.new("UICorner", toastCard).CornerRadius = UDim.new(0, 8)

        local toastStroke = Instance.new("UIStroke")
        toastStroke.Color = accentColor
        toastStroke.Thickness = 1.5
        toastStroke.Transparency = 0.2
        toastStroke.Parent = toastCard

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Parent = toastCard
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0, 10, 0, 6)
        titleLabel.Size = UDim2.new(1, -15, 0, 16)
        titleLabel.Font = Enum.Font.Code
        titleLabel.Text = "🎃 " .. tostring(messageTitle or "Notification")
        titleLabel.TextColor3 = accentColor
        titleLabel.TextSize = 10
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = 52

        local bodyLabel = Instance.new("TextLabel")
        bodyLabel.Parent = toastCard
        bodyLabel.BackgroundTransparency = 1
        bodyLabel.Position = UDim2.new(0, 10, 0, 22)
        bodyLabel.Size = UDim2.new(1, -15, 0, 18)
        bodyLabel.Font = Enum.Font.Code
        bodyLabel.Text = tostring(messageBody or "")
        bodyLabel.TextColor3 = Color3.fromRGB(216, 180, 254)
        bodyLabel.TextSize = 9
        bodyLabel.TextXAlignment = Enum.TextXAlignment.Left
        bodyLabel.ZIndex = 52

        TweenService:Create(toastCard, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(1.0) -- แสดงผล 1 วินาทีถ้วน
        TweenService:Create(toastCard, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.2)
        toastCard:Destroy()
    end)
end

----------------------------------------------------------------------------------------------------
-- [4] หน้าจอโหลดสคริปต์ (Loading Screen 5 วินาที)
----------------------------------------------------------------------------------------------------
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "MeridianLoadingGui"
LoadingGui.IgnoreGuiInset = true
pcall(function() LoadingGui.Parent = CoreGui end)
if not LoadingGui.Parent then LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = LoadingGui
LoadFrame.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.ZIndex = 100

local LoadCard = Instance.new("Frame")
LoadCard.Parent = LoadFrame
LoadCard.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
LoadCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoadCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadCard.Size = UDim2.new(0, 380, 0, 210)
LoadCard.ZIndex = 101
Instance.new("UICorner", LoadCard).CornerRadius = UDim.new(0, 14)

local LoadStroke = Instance.new("UIStroke")
LoadStroke.Color = Color3.fromRGB(255, 140, 0)
LoadStroke.Thickness = 2
LoadStroke.Transparency = 0.2
LoadStroke.Parent = LoadCard

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Parent = LoadCard
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 20, 0, 20)
LoadTitle.Size = UDim2.new(1, -40, 0, 24)
LoadTitle.Font = Enum.Font.Code
LoadTitle.Text = "🎃 MERIDIAN HUB // V4.3 FINAL 👻"
LoadTitle.TextColor3 = Color3.fromRGB(255, 165, 0)
LoadTitle.TextSize = 12
LoadTitle.TextXAlignment = Enum.TextXAlignment.Left
LoadTitle.ZIndex = 102

local LoadSub = Instance.new("TextLabel")
LoadSub.Parent = LoadCard
LoadSub.BackgroundTransparency = 1
LoadSub.Position = UDim2.new(0, 20, 0, 48)
LoadSub.Size = UDim2.new(1, -40, 0, 20)
LoadSub.Font = Enum.Font.Code
LoadSub.Text = "🦇 กำลังโหลดระบบครบทุกฟังก์ชัน V4.3..."
LoadSub.TextColor3 = Color3.fromRGB(216, 180, 254)
LoadSub.TextSize = 10
LoadSub.TextXAlignment = Enum.TextXAlignment.Left
LoadSub.ZIndex = 102

local BarBg = Instance.new("Frame")
BarBg.Parent = LoadCard
BarBg.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
BarBg.Position = UDim2.new(0, 20, 0, 95)
BarBg.Size = UDim2.new(1, -40, 0, 22)
BarBg.ZIndex = 102
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(0, 6)

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBg
BarFill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.ZIndex = 103
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 6)

local PercentText = Instance.new("TextLabel")
PercentText.Parent = BarBg
PercentText.BackgroundTransparency = 1
PercentText.Size = UDim2.new(1, 0, 1, 0)
PercentText.Font = Enum.Font.Code
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentText.TextSize = 10
PercentText.ZIndex = 104

task.spawn(function()
    local duration = 5.0
    local startTime = tick()
    while true do
        local elapsed = tick() - startTime
        local progress = math.clamp(elapsed / duration, 0, 1)
        local percentage = math.floor(progress * 100)
        BarFill.Size = UDim2.new(progress, 0, 1, 0)
        PercentText.Text = percentage .. "%"
        if progress >= 1 then break end
        task.wait(0.03)
    end
    LoadFrame:Destroy()
end)
task.wait(5.1)

----------------------------------------------------------------------------------------------------
-- [5] ระบบเลือกภาษา (Language Selection Menu)
----------------------------------------------------------------------------------------------------
local selectedLanguage = "TH"
local LangGui = Instance.new("ScreenGui")
LangGui.Name = "MeridianLangGui"
LangGui.IgnoreGuiInset = true
pcall(function() LangGui.Parent = CoreGui end)
if not LangGui.Parent then LangGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local LangFrame = Instance.new("Frame")
LangFrame.Parent = LangGui
LangFrame.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
LangFrame.Size = UDim2.new(1, 0, 1, 0)
LangFrame.ZIndex = 100

local LangCard = Instance.new("Frame")
LangCard.Parent = LangFrame
LangCard.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
LangCard.AnchorPoint = Vector2.new(0.5, 0.5)
LangCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LangCard.Size = UDim2.new(0, 380, 0, 230)
LangCard.ZIndex = 101
Instance.new("UICorner", LangCard).CornerRadius = UDim.new(0, 14)

local LangStroke = Instance.new("UIStroke")
LangStroke.Color = Color3.fromRGB(255, 140, 0)
LangStroke.Thickness = 2
LangStroke.Transparency = 0.2
LangStroke.Parent = LangCard

local LangTitle = Instance.new("TextLabel")
LangTitle.Parent = LangCard
LangTitle.BackgroundTransparency = 1
LangTitle.Position = UDim2.new(0, 20, 0, 20)
LangTitle.Size = UDim2.new(1, -40, 0, 24)
LangTitle.Font = Enum.Font.Code
LangTitle.Text = "🎃 SELECT LANGUAGE // เลือกภาษา 👻"
LangTitle.TextColor3 = Color3.fromRGB(255, 165, 0)
LangTitle.TextSize = 11
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
LangTitle.ZIndex = 102

local LangSub = Instance.new("TextLabel")
LangSub.Parent = LangCard
LangSub.BackgroundTransparency = 1
LangSub.Position = UDim2.new(0, 20, 0, 48)
LangSub.Size = UDim2.new(1, -40, 0, 20)
LangSub.Font = Enum.Font.Code
LangSub.Text = "กรุณาเลือกภาษาที่ต้องการใช้งาน / Choose your language:"
LangSub.TextColor3 = Color3.fromRGB(216, 180, 254)
LangSub.TextSize = 9
LangSub.TextXAlignment = Enum.TextXAlignment.Left
LangSub.ZIndex = 102

local ThaiBtn = Instance.new("TextButton")
ThaiBtn.Parent = LangCard
ThaiBtn.BackgroundColor3 = Color3.fromRGB(22, 14, 32)
ThaiBtn.Position = UDim2.new(0, 20, 0, 85)
ThaiBtn.Size = UDim2.new(1, -40, 0, 45)
ThaiBtn.Font = Enum.Font.Code
ThaiBtn.Text = "🇹🇭 ภาษาไทย (Thai)"
ThaiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ThaiBtn.TextSize = 12
ThaiBtn.ZIndex = 102
Instance.new("UICorner", ThaiBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", ThaiBtn).Color = Color3.fromRGB(255, 140, 0)

local EngBtn = Instance.new("TextButton")
EngBtn.Parent = LangCard
EngBtn.BackgroundColor3 = Color3.fromRGB(22, 14, 32)
EngBtn.Position = UDim2.new(0, 20, 0, 145)
EngBtn.Size = UDim2.new(1, -40, 0, 45)
EngBtn.Font = Enum.Font.Code
EngBtn.Text = "🇬🇧 English (English)"
EngBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EngBtn.TextSize = 12
EngBtn.ZIndex = 102
Instance.new("UICorner", EngBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", EngBtn).Color = Color3.fromRGB(168, 85, 247)

local langChosen = false
ThaiBtn.MouseButton1Click:Connect(function()
    selectedLanguage = "TH"
    langChosen = true
    LangGui:Destroy()
end)

EngBtn.MouseButton1Click:Connect(function()
    selectedLanguage = "EN"
    langChosen = true
    LangGui:Destroy()
end)

repeat task.wait() until langChosen

RootContainerNode.Enabled = true
FloatGui.Enabled = true
TracersGui.Enabled = true

----------------------------------------------------------------------------------------------------
-- [6] พจนานุกรม 2 ภาษา (ครบถ้วนทุกหมวดหมู่)
----------------------------------------------------------------------------------------------------
local L = {
    TH = {
        hubTitle = "🎃 MERIDIAN HUB // V4.3 FINAL 👻",
        hideUI = "🦇 ซ่อน UI",
        showUI = "คืนชีพ UI",
        showUIToast = "เปิดหน้าต่างสำเร็จ",
        hideUIToast = "ย่อหน้าต่างเรียบร้อย",
        tabMain = "เมนูหลัก",
        tabESP = "มองผู้เล่น",
        tabGun = "นายอำเภอ",
        tabMurder = "ฆาตรกร",
        tabTeleport = "วาร์ป",
        tabFarm = "ฟาร์มฮาโลวีน",
        tabUpdate = "บันทึกอัพเดท",
        tabConfig = "ตั้งค่า",
        tabGuide = "วิธีใช้งาน",
        -- เมนูหลัก
        mMoveHead = ">> ⚡ ระบบปรับแต่งการเคลื่อนไหว",
        mWalk = "วิ่งเร็วพิเศษ",
        mJump = "กระโดดสูงพิเศษ",
        mInfJump = "กระโดดไม่จำกัด (Inf Jump)",
        mDashHead = ">> 🚀 ระบบพุ่งตัวโมเมนตัม",
        mDashToggle = "ปุ่มลอยพุ่งตัวด่วน",
        mDashPower = "ความแรงการพุ่ง",
        mUtilHead = ">> 👻 ระบบป้องกัน & ซัพพอร์ต",
        mWalkThrough = "เดินทะลุผู้เล่นอื่น",
        mAntiFling = "กันโปรดีด (Anti-Fling)",
        mFullbright = "เปิดแสงสว่างสูงสุด",
        mNoclip = "ทะลุกำแพงทั่วแมพ (Noclip)",
        mFpsBoost = "เพิ่มความลื่น (FPS Boost)",
        -- ESP
        espHead = ">> 👁️ ระบบ ESP ตาทิพย์ขั้นสูง",
        espInnocent = "มองผู้เล่นทั่วไป (Innocent)",
        espMurder = "มองฆาตกร (Murderer)",
        espSheriff = "มองนายอำเภอ (Sheriff/Gun)",
        espGunDrop = "มองปืนตกบนพื้น (GunDrop ESP)",
        espTracer = "เส้นลากเป้า ESP (Tracer)",
        espBox = "กล่องครอบตัว ESP (Box)",
        -- นายอำเภอ
        gunHead = ">> 🔮 ระบบนายอำเภอ & เลือกโหมดเก็บปืน",
        gunGrabMode = "โหมดเก็บปืนอัตโนมัติ",
        gunGrabBtn = "ปุ่มลอยเก็บปืนด่วน",
        gunShootBtn = "ปุ่มลอยยิงดักหน้า (Aimbot)",
        -- ฆาตกร
        murdHead = ">> 🔪 ขยายฮิตบล็อก (Hitbox Extender)",
        murdHitbox = "ขยายขนาดตัวศัตรู",
        murdMassHead = ">> 💀 ระบบฆ่าหมู่ (Mass Kill)",
        murdKillAll = "ฆ่าทุกคนทันที (Kill All)",
        murdAutoKill = "ออโต้ฆ่าทุกคน (Auto Kill)",
        -- วาร์ป
        tpHead = ">> 🚀 ระบบวาร์ปด่วน",
        tpSheriff = "วาร์ปไปหานายอำเภอ",
        tpMurder = "วาร์ปไปหาฆาตรกร",
        tpFriendHead = ">> 👥 วาร์ปหาเพื่อนระบุชื่อ",
        tpDropdown = "เลือกเพื่อน",
        tpButton = "วาร์ปไปหาเพื่อน",
        -- ฟาร์ม
        farmHead = ">> 💰 ระบบฟาร์มเหรียญอีเว้นท์เสถียรสูงสุด",
        farmWarnTitle = "⚠️ คำเตือนความปลอดภัย",
        farmWarnDesc = "ความเร็วแนะนำไม่เกิน 19 ป้องกันระบบตรวจจับแบน",
        farmSpeed = "ความเร็วฟาร์มลอย",
        farmMode = "ท่าทางตัวละครตอนฟาร์ม",
        farmReset = "รีตัวอัตโนมัติเมื่อเหรียญหมด",
        farmToggle = "เริ่มฟาร์มฮาโลวีนอัตโนมัติ",
        farmSecHead = ">> 🛡️ ระบบป้องกันความปลอดภัย",
        farmAntiAfk = "ระบบป้องกันโดนเตะ AFK",
        -- Update Log
        upHead = ">> 📝 บันทึกการอัพเดทเวอร์ชันล่าสุด (V4.3 Final)",
        up1Title = "💀 Pro Prediction Aimbot & 4 Gun Grab Modes",
        up1Desc = "เพิ่มโหมดเก็บปืนอัจฉริยะครบทั้ง 4 รูปแบบ พร้อมระบบยิงดักหน้าเช็กสิ่งกีดขวางสมบูรณ์แบบ",
        up2Title = "🚀 Auto Config Saver & Instant Toast",
        up2Desc = "เพิ่มระบบบันทึกการตั้งค่าอัตโนมัติ และระบบแจ้งเตือนมุมจอแบบฉับไว 1 วินาที",
        up3Title = "🛡️ Zero-Bugs Stability & Full Feature Restoration",
        up3Desc = "ปรับโครงสร้างโค้ดใหม่ทั้งหมดให้เสถียร ไร้บัค พร้อมกู้คืนทุกแท็บและฟังก์ชันเดิมกลับมาครบ 100%",
        -- Config
        cfgHead = ">> ⚙️ ระบบบันทึกและจัดการการตั้งค่า",
        cfgSave = "บันทึกการตั้งค่าปัจจุบัน",
        cfgReset = "รีเซ็ตค่าเริ่มต้นทั้งหมด",
        -- Guide
        guHead = ">> 📖 คู่มือการใช้งาน V4.3",
        gu1Title = "1. การเปิด/ปิดหน้าต่างหลัก",
        gu1Desc = "กดปุ่ม '+' บนหน้าจอเพื่อเปิด/ปิดเมนู และลากย้ายตำแหน่งปุ่มลอยได้อิสระ",
        gu2Title = "2. ระบบเลือกโหมดเก็บปืน (4 โหมด)",
        gu2Desc = "เลือกรูปแบบการเก็บปืนในหมวดนายอำเภอได้ตามต้องการ ระบบจะทำงานอย่างรวดเร็วและปลอดภัย",
        gu3Title = "3. การแจ้งเตือนและระบบเซฟค่า",
        gu3Desc = "แจ้งเตือนรวดเร็วภายใน 1 วินาที และบันทึกค่าตั้งค่าอัตโนมัติทุกครั้งที่ใช้งาน"
    },
    EN = {
        hubTitle = "🎃 MERIDIAN HUB // V4.3 FINAL 👻",
        hideUI = "🦇 Hide UI",
        showUI = "Restore UI",
        showUIToast = "Window restored successfully",
        hideUIToast = "Window minimized successfully",
        tabMain = "Main Menu",
        tabESP = "Role ESP",
        tabGun = "Sheriff",
        tabMurder = "Murderer",
        tabTeleport = "Teleport",
        tabFarm = "Halloween Farm",
        tabUpdate = "Update Log",
        tabConfig = "Config",
        tabGuide = "User Guide",
        -- Main
        mMoveHead = ">> ⚡ Movement Customization",
        mWalk = "WalkSpeed Booster",
        mJump = "JumpPower Booster",
        mInfJump = "Infinite Jump",
        mDashHead = ">> 🚀 Momentum Dash System",
        mDashToggle = "Dash Floating Button",
        mDashPower = "Dash Power",
        mUtilHead = ">> 👻 Protection & Utility",
        mWalkThrough = "Walk Through Players",
        mAntiFling = "Anti-Fling Protection",
        mFullbright = "Fullbright (Remove Darkness)",
        mNoclip = "Global Noclip",
        mFpsBoost = "FPS Boost & Clear Fog",
        -- ESP
        espHead = ">> 👁️ Advanced Role ESP",
        espInnocent = "Show Innocents",
        espMurder = "Show Murderer",
        espSheriff = "Show Sheriff/Gun",
        espGunDrop = "Show Dropped Gun (GunDrop ESP)",
        espTracer = "ESP Tracer Lines",
        espBox = "ESP Bounding Box",
        -- Sheriff
        gunHead = ">> 🔮 Sheriff & Gun Grab Modes",
        gunGrabMode = "Gun Grab Mode Selector",
        gunGrabBtn = "Gun Grab Floating Button",
        gunShootBtn = "Pro Prediction Aimbot Button",
        -- Murderer
        murdHead = ">> 🔪 Hitbox Extender",
        murdHitbox = "Expand Enemy Hitbox Size",
        murdMassHead = ">> 💀 Mass Kill Systems",
        murdKillAll = "Mass Kill All",
        murdAutoKill = "Auto Kill All",
        -- Teleport
        tpHead = ">> 🚀 Quick Teleport",
        tpSheriff = "Teleport to Sheriff",
        tpMurder = "Teleport to Murderer",
        tpFriendHead = ">> 👥 Teleport to Specific Friend",
        tpDropdown = "Select Friend",
        tpButton = "Teleport to Friend",
        -- Farm
        farmHead = ">> 💰 Stable Event Coin Farm",
        farmWarnTitle = "⚠️ Safety Warning",
        farmWarnDesc = "Recommended speed below 19 to stay completely safe",
        farmSpeed = "Fly Speed",
        farmMode = "Fly Posture Mode",
        farmReset = "Auto Reset when coins deplete",
        farmToggle = "Start Auto Halloween Farm",
        farmSecHead = ">> 🛡️ Security Systems",
        farmAntiAfk = "Anti-AFK Protection",
        -- Update Log
        upHead = ">> 📝 Latest Update Logs (V4.3 Final)",
        up1Title = "💀 Pro Prediction Aimbot & 4 Gun Grab Modes",
        up1Desc = "Added 4 smart gun grab modes and prediction aimbot with raycast wall-check.",
        up2Title = "🚀 Auto Config Saver & Instant Toast",
        up2Desc = "Added auto configuration saving and 1-second instant toast notifications.",
        up3Title = "🛡️ Zero-Bugs Stability & Full Feature Restoration",
        up3Desc = "Overhauled architecture for maximum stability, zero bugs, and full feature preservation.",
        -- Config
        cfgHead = ">> ⚙️ Configuration Manager",
        cfgSave = "Save Current Configuration",
        cfgReset = "Reset to Default Settings",
        -- Guide
        guHead = ">> 📖 User Guide V4.3",
        gu1Title = "1. Main Menu Toggle",
        gu1Desc = "Click '+' floating button to open/close main UI. Drag anywhere on screen.",
        gu2Title = "2. Gun Grab Modes (4 Modes)",
        gu2Desc = "Select your preferred gun grab mode in Sheriff tab. Fully stable and fast.",
        gu3Title = "3. Auto Config Saver & Toast",
        gu3Desc = "Settings save automatically, and notifications disappear smoothly in 1 second."
    }
}

local T = L[selectedLanguage]

----------------------------------------------------------------------------------------------------
-- [7] หน้าต่างหลักแดชบอร์ด (Primary Dashboard Window)
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MeridianPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 15)
PrimaryWindowFrame.BackgroundTransparency = 0.02
PrimaryWindowFrame.Position = UDim2.new(0.08, 0, 0.12, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 560, 0, 480)
PrimaryWindowFrame.Visible = true
PrimaryWindowFrame.Active = true
PrimaryWindowFrame.Draggable = true
PrimaryWindowFrame.ZIndex = 5
Instance.new("UICorner", PrimaryWindowFrame).CornerRadius = UDim.new(0, 14)

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(255, 140, 0)
WindowBorderGlow.Transparency = 0.2
WindowBorderGlow.Thickness = 2
WindowBorderGlow.Parent = PrimaryWindowFrame

local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(18, 10, 26)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 45)
HeaderNavigationPanel.ZIndex = 6
Instance.new("UICorner", HeaderNavigationPanel).CornerRadius = UDim.new(0, 14)

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(18, 10, 26)
HeaderBottomBlocker.BorderSizePixel = 0
HeaderBottomBlocker.Position = UDim2.new(0, 0, 0.7, 0)
HeaderBottomBlocker.Size = UDim2.new(1, 0, 0.3, 0)
HeaderBottomBlocker.ZIndex = 6

local HeaderTitleLabel = Instance.new("TextLabel")
HeaderTitleLabel.Parent = HeaderNavigationPanel
HeaderTitleLabel.BackgroundTransparency = 1
HeaderTitleLabel.Position = UDim2.new(0, 18, 0, 0)
HeaderTitleLabel.Size = UDim2.new(1, -120, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = T.hubTitle
HeaderTitleLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
HeaderTitleLabel.TextSize = 11
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitleLabel.ZIndex = 7

local HideWindowButton = Instance.new("TextButton")
HideWindowButton.Parent = HeaderNavigationPanel
HideWindowButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
HideWindowButton.Position = UDim2.new(1, -75, 0, 9)
HideWindowButton.Size = UDim2.new(0, 65, 0, 26)
HideWindowButton.Font = Enum.Font.Code
HideWindowButton.Text = T.hideUI
HideWindowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideWindowButton.TextSize = 10
HideWindowButton.ZIndex = 7
Instance.new("UICorner", HideWindowButton).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------------------------------------------
-- [8] ฝั่งซ้าย: โปรไฟล์ผู้เล่น & แท็บเมนูแนวตั้ง
----------------------------------------------------------------------------------------------------
local LeftProfileSidebar = Instance.new("Frame")
LeftProfileSidebar.Parent = PrimaryWindowFrame
LeftProfileSidebar.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
LeftProfileSidebar.Position = UDim2.new(0, 15, 0, 55)
LeftProfileSidebar.Size = UDim2.new(0, 175, 1, -68)
LeftProfileSidebar.ZIndex = 6
Instance.new("UICorner", LeftProfileSidebar).CornerRadius = UDim.new(0, 10)

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(168, 85, 247)
sidebarStroke.Thickness = 1
sidebarStroke.Parent = LeftProfileSidebar

local UserAvatarImage = Instance.new("ImageLabel")
UserAvatarImage.Parent = LeftProfileSidebar
UserAvatarImage.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
UserAvatarImage.Position = UDim2.new(0, 10, 0, 10)
UserAvatarImage.Size = UDim2.new(0, 45, 0, 45)
UserAvatarImage.Image = "rbxassetid://0"
UserAvatarImage.ZIndex = 7
Instance.new("UICorner", UserAvatarImage).CornerRadius = UDim.new(0, 8)

task.spawn(function()
    pcall(function()
        local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if isReady then UserAvatarImage.Image = content end
    end)
end)

local RealNameLabel = Instance.new("TextLabel")
RealNameLabel.Parent = LeftProfileSidebar
RealNameLabel.BackgroundTransparency = 1
RealNameLabel.Position = UDim2.new(0, 62, 0, 10)
RealNameLabel.Size = UDim2.new(1, -70, 0, 18)
RealNameLabel.Font = Enum.Font.Code
RealNameLabel.Text = "🦇 @" .. LocalPlayer.Name
RealNameLabel.TextColor3 = Color3.fromRGB(241, 245, 249)
RealNameLabel.TextSize = 10
RealNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
RealNameLabel.TextXAlignment = Enum.TextXAlignment.Left
RealNameLabel.ZIndex = 7

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Parent = LeftProfileSidebar
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.Position = UDim2.new(0, 62, 0, 26)
DisplayNameLabel.Size = UDim2.new(1, -70, 0, 18)
DisplayNameLabel.Font = Enum.Font.Code
DisplayNameLabel.Text = "💀 " .. LocalPlayer.DisplayName
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
DisplayNameLabel.TextSize = 10
DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.ZIndex = 7

local HealthBarBg = Instance.new("Frame")
HealthBarBg.Parent = LeftProfileSidebar
HealthBarBg.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
HealthBarBg.Position = UDim2.new(0, 10, 0, 62)
HealthBarBg.Size = UDim2.new(1, -20, 0, 18)
HealthBarBg.ZIndex = 7
Instance.new("UICorner", HealthBarBg).CornerRadius = UDim.new(0, 4)

local HealthBarFill = Instance.new("Frame")
HealthBarFill.Parent = HealthBarBg
HealthBarFill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
HealthBarFill.Size = UDim2.new(1, 0, 1, 0)
HealthBarFill.ZIndex = 8
Instance.new("UICorner", HealthBarFill).CornerRadius = UDim.new(0, 4)

local HealthText = Instance.new("TextLabel")
HealthText.Parent = HealthBarBg
HealthText.BackgroundTransparency = 1
HealthText.Size = UDim2.new(1, 0, 1, 0)
HealthText.Font = Enum.Font.Code
HealthText.Text = "HP: 100 / 100"
HealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthText.TextSize = 9
HealthText.ZIndex = 9

task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local hp = math.floor(humanoid.Health)
                    local maxHp = math.floor(humanoid.MaxHealth)
                    HealthText.Text = string.format("HP: %d / %d", hp, maxHp)
                    HealthBarFill.Size = UDim2.new(math.clamp(hp / maxHp, 0, 1), 0, 1, 0)
                end
            end
        end)
    end
end)

local TabMenuContainer = Instance.new("ScrollingFrame")
TabMenuContainer.Parent = LeftProfileSidebar
TabMenuContainer.BackgroundTransparency = 1
TabMenuContainer.Position = UDim2.new(0, 10, 0, 88)
TabMenuContainer.Size = UDim2.new(1, -20, 1, -98)
TabMenuContainer.CanvasSize = UDim2.new(0, 0, 0, 450) -- ขยาย Canvas ให้พอดีทุกแท็บ
TabMenuContainer.ScrollBarThickness = 3
TabMenuContainer.ZIndex = 7

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = TabMenuContainer
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 6)

----------------------------------------------------------------------------------------------------
-- [9] UI Component Builder Library
----------------------------------------------------------------------------------------------------
local PagesContainer = Instance.new("Frame")
PagesContainer.Parent = PrimaryWindowFrame
PagesContainer.BackgroundTransparency = 1
PagesContainer.Position = UDim2.new(0, 200, 0, 55)
PagesContainer.Size = UDim2.new(1, -215, 1, -68)
PagesContainer.ZIndex = 6

local Pages = {}
local TabButtons = {}

local function createTabContent(tabName)
    local scrollingPage = Instance.new("ScrollingFrame")
    scrollingPage.Parent = PagesContainer
    scrollingPage.BackgroundTransparency = 1
    scrollingPage.Size = UDim2.new(1, 0, 1, 0)
    scrollingPage.CanvasSize = UDim2.new(0, 0, 0, 560)
    scrollingPage.ScrollBarThickness = 3
    scrollingPage.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
    scrollingPage.Visible = false
    scrollingPage.ZIndex = 6

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Parent = scrollingPage
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)

    Pages[tabName] = scrollingPage

    local menuBtn = Instance.new("TextButton")
    menuBtn.Parent = TabMenuContainer
    menuBtn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    menuBtn.Size = UDim2.new(1, 0, 0, 32)
    menuBtn.Font = Enum.Font.Code
    menuBtn.Text = "  👻 " .. tostring(tabName)
    menuBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
    menuBtn.TextSize = 10
    menuBtn.TextXAlignment = Enum.TextXAlignment.Left
    menuBtn.ZIndex = 7
    Instance.new("UICorner", menuBtn).CornerRadius = UDim.new(0, 6)

    TabButtons[tabName] = menuBtn

    menuBtn.MouseButton1Click:Connect(function()
        for name, page in pairs(Pages) do page.Visible = (name == tabName) end
        for name, btn in pairs(TabButtons) do
            if name == tabName then
                btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
                btn.TextColor3 = Color3.fromRGB(15, 10, 20)
            else
                btn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
                btn.TextColor3 = Color3.fromRGB(216, 180, 254)
            end
        end
    end)

    return scrollingPage
end

local function addHeader(parent, text)
    local lbl = Instance.new("TextLabel")
    lbl.Parent = parent
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 16)
    lbl.Font = Enum.Font.Code
    lbl.Text = tostring(text or "")
    lbl.TextColor3 = Color3.fromRGB(168, 85, 247)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    return lbl
end

local function addParagraph(parent, title, desc)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(168, 85, 247)
    stroke.Transparency = 0.5
    stroke.Thickness = 1
    stroke.Parent = frame

    local tLbl = Instance.new("TextLabel")
    tLbl.Parent = frame
    tLbl.BackgroundTransparency = 1
    tLbl.Position = UDim2.new(0, 10, 0, 4)
    tLbl.Size = UDim2.new(1, -20, 0, 16)
    tLbl.Font = Enum.Font.Code
    tLbl.Text = tostring(title or "")
    tLbl.TextColor3 = Color3.fromRGB(255, 140, 0)
    tLbl.TextSize = 10
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.ZIndex = 7

    local dLbl = Instance.new("TextLabel")
    dLbl.Parent = frame
    dLbl.BackgroundTransparency = 1
    dLbl.Position = UDim2.new(0, 10, 0, 20)
    dLbl.Size = UDim2.new(1, -20, 0, 22)
    dLbl.Font = Enum.Font.Code
    dLbl.Text = tostring(desc or "")
    dLbl.TextColor3 = Color3.fromRGB(216, 180, 254)
    dLbl.TextSize = 9
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.ZIndex = 7
end

local function addButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = "  " .. tostring(text or "")
    btn.TextColor3 = Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(168, 85, 247)
    stroke.Thickness = 1
    stroke.Transparency = 0.4
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function() 
        if callback then callback(btn) end 
    end)
    return btn
end

local function addToggleButton(parent, text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(255, 140, 0) or Color3.fromRGB(20, 12, 30)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = defaultState and ("  [ เปิด ] " .. tostring(text or "")) or ("  [ ปิด ] " .. tostring(text or ""))
    btn.TextColor3 = defaultState and Color3.fromRGB(15, 10, 20) or Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local state = defaultState
    btn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            btn.Text = "  [ เปิด ] " .. tostring(text or "")
            btn.TextColor3 = Color3.fromRGB(15, 10, 20)
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
            btn.Text = "  [ ปิด ] " .. tostring(text or "")
            btn.TextColor3 = Color3.fromRGB(216, 180, 254)
        end
        if callback then callback(state) end
    end)
    return btn
end

local function addToggleWithInput(parent, text, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Size = UDim2.new(1, -70, 1, 0)
    toggleBtn.Font = Enum.Font.Code
    toggleBtn.Text = "  [ ปิด ] " .. tostring(text or "")
    toggleBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
    toggleBtn.TextSize = 10
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    toggleBtn.ZIndex = 7

    local inputBox = Instance.new("TextBox")
    inputBox.Parent = frame
    inputBox.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
    inputBox.Size = UDim2.new(0, 55, 0, 26)
    inputBox.Position = UDim2.new(1, -62, 0.5, -13)
    inputBox.Font = Enum.Font.Code
    inputBox.Text = tostring(defaultVal or "")
    inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
    inputBox.TextSize = 11
    inputBox.ZIndex = 7
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(168, 85, 247)
    boxStroke.Thickness = 1
    boxStroke.Parent = inputBox

    local activeState = false
    local currentNum = defaultVal or 0

    toggleBtn.MouseButton1Click:Connect(function()
        activeState = not activeState
        if activeState then
            frame.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            toggleBtn.Text = "  [ เปิด ] " .. tostring(text or "")
            toggleBtn.TextColor3 = Color3.fromRGB(15, 10, 20)
            inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            frame.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
            toggleBtn.Text = "  [ ปิด ] " .. tostring(text or "")
            toggleBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
            inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
        end
        if callback then callback(activeState, currentNum) end
    end)

    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val then
            currentNum = val
            if activeState and callback then callback(activeState, currentNum) end
            triggerHalloweenToast("SUCCESS", "Updated value to " .. tostring(currentNum), "SUCCESS")
        else
            inputBox.Text = tostring(currentNum)
        end
    end)
end

local function addSlider(parent, title, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frame
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 10, 0, 6)
    lbl.Size = UDim2.new(1, -20, 0, 16)
    lbl.Font = Enum.Font.Code
    lbl.Text = string.format("  %s: [%d]", tostring(title or ""), defaultVal or 0)
    lbl.TextColor3 = Color3.fromRGB(216, 180, 254)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 7

    local inputBox = Instance.new("TextBox")
    inputBox.Parent = frame
    inputBox.BackgroundColor3 = Color3.fromRGB(8, 4, 12)
    inputBox.Size = UDim2.new(0, 65, 0, 22)
    inputBox.Position = UDim2.new(1, -72, 0, 21)
    inputBox.Font = Enum.Font.Code
    inputBox.Text = tostring(defaultVal or 0)
    inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
    inputBox.TextSize = 10
    inputBox.ZIndex = 7
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 5)

    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val then
            val = math.clamp(val, minVal, maxVal)
            inputBox.Text = tostring(val)
            lbl.Text = string.format("  %s: [%d]", tostring(title or ""), val)
            if callback then callback(val) end
        else
            inputBox.Text = tostring(defaultVal)
        end
    end)
end

local function addDropdown(parent, title, options, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Font = Enum.Font.Code
    btn.Text = string.format("  %s: < %s >", tostring(title or ""), tostring(defaultVal or "None"))
    btn.TextColor3 = Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 7

    local currentIdx = 1
    options = options or {}
    for i, opt in ipairs(options) do
        if opt == defaultVal then currentIdx = i break end
    end

    local dropdownObj = {}
    function dropdownObj:Refresh(newOptions)
        options = newOptions or {}
        if #options > 0 then
            currentIdx = math.clamp(currentIdx, 1, #options)
            local selected = options[currentIdx]
            btn.Text = string.format("  %s: < %s >", tostring(title or ""), tostring(selected))
            if callback then callback(selected) end
        else
            currentIdx = 1
            btn.Text = string.format("  %s: < None >", tostring(title or ""))
            if callback then callback(nil) end
        end
    end

    btn.MouseButton1Click:Connect(function()
        if #options == 0 then return end
        currentIdx = currentIdx + 1
        if currentIdx > #options then currentIdx = 1 end
        local selected = options[currentIdx]
        btn.Text = string.format("  %s: < %s >", tostring(title or ""), tostring(selected))
        if callback then callback(selected) end
    end)

    return dropdownObj
end

local function addFloatingToggle(parent, text, defaultPos, themeColor, borderColor, callback)
    local safeText = tostring(text or "Button")
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = "  [ ปิด ] " .. safeText
    btn.TextColor3 = Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local activeState = false
    local floatingButtonInstance = nil

    local function removeFloatBtn()
        if floatingButtonInstance then
            pcall(function() floatingButtonInstance:Destroy() end)
            floatingButtonInstance = nil
        end
    end

    local function createFloatBtn()
        removeFloatBtn()
        local fBtn = Instance.new("TextButton")
        fBtn.Name = "Float_" .. safeText
        fBtn.Parent = FloatGui
        fBtn.BackgroundColor3 = Color3.fromRGB(15, 8, 22)
        fBtn.Size = UDim2.new(0, 145, 0, 48)
        fBtn.Position = defaultPos or UDim2.new(0.05, 0, 0.2, 0)
        fBtn.Font = Enum.Font.Code
        fBtn.Text = safeText
        fBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        fBtn.TextSize = 12
        fBtn.Active = true
        fBtn.Draggable = true
        fBtn.ZIndex = 100
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 12)
        fCorner.Parent = fBtn

        local stroke = Instance.new("UIStroke")
        stroke.Color = borderColor or Color3.fromRGB(255, 140, 0)
        stroke.Thickness = 2
        stroke.Transparency = 0.1
        stroke.Parent = fBtn

        local innerGlow = Instance.new("Frame")
        innerGlow.Parent = fBtn
        innerGlow.BackgroundTransparency = 0.85
        innerGlow.BackgroundColor3 = themeColor or Color3.fromRGB(255, 140, 0)
        innerGlow.Size = UDim2.new(1, 0, 1, 0)
        innerGlow.ZIndex = 99
        Instance.new("UICorner", innerGlow).CornerRadius = UDim.new(0, 12)

        fBtn.MouseButton1Click:Connect(function() 
            if callback then callback(fBtn) end 
        end)
        floatingButtonInstance = fBtn
    end

    btn.MouseButton1Click:Connect(function()
        activeState = not activeState
        if activeState then
            btn.BackgroundColor3 = themeColor or Color3.fromRGB(255, 140, 0)
            btn.Text = "  [ เปิด ] " .. safeText
            btn.TextColor3 = Color3.fromRGB(15, 10, 20)
            createFloatBtn()
            triggerHalloweenToast("SUCCESS", "Spawned [" .. safeText .. "]", "SUCCESS")
        else
            btn.BackgroundColor3 = Color3.fromRGB(20, 12, 30)
            btn.Text = "  [ ปิด ] " .. safeText
            btn.TextColor3 = Color3.fromRGB(216, 180, 254)
            removeFloatBtn()
            triggerHalloweenToast("WARNING", "Removed [" .. safeText .. "]", "WARNING")
        end
    end)
    return btn
end

----------------------------------------------------------------------------------------------------
-- [10] การสร้างเนื้อหาแต่ละแท็บ
----------------------------------------------------------------------------------------------------

-- 1. เมนูหลัก
local tabMain = createTabContent(T.tabMain)
addHeader(tabMain, T.mMoveHead)

local walkSpeedEnabled = false
local currentWalkSpeed = 16
local jumpPowerEnabled = false
local currentJumpPower = 50
local infJumpEnabled = false

addToggleWithInput(tabMain, T.mWalk, 16, function(state, value)
    walkSpeedEnabled = state
    currentWalkSpeed = value
end)

addToggleWithInput(tabMain, T.mJump, 50, function(state, value)
    jumpPowerEnabled = state
    currentJumpPower = value
end)

addToggleButton(tabMain, T.mInfJump, false, function(state)
    infJumpEnabled = state
end)

addHeader(tabMain, T.mDashHead)
local dashPowerValue = 100
addSlider(tabMain, T.mDashPower, 1, 1000, 100, function(v)
    dashPowerValue = v
end)

addFloatingToggle(tabMain, T.mDashToggle, UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(168, 85, 247), Color3.fromRGB(216, 180, 254), function(btn)
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local lookVector = Camera.CFrame.LookVector
            hrp.CFrame = hrp.CFrame + Vector3.new(lookVector.X * (dashPowerValue / 4), 0, lookVector.Z * (dashPowerValue / 4))
            triggerHalloweenToast("SUCCESS", "🚀 Pro Dash activated!", "SUCCESS")
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                if walkSpeedEnabled then hum.WalkSpeed = currentWalkSpeed end
                if jumpPowerEnabled then
                    hum.UseJumpPower = true
                    hum.JumpPower = currentJumpPower
                end
            end
        end
    end)
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

addHeader(tabMain, T.mUtilHead)

local walkThrough = false
addToggleButton(tabMain, T.mWalkThrough, false, function(state)
    walkThrough = state
end)

RunService.Stepped:Connect(function()
    if not walkThrough then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            for _, part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

local antiFlingEnabled = false
addToggleButton(tabMain, T.mAntiFling, false, function(state)
    antiFlingEnabled = state
end)

RunService.Heartbeat:Connect(function()
    if not antiFlingEnabled then return end
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if hrp.AssemblyLinearVelocity.Magnitude > 250 or hrp.AssemblyAngularVelocity.Magnitude > 250 then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end)
end)

addToggleButton(tabMain, T.mFullbright, false, function(state)
    if state then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
    end
end)

local globalNoclip = false
addToggleButton(tabMain, T.mNoclip, false, function(state)
    globalNoclip = state
end)

RunService.Stepped:Connect(function()
    if not globalNoclip then return end
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

addToggleButton(tabMain, T.mFpsBoost, false, function(state)
    pcall(function()
        if state then
            Lighting.FogEnd = 999999
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v.Enabled = false end
            end
        else
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v.Enabled = true end
            end
        end
    end)
end)


-- 2. มองผู้เล่น (Role ESP & GunDrop ESP)
local tabESP = createTabContent(T.tabESP)
addHeader(tabESP, T.espHead)

local espInnocent = false
local espMurderer = false
local espSheriff = false
local espGunDrop = false
local espTracer = false
local espBox = false

addToggleButton(tabESP, T.espInnocent, false, function(state) espInnocent = state end)
addToggleButton(tabESP, T.espMurderer, false, function(state) espMurderer = state end)
addToggleButton(tabESP, T.espSheriff, false, function(state) espSheriff = state end)
addToggleButton(tabESP, T.espGunDrop, false, function(state) espGunDrop = state end)
addToggleButton(tabESP, T.espTracer, false, function(state) espTracer = state end)
addToggleButton(tabESP, T.espBox, false, function(state) espBox = state end)

local function getRole(plr)
    if not plr or not plr.Character then return "Good" end
    local backpack = plr:FindFirstChild("Backpack")
    local char = plr.Character
    local hasKnife = (char and char:FindFirstChild("Knife")) or (backpack and backpack:FindFirstChild("Knife"))
    local hasGun = (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or char:FindFirstChild("SheriffGun"))) or 
                   (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver") or backpack:FindFirstChild("SheriffGun")))
    if hasKnife then return "Knife"
    elseif hasGun then return "Gun"
    else return "Good" end
end

local tracerLines = {}
Players.PlayerRemoving:Connect(function(plr)
    if tracerLines[plr] then
        pcall(function() tracerLines[plr]:Remove() end)
        tracerLines[plr] = nil
    end
end)

local function removeESP(char)
    if not char then return end
    local hl = char:FindFirstChild("RoleESP")
    if hl then hl:Destroy() end
    local tag = char:FindFirstChild("RoleTag")
    if tag then tag:Destroy() end
end

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local line = tracerLines[plr]

            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local role = getRole(plr)
                local shouldShow = false

                if role == "Good" and espInnocent then shouldShow = true end
                if role == "Knife" and espMurderer then shouldShow = true end
                if role == "Gun" and espSheriff then shouldShow = true end

                local color = role == "Knife" and Color3.fromRGB(239, 68, 68) or (role == "Gun" and Color3.fromRGB(59, 130, 246) or Color3.fromRGB(34, 197, 94))
                local text = role == "Knife" and "🔪 Murderer" or (role == "Gun" and "🔫 Sheriff" or "👤 Innocent")

                if shouldShow or espBox then
                    if not char:FindFirstChild("RoleESP") and espBox then
                        local hl = Instance.new("Highlight")
                        hl.Name = "RoleESP"
                        hl.FillTransparency = 0.6
                        hl.OutlineColor = color
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = char
                    elseif char:FindFirstChild("RoleESP") and not espBox then
                        char.RoleESP:Destroy()
                    elseif char:FindFirstChild("RoleESP") then
                        char.RoleESP.OutlineColor = color
                    end

                    if shouldShow then
                        local head = char:FindFirstChild("Head")
                        if head then
                            local bb = char:FindFirstChild("RoleTag")
                            if not bb then
                                bb = Instance.new("BillboardGui")
                                bb.Name = "RoleTag"
                                bb.Size = UDim2.new(0, 160, 0, 30)
                                bb.StudsOffset = Vector3.new(0, 2, 0)
                                bb.AlwaysOnTop = true
                                bb.Adornee = head
                                bb.Parent = char

                                local lbl = Instance.new("TextLabel")
                                lbl.Name = "RoleLabel"
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.TextScaled = true
                                lbl.Font = Enum.Font.Code
                                lbl.Parent = bb
                            end
                            local lbl = bb:FindFirstChild("RoleLabel")
                            if lbl then
                                lbl.Text = text
                                lbl.TextColor3 = color
                            end
                        end
                    else
                        if char:FindFirstChild("RoleTag") then char.RoleTag:Destroy() end
                    end
                else
                    removeESP(char)
                end

                if espTracer and shouldShow then
                    local rootPart = char.HumanoidRootPart
                    local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        if not line then
                            line = Drawing.new("Line")
                            line.Thickness = 1.5
                            line.Transparency = 0.8
                            tracerLines[plr] = line
                        end
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        line.To = Vector2.new(vector.X, vector.Y)
                        line.Color = color
                        line.Visible = true
                    else
                        if line then line.Visible = false end
                    end
                else
                    if line then line.Visible = false end
                end
            else
                removeESP(char)
                if line then line.Visible = false end
            end
        end
    end

    -- GunDrop ESP
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" then
            local part = obj:IsA("Model") and (obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")) or (obj:IsA("BasePart") and obj)
            if part then
                if espGunDrop then
                    if not obj:FindFirstChild("GunDropTag") then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "GunDropTag"
                        bb.Size = UDim2.new(0, 160, 0, 30)
                        bb.StudsOffset = Vector3.new(0, 2, 0)
                        bb.AlwaysOnTop = true
                        bb.Adornee = part
                        bb.Parent = obj

                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.TextScaled = true
                        lbl.Text = "🎯 [ ปืนตกบนพื้น ]"
                        lbl.TextColor3 = Color3.fromRGB(255, 165, 0)
                        lbl.Font = Enum.Font.Code
                        lbl.Parent = bb
                    end
                else
                    if obj:FindFirstChild("GunDropTag") then obj.GunDropTag:Destroy() end
                end
            end
        end
    end
end)


-- 3. นายอำเภอ (พร้อม 4 โหมดเก็บปืน + Aimbot ยิงดักหน้า)
local tabGun = createTabContent(T.tabGun)
addHeader(tabGun, T.gunHead)

local selectedGunGrabMode = "วาปปืนเข้าตัว"
addDropdown(tabGun, T.gunGrabMode, {
    "1. วาปไปเก็บปืน 0.1 วิ",
    "2. วาปปืนเข้าตัว",
    "3. ให้ปืนเคลื่อนที่มาหา",
    "4. มุดดินไปเก็บปืนแล้วกลับจุดเดิม"
}, "2. วาปปืนเข้าตัว", function(val)
    if string.find(val, "0.1") then selectedGunGrabMode = "วาปไปเก็บปืน 0.1 วิ"
    elseif string.find(val, "เข้าตัว") then selectedGunGrabMode = "วาปปืนเข้าตัว"
    elseif string.find(val, "เคลื่อนที่มาหา") then selectedGunGrabMode = "ให้ปืนเคลื่อนที่มาหา"
    elseif string.find(val, "มุดดิน") then selectedGunGrabMode = "มุดดินไปเก็บปืนแล้วกลับจุดเดิม" end
end)

local function executeGunGrab()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then 
            triggerHalloweenToast("ERROR", "❌ ไม่พบตัวละคร", "ERROR")
            return 
        end
        
        local root = char.HumanoidRootPart
        local targetPart = nil

        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "GunDrop" then
                targetPart = v:IsA("Model") and (v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart")) or (v:IsA("BasePart") and v)
                if targetPart then break end
            end
        end

        if not targetPart then
            triggerHalloweenToast("WARNING", "⚠️ ไม่พบปืนตกอยู่บนพื้น!", "WARNING")
            return
        end

        local originalPos = root.CFrame

        if selectedGunGrabMode == "วาปไปเก็บปืน 0.1 วิ" then
            root.CFrame = targetPart.CFrame * CFrame.new(0, 1, 0)
            task.wait(0.1)
            if firetouchinterest then
                firetouchinterest(root, targetPart, 0)
                firetouchinterest(root, targetPart, 1)
            end
            task.wait(0.05)
            root.CFrame = originalPos
            triggerHalloweenToast("SUCCESS", "🎯 [โหมด 1] วาปไปเก็บปืนสำเร็จ!", "SUCCESS")

        elseif selectedGunGrabMode == "วาปปืนเข้าตัว" then
            targetPart.CFrame = root.CFrame * CFrame.new(0, 0, -2)
            if firetouchinterest then
                firetouchinterest(root, targetPart, 0)
                task.wait(0.05)
                firetouchinterest(root, targetPart, 1)
            end
            triggerHalloweenToast("SUCCESS", "🎯 [โหมด 2] วาปปืนเข้าตัวสำเร็จ!", "SUCCESS")

        elseif selectedGunGrabMode == "ให้ปืนเคลื่อนที่มาหา" then
            task.spawn(function()
                local startTime = tick()
                while targetPart and targetPart.Parent and tick() - startTime < 3 do
                    targetPart.CFrame = targetPart.CFrame:Lerp(root.CFrame, 0.2)
                    if (targetPart.Position - root.Position).Magnitude < 3 then break end
                    RunService.RenderStepped:Wait()
                end
                if firetouchinterest then
                    firetouchinterest(root, targetPart, 0)
                    firetouchinterest(root, targetPart, 1)
                end
            end)
            triggerHalloweenToast("SUCCESS", "🎯 [โหมด 3] ดึงปืนวิ่งมาหาสำเร็จ!", "SUCCESS")

        elseif selectedGunGrabMode == "มุดดินไปเก็บปืนแล้วกลับจุดเดิม" then
            root.CFrame = targetPart.CFrame + Vector3.new(0, -10, 0)
            task.wait(0.15)
            if firetouchinterest then
                firetouchinterest(root, targetPart, 0)
                firetouchinterest(root, targetPart, 1)
            end
            task.wait(0.1)
            root.CFrame = originalPos
            triggerHalloweenToast("SUCCESS", "🎯 [โหมด 4] มุดดินเก็บปืนสำเร็จ!", "SUCCESS")
        end
    end)
end

addFloatingToggle(tabGun, T.gunGrabBtn, UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(255, 140, 0), Color3.fromRGB(255, 165, 0), function()
    executeGunGrab()
end)

local function getBestTarget()
    local bestTarget = nil
    local shortestDist = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Health > 0 and getRole(plr) == "Knife" then
                local hrp = plr.Character.HumanoidRootPart
                local pos, visible = Camera:WorldToViewportPoint(hrp.Position)
                if visible then
                    local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        bestTarget = plr
                    end
                end
            end
        end
    end
    return bestTarget
end

local function isTargetVisible(targetPart, originPos)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local res = Workspace:Raycast(originPos, (targetPart.Position - originPos), rayParams)
    if res and res.Instance:IsDescendantOf(targetPart.Parent) then return true end
    return res == nil
end

addFloatingToggle(tabGun, T.gunShootBtn, UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(239, 68, 68), Color3.fromRGB(255, 140, 0), function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local tool = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
        if not tool then
            triggerHalloweenToast("WARNING", "⚠️ ไม่พบปืนในตัว!", "WARNING")
            return
        end
        if tool.Parent ~= char then tool.Parent = char task.wait(0.05) end
        local remote = tool:FindFirstChild("Shoot")
        local root = char.HumanoidRootPart
        local att = root:FindFirstChild("GunRaycastAttachment")
        if not remote or not att then return end

        local target = getBestTarget()
        if not target or not target.Character or not target.Character:FindFirstChild("Head") then
            triggerHalloweenToast("WARNING", "🎯 ไม่พบเป้าหมาย", "WARNING")
            return
        end

        local head = target.Character.Head
        if not isTargetVisible(head, root.Position) then
            triggerHalloweenToast("ERROR", "❌ ติดกำแพงยิงไม่ได้", "ERROR")
            return
        end

        local ping = LocalPlayer:GetNetworkPing() or 0.05
        local dist = (head.Position - root.Position).Magnitude
        local travel = (dist / 300) + (ping * 1.2)
        local predicted = head.Position + (target.Character.HumanoidRootPart.AssemblyLinearVelocity * travel)

        remote:FireServer(att.WorldCFrame, CFrame.new(predicted))
        triggerHalloweenToast("SUCCESS", "🎯 ยิงเข้าเป้าเต็มๆ!", "SUCCESS")
    end)
end)


-- 4. ฆาตกร (Hitbox & Mass Kill)
local tabMurder = createTabContent(T.tabMurder)
addHeader(tabMurder, T.murdHead)

local hitboxEnabled = false
local hitboxSize = 12

addToggleWithInput(tabMurder, T.murdHitbox, 12, function(state, value)
    hitboxEnabled = state
    hitboxSize = value
end)

RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if enemyRoot then
                enemyRoot.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                enemyRoot.Transparency = 0.75
                enemyRoot.CanCollide = false
            end
        end
    end
end)

addHeader(tabMurder, T.murdMassHead)

local function pullPlayers()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    if knife and knife.Parent ~= char then knife.Parent = char end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, -3)
        end
    end
end

local autoKillState = false
addToggleButton(tabMurder, T.murdKillAll, false, function(state)
    if state then pullPlayers() end
end)
addToggleButton(tabMurder, T.murdAutoKill, false, function(state)
    autoKillState = state
end)

RunService.RenderStepped:Connect(function()
    if not autoKillState then return end
    local char = LocalPlayer.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    if knife then pullPlayers() end
end)


-- 5. วาร์ป
local tabTeleport = createTabContent(T.tabTeleport)
addHeader(tabTeleport, T.tpHead)

local function getSheriff()
    for _, plr in pairs(Players:GetPlayers()) do
        if getRole(plr) == "Gun" then return plr end
    end
end

local function getMurderer()
    for _, plr in pairs(Players:GetPlayers()) do
        if getRole(plr) == "Knife" then return plr end
    end
end

local function teleportTo(plr)
    if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end
end

addButton(tabTeleport, T.tpSheriff, function()
    local sheriff = getSheriff()
    if sheriff then teleportTo(sheriff) else triggerHalloweenToast("WARNING", "⚠️ ไม่พบนายอำเภอ", "WARNING") end
end)

addButton(tabTeleport, T.tpMurder, function()
    local murderer = getMurderer()
    if murderer then teleportTo(murderer) else triggerHalloweenToast("WARNING", "⚠️ ไม่พบฆาตกร", "WARNING") end
end)

addHeader(tabTeleport, T.tpFriendHead)

local selectedPlayer = nil
local function getPlayerList()
    local list = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then table.insert(list, plr.Name) end
    end
    return list
end

local playerDropdown = addDropdown(tabTeleport, T.tpDropdown, getPlayerList(), "None", function(value)
    selectedPlayer = value
end)

addButton(tabTeleport, T.tpButton, function()
    if not selectedPlayer then return end
    local target = Players:FindFirstChild(selectedPlayer)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)
        end
    end
end)

Players.PlayerAdded:Connect(function() playerDropdown:Refresh(getPlayerList()) end)
Players.PlayerRemoving:Connect(function() playerDropdown:Refresh(getPlayerList()) end)


-- 6. ฟาร์มฮาโลวีน (เสถียรสุดขีด)
local tabFarm = createTabContent(T.tabFarm)
addHeader(tabFarm, T.farmHead)
addParagraph(tabFarm, T.farmWarnTitle, T.farmWarnDesc)

local flying = false
local autoReset = false
local flyMode = "ปกติ"
local flySpeed = 16
local collectedCoins = {}
local startedCollecting = false

addSlider(tabFarm, T.farmSpeed, 1, 26, 16, function(v) flySpeed = v end)
addDropdown(tabFarm, T.farmMode, {"ปกติ", "นอนคว่ำ"}, "ปกติ", function(v) flyMode = v end)
addToggleButton(tabFarm, T.farmReset, false, function(v) autoReset = v end)

local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function noclipLoop(char)
    task.spawn(function()
        while flying and char.Parent do
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
            RunService.Stepped:Wait()
        end
    end)
end

local function restore()
    local char = getChar()
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    hum.PlatformStand = false
    hrp.AssemblyLinearVelocity = Vector3.zero
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then v.CanCollide = true end
    end
end

local function getNearestCoin(root)
    local nearest
    local dist = math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Coin_Server" and v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and not collectedCoins[v] and not v:GetAttribute("Collected") then
            local d = (root.Position - v.Position).Magnitude
            if d < dist then
                dist = d
                nearest = v
            end
        end
    end
    return nearest
end

local function flyTo(targetPart)
    local char = getChar()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    hum.PlatformStand = true
    local timeout = tick() + 10

    while flying and char.Parent and targetPart.Parent do
        if tick() > timeout then break end
        if targetPart:GetAttribute("Collected") then break end

        local targetPos = targetPart.Position
        if flyMode == "นอนคว่ำ" then targetPos = targetPos - Vector3.new(0, 3, 0) end

        local dir = (targetPos - hrp.Position).Unit
        hrp.AssemblyLinearVelocity = dir * flySpeed
        hrp.CFrame = CFrame.new(hrp.Position, targetPos)

        if (hrp.Position - targetPos).Magnitude < 2 then break end
        RunService.RenderStepped:Wait()
    end
    hrp.AssemblyLinearVelocity = Vector3.zero
    collectedCoins[targetPart] = true
    startedCollecting = true
end

addToggleButton(tabFarm, T.farmToggle, false, function(state)
    flying = state
    collectedCoins = {}
    startedCollecting = false
    local char = getChar()

    if not state then
        restore()
        return
    end

    noclipLoop(char)
    task.spawn(function()
        while flying do
            local ok, err = pcall(function()
                local char = getChar()
                local root = char:WaitForChild("HumanoidRootPart", 5)
                if not root then return end
                local coin = getNearestCoin(root)
                if coin then
                    flyTo(coin)
                else
                    if autoReset and startedCollecting then
                        if char then char:BreakJoints() end
                        task.wait(2)
                        startedCollecting = false
                    end
                    task.wait(0.1)
                end
            end)
            if not ok then task.wait(0.5) end
        end
    end)
end)

addHeader(tabFarm, T.farmSecHead)
addToggleButton(tabFarm, T.farmAntiAfk, true, function(state) end)

task.spawn(function()
    while task.wait(60) do
        pcall(function()
            local VirtualUser = game:GetService("VirtualUser")
            VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), Camera.CFrame)
        end)
    end
end)


-- 7. บันทึกอัพเดท (Update Log Tab)
local tabUpdate = createTabContent(T.tabUpdate)
addHeader(tabUpdate, T.upHead)
addParagraph(tabUpdate, T.up1Title, T.up1Desc)
addParagraph(tabUpdate, T.up2Title, T.up2Desc)
addParagraph(tabUpdate, T.up3Title, T.up3Desc)


-- 8. ตั้งค่า (Config Manager Tab)
local tabConfig = createTabContent(T.tabConfig)
addHeader(tabConfig, T.cfgHead)

addButton(tabConfig, T.cfgSave, function()
    saveConfig()
    triggerHalloweenToast("SUCCESS", "💾 บันทึกการตั้งค่าสำเร็จ!", "SUCCESS")
end)

addButton(tabConfig, T.cfgReset, function()
    pcall(function()
        if delfile and isfile(CONFIG_FILE) then delfile(CONFIG_FILE) end
    end)
    triggerHalloweenToast("WARNING", "♻️ รีเซ็ตค่าเริ่มต้นสำเร็จ!", "WARNING")
end)


-- 9. วิธีใช้งาน (User Guide Tab)
local tabGuide = createTabContent(T.tabGuide)
addHeader(tabGuide, T.guHead)
addParagraph(tabGuide, T.gu1Title, T.gu1Desc)
addParagraph(tabGuide, T.gu2Title, T.gu2Desc)
addParagraph(tabGuide, T.gu3Title, T.gu3Desc)

Pages[T.tabMain].Visible = true
TabButtons[T.tabMain].BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TabButtons[T.tabMain].TextColor3 = Color3.fromRGB(15, 10, 20)
PrimaryWindowFrame.Visible = true

----------------------------------------------------------------------------------------------------
-- [11] Widget แสดง ปิง และ FPS
----------------------------------------------------------------------------------------------------
local StatsWidget = Instance.new("TextButton")
StatsWidget.Name = "MeridianStatsWidget"
StatsWidget.Parent = RootContainerNode
StatsWidget.BackgroundColor3 = Color3.fromRGB(15, 10, 22)
StatsWidget.Position = UDim2.new(0.80, 0, 0.12, 0)
StatsWidget.Size = UDim2.new(0, 170, 0, 34)
StatsWidget.Font = Enum.Font.Code
StatsWidget.Text = "🦇 ปิง: 0ms | FPS: 0 🎃"
StatsWidget.TextColor3 = Color3.fromRGB(255, 140, 0)
StatsWidget.TextSize = 10
StatsWidget.Active = true
StatsWidget.Draggable = true
StatsWidget.ZIndex = 8
Instance.new("UICorner", StatsWidget).CornerRadius = UDim.new(0, 8)

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(168, 85, 247)
statsStroke.Transparency = 0.3
statsStroke.Thickness = 1.5
statsStroke.Parent = StatsWidget

task.spawn(function()
    local lastTick = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTick >= 1 then
            frameCount = 0
            lastTick = tick()
        end
        local pingVal = 0
        pcall(function() pingVal = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        StatsWidget.Text = string.format("🦇 ปิง: %d ms | FPS: %d 🎃", pingVal, math.floor(1/RunService.RenderStepped:Wait()))
    end)
end)

----------------------------------------------------------------------------------------------------
-- [12] ปุ่มลอยเปิด/ปิด UI หลัก (Toggle Hub Button)
----------------------------------------------------------------------------------------------------
local ToggleHubGui = Instance.new("ScreenGui")
ToggleHubGui.Name = "MeridianToggleHubGui"
ToggleHubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ToggleHubGui.Parent = CoreGui end)
if not ToggleHubGui.Parent then ToggleHubGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local HubFloatBtn = Instance.new("TextButton")
HubFloatBtn.Name = "HubFloatBtn"
HubFloatBtn.Parent = ToggleHubGui
HubFloatBtn.BackgroundColor3 = Color3.fromRGB(15, 8, 22)
HubFloatBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
HubFloatBtn.Size = UDim2.new(0, 175, 0, 52)
HubFloatBtn.Font = Enum.Font.Code
HubFloatBtn.Text = "+ [ Meridian Hub ]"
HubFloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HubFloatBtn.TextSize = 12
HubFloatBtn.Active = true
HubFloatBtn.Draggable = true
HubFloatBtn.ZIndex = 200
HubFloatBtn.Visible = false
Instance.new("UICorner", HubFloatBtn).CornerRadius = UDim.new(0, 12)

local HubStroke = Instance.new("UIStroke")
HubStroke.Color = Color3.fromRGB(255, 140, 0)
HubStroke.Thickness = 3
HubStroke.Transparency = 0.1
HubStroke.Parent = HubFloatBtn

local HubGlow = Instance.new("Frame")
HubGlow.Parent = HubFloatBtn
HubGlow.BackgroundTransparency = 0.8
HubGlow.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
HubGlow.Size = UDim2.new(1, 0, 1, 0)
HubGlow.ZIndex = 199
Instance.new("UICorner", HubGlow).CornerRadius = UDim.new(0, 12)

HubFloatBtn.MouseButton1Click:Connect(function()
    PrimaryWindowFrame.Visible = true
    HubFloatBtn.Visible = false
    triggerHalloweenToast("SUCCESS", T.showUIToast, "SUCCESS")
end)

HideWindowButton.MouseButton1Click:Connect(function()
    PrimaryWindowFrame.Visible = false
    HubFloatBtn.Visible = true
    triggerHalloweenToast("WARNING", T.hideUIToast, "WARNING")
end)

print("MERIDIAN HUB: Halloween God Mode V4.3 Final Loaded Successfully!")
