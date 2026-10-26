----------------------------------------------------------------------------------------------------
-- 🎃 MERIDIAN HUB // HALLOWEEN ULTIMATE EDITION (V2.2 - ULTRA-STABLE FINAL RELEASE) 👻
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

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
-- [1] รากฐาน GUI & ระบบหน้าต่าง
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
-- [2] ระบบ Toast แจ้งเตือนสไตล์ฮาโลวีน 🎃
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
toastLayout.Padding = UDim.new(0, 8)
toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top

local function triggerHalloweenToast(messageTitle, messageBody, notificationType)
    task.spawn(function()
        local accentColor = Color3.fromRGB(255, 140, 0)
        if notificationType == "SUCCESS" then accentColor = Color3.fromRGB(255, 140, 0)
        elseif notificationType == "WARNING" then accentColor = Color3.fromRGB(168, 85, 247)
        elseif notificationType == "ERROR" then accentColor = Color3.fromRGB(239, 68, 68) end

        local toastCard = Instance.new("Frame")
        toastCard.Parent = ToastNotificationHub
        toastCard.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
        toastCard.Size = UDim2.new(1, 0, 0, 55)
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
        titleLabel.Position = UDim2.new(0, 12, 0, 8)
        titleLabel.Size = UDim2.new(1, -20, 0, 18)
        titleLabel.Font = Enum.Font.Code
        titleLabel.Text = "🎃 " .. messageTitle
        titleLabel.TextColor3 = accentColor
        titleLabel.TextSize = 11
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.ZIndex = 52

        local bodyLabel = Instance.new("TextLabel")
        bodyLabel.Parent = toastCard
        bodyLabel.BackgroundTransparency = 1
        bodyLabel.Position = UDim2.new(0, 12, 0, 26)
        bodyLabel.Size = UDim2.new(1, -20, 0, 20)
        bodyLabel.Font = Enum.Font.Code
        bodyLabel.Text = messageBody
        bodyLabel.TextColor3 = Color3.fromRGB(216, 180, 254)
        bodyLabel.TextSize = 10
        bodyLabel.TextXAlignment = Enum.TextXAlignment.Left
        bodyLabel.ZIndex = 52

        TweenService:Create(toastCard, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(3.5)
        TweenService:Create(toastCard, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        toastCard:Destroy()
    end)
end

----------------------------------------------------------------------------------------------------
-- [3] หน้าจอโหลดสคริปต์ (Loading Screen - 5 วินาที)
----------------------------------------------------------------------------------------------------
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "MeridianLoadingGui"
LoadingGui.IgnoreGuiInset = true
pcall(function() LoadingGui.Parent = CoreGui end)
if not LoadingGui.Parent then LoadingGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local LoadFrame = Instance.new("Frame")
LoadFrame.Parent = LoadingGui
LoadFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 15)
LoadFrame.Size = UDim2.new(1, 0, 1, 0)
LoadFrame.ZIndex = 100

local LoadCard = Instance.new("Frame")
LoadCard.Parent = LoadFrame
LoadCard.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
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
LoadTitle.Text = "🎃 MERIDIAN HUB // LOADING..."
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
LoadSub.Text = "🦇 กำลังเตรียมระบบแจกความหลอนฮาโลวีน..."
LoadSub.TextColor3 = Color3.fromRGB(216, 180, 254)
LoadSub.TextSize = 10
LoadSub.TextXAlignment = Enum.TextXAlignment.Left
LoadSub.ZIndex = 102

local BarBg = Instance.new("Frame")
BarBg.Parent = LoadCard
BarBg.BackgroundColor3 = Color3.fromRGB(10, 6, 15)
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
-- [4] ระบบเลือกภาษา (Language Selection Menu)
----------------------------------------------------------------------------------------------------
local selectedLanguage = "TH"
local LangGui = Instance.new("ScreenGui")
LangGui.Name = "MeridianLangGui"
LangGui.IgnoreGuiInset = true
pcall(function() LangGui.Parent = CoreGui end)
if not LangGui.Parent then LangGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local LangFrame = Instance.new("Frame")
LangFrame.Parent = LangGui
LangFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 15)
LangFrame.Size = UDim2.new(1, 0, 1, 0)
LangFrame.ZIndex = 100

local LangCard = Instance.new("Frame")
LangCard.Parent = LangFrame
LangCard.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
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
ThaiBtn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
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
EngBtn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
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
-- [5] พจนานุกรม 2 ภาษา
----------------------------------------------------------------------------------------------------
local L = {
    TH = {
        hubTitle = "🎃 MERIDIAN HUB // HALLOWEEN EDITION 👻",
        hideUI = "🦇 ซ่อน UI",
        showUI = "คืนชีพ UI",
        showUIToast = "เปิดหน้าต่างฮาโลวีนสำเร็จ",
        hideUIToast = "จำศีลหน้าต่างแล้ว (กดปุ่ม + ค่ายเพื่อเปิด)",
        tabMain = "เมนูหลัก",
        tabESP = "มองผู้เล่น",
        tabGun = "นายอำเภอ",
        tabMurder = "ฆาตรกร",
        tabTeleport = "วาร์ป",
        tabFarm = "ฟาร์มฮาโลวีน",
        tabUpdate = "บันทึกอัพเดท",
        tabGuide = "วิธีใช้งาน",
        -- เมนูหลัก
        mMoveHead = ">> ⚡ ระบบปรับแต่งการเคลื่อนไหว (Movement)",
        mWalk = "เปิดฟังก์ชันวิ่งเร็ว",
        mJump = "เปิดฟังก์ชันกระโดดสูง",
        mInfJump = "⚡ กระโดดไม่จำกัด (Infinite Jump)",
        mUtilHead = ">> 👻 ระบบช่วยเหลือผู้เล่น & ป้องกัน",
        mWalkThrough = "เดินทะลุเพื่อน",
        mAntiFling = "🛡️ กันโปรดีดออกนอกโลก (Anti-Fling)",
        mFullbright = "💡 เปิดแสงสว่างสูงสุด (Fullbright)",
        mNoclip = "👻 ทะลุกำแพงทั่วแมพ (Global Noclip)",
        mFpsBoost = "⚡ เพิ่มความลื่น (FPS Boost / ลบหมอก)",
        -- มองผู้เล่น
        espHead = ">> 👁️ ระบบตาทิพย์ส่องวิญญาณ (เลือกเปิดแยก)",
        espInnocent = "👤 มองผู้เล่น (Innocent)",
        espMurder = "🔪 มองคนฆ่า (Murderer)",
        espSheriff = "🔫 มองคนยิง (Sheriff/Gun)",
        espTracer = "📈 เส้นลากเป้า ESP (Tracer)",
        espBox = "📦 บล็อกมอง ESP (Bounding Box)",
        -- นายอำเภอ
        gunHead = ">> 🔮 เสกปุ่มลอยฉุกเฉิน (ธีมฮาโลวีน)",
        gunGrab = "🎃 วาร์ปเก็บปืน",
        gunShoot = "💀 ยิงปราบผีดิบ",
        gunAuto = "🎯 ออโต้ยิงทะลุ",
        -- ฆาตกร
        murdHead = ">> 🔪 ขยายฮิตบล็อก (ช่วยให้ปามีดโดนง่ายขึ้น)",
        murdHitbox = "ขยายฮิตบล็อกผู้เล่น",
        murdMassHead = ">> 💀 ระบบฆ่าหมู่ (Mass Kill)",
        murdKillAll = "🔪 ฆ่าทุกคนทันที (Mass Kill)",
        murdAutoKill = "⚡ ออโต้ฆ่าทุกคน (Auto Kill)",
        -- วาร์ป
        tpHead = ">> 🚀 ระบบวาร์ปด่วน (Teleport)",
        tpSheriff = "วาร์ปไปหานายอำเภอ",
        tpMurder = "วาร์ปไปหาฆาตรกร",
        tpFriendHead = ">> 👥 วาร์ปหาเพื่อนระบุชื่อ",
        tpDropdown = "เลือกผู้เล่น",
        tpButton = "วาร์ปไปหาเพื่อน",
        -- ฟาร์ม
        farmHead = ">> 💰 ระบบฟาร์มเหรียญอีเว้นท์อัตโนมัติ",
        farmWarnTitle = "⚠️ คำเตือนความปลอดภัย",
        farmWarnDesc = "แนะนำให้ปรับความเร็วไม่เกิน 19 เพื่อป้องกันการโดนแบน",
        farmSpeed = "ความเร็วลอย",
        farmMode = "ท่าลอย",
        farmReset = "รีตัวเมื่อเหรียญหมด",
        farmToggle = "ฟาร์มฮาโลวีนอัตโนมัติ",
        farmSecHead = ">> 🛡️ ระบบป้องกันความปลอดภัย",
        farmAntiAfk = "กันโดนเตะ (Anti-AFK)",
        -- อัพเดท
        upHead = ">> 📝 บันทึกการอัพเดทเวอร์ชันล่าสุด (V2.2 Final)",
        up1Title = "🎃 ระบบ Dual Language & Loading",
        up1Desc = "เพิ่มหน้าโหลด 5 วินาที พร้อมระบบเลือกภาษาไทย/อังกฤษสมบูรณ์ 100%",
        up2Title = "👁️ Advanced ESP & Floating UI",
        up2Desc = "เพิ่มระบบมองแยกบทบาท, เส้น Tracer, ปุ่มลอยออโต้ยิงทะลุกำแพง และปุ่มเปิด UI ค่ายแบบวิบวับ",
        up3Title = "🛡️ Anti-Void & Stability Fix",
        up3Desc = "เพิ่มระบบกันโปรดีดออกนอกโลก ปรับปรุงลูปไม่ให้แย่งซีนกัน ทำงานเสถียรไร้บัค",
        -- วิธีใช้งาน
        guHead = ">> 📖 คู่มือการใช้งานสคริปต์เบื้องต้น",
        gu1Title = "1. การเปิด/ปิดเมนูหลัก",
        gu1Desc = "กดที่ปุ่ม '+' บนปุ่มลอยชื่อค่ายเพื่อเปิด/ปิดหน้าต่างหลัก และลากย้ายปุ่มไปไว้ตรงไหนก็ได้ตามต้องการ",
        gu2Title = "2. การใช้งานปุ่มลอย (Floating Buttons)",
        gu2Desc = "ในหมวดนายอำเภอ สามารถกดเปิดปุ่มลอย (เช่น วาร์ปเก็บปืน, ออโต้ยิงทะลุ) เพื่อกดใช้งานด่วนบนหน้าจอได้ทันที",
        gu3Title = "3. การฟาร์มเหรียญอีเว้นท์",
        gu3Desc = "เลือกความเร็วฟาร์มไม่เกิน 19 และเปิดฟังก์ชันฟาร์มอัตโนมัติในหมวดฟาร์มฮาโลวีนเพื่อความปลอดภัยสูงสุด"
    },
    EN = {
        hubTitle = "🎃 MERIDIAN HUB // HALLOWEEN EDITION 👻",
        hideUI = "🦇 Hide UI",
        showUI = "Restore UI",
        showUIToast = "Halloween window restored successfully",
        hideUIToast = "Window minimized (Press + Hub to open)",
        tabMain = "Main Menu",
        tabESP = "Role ESP",
        tabGun = "Sheriff",
        tabMurder = "Murderer",
        tabTeleport = "Teleport",
        tabFarm = "Halloween Farm",
        tabUpdate = "Update Log",
        tabGuide = "User Guide",
        -- Main
        mMoveHead = ">> ⚡ Movement Customization",
        mWalk = "Enable WalkSpeed",
        mJump = "Enable JumpPower",
        mInfJump = "⚡ Infinite Jump",
        mUtilHead = ">> 👻 Player Utility & Protection",
        mWalkThrough = "Walk Through Players",
        mAntiFling = "🛡️ Anti-Fling (Protect from Void)",
        mFullbright = "💡 Fullbright (Remove Darkness)",
        mNoclip = "👻 Global Noclip (Walk through walls)",
        mFpsBoost = "⚡ FPS Boost (Remove Fog)",
        -- ESP
        espHead = ">> 👁️ Custom Role ESP Systems",
        espInnocent = "👤 Show Innocents",
        espMurder = "🔪 Show Murderer",
        espSheriff = "🔫 Show Sheriff/Gun",
        espTracer = "📈 ESP Tracer Lines",
        espBox = "📦 ESP Bounding Box",
        -- Sheriff
        gunHead = ">> 🔮 Emergency Floating Buttons",
        gunGrab = "🎃 Teleport Gun",
        gunShoot = "💀 Shoot Murderer",
        gunAuto = "🎯 Auto Shoot Wall",
        -- Murderer
        murdHead = ">> 🔪 Hitbox Extender (Easy Knife Throw)",
        murdHitbox = "Expand Player Hitbox",
        murdMassHead = ">> 💀 Mass Kill Systems",
        murdKillAll = "🔪 Mass Kill All",
        murdAutoKill = "⚡ Auto Kill All",
        -- Teleport
        tpHead = ">> 🚀 Quick Teleport",
        tpSheriff = "Teleport to Sheriff",
        tpMurder = "Teleport to Murderer",
        tpFriendHead = ">> 👥 Select Friend to Teleport",
        tpDropdown = "Select Player",
        tpButton = "Teleport to Friend",
        -- Farm
        farmHead = ">> 💰 Auto Coin/Event Farm",
        farmWarnTitle = "⚠️ Safety Warning",
        farmWarnDesc = "Recommended speed below 19 to avoid bans",
        farmSpeed = "Fly Speed",
        farmMode = "Fly Mode",
        farmReset = "Auto Reset when coins deplete",
        farmToggle = "Auto Halloween Farm",
        farmSecHead = ">> 🛡️ Security Systems",
        farmAntiAfk = "Anti-AFK",
        -- Update
        upHead = ">> 📝 Latest Update Logs (V2.2 Final)",
        up1Title = "🎃 Dual Language & Loading Screen",
        up1Desc = "Added 5s loading screen and full Thai/English language selection.",
        up2Title = "👁️ Advanced ESP & Floating Buttons",
        up2Desc = "Added role-based ESP, Tracer lines, and glowing floating buttons.",
        up3Title = "🛡️ Anti-Void & Loop Stability",
        up3Desc = "Added Anti-Fling protection and optimized loops for zero conflicts.",
        -- Guide
        guHead = ">> 📖 Basic Script User Guide",
        gu1Title = "1. Opening/Closing Main Menu",
        gu1Desc = "Click the '+' on the hub floating button to toggle the main UI. Drag it anywhere on screen.",
        gu2Title = "2. Floating Buttons Usage",
        gu2Desc = "In the Sheriff tab, toggle floating buttons (Gun Grab, Auto Shoot Wall) for quick mobile access.",
        gu3Title = "3. Safe Event Farming",
        gu3Desc = "Keep fly speed under 19 and enable auto-farm in the Halloween Farm tab for maximum safety."
    }
}

local T = L[selectedLanguage]

----------------------------------------------------------------------------------------------------
-- [6] หน้าต่างหลักแดชบอร์ด
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MeridianPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 18)
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
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(22, 14, 32)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 45)
HeaderNavigationPanel.ZIndex = 6
Instance.new("UICorner", HeaderNavigationPanel).CornerRadius = UDim.new(0, 14)

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(22, 14, 32)
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
-- [7] ฝั่งซ้าย: โปรไฟล์ + แท็บเมนูแนวตั้ง
----------------------------------------------------------------------------------------------------
local LeftProfileSidebar = Instance.new("Frame")
LeftProfileSidebar.Parent = PrimaryWindowFrame
LeftProfileSidebar.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
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
HealthBarBg.BackgroundColor3 = Color3.fromRGB(10, 6, 15)
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
TabMenuContainer.CanvasSize = UDim2.new(0, 0, 0, 320)
TabMenuContainer.ScrollBarThickness = 2
TabMenuContainer.ZIndex = 7

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = TabMenuContainer
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 6)

----------------------------------------------------------------------------------------------------
-- [8] UI Components & Creators
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
    menuBtn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    menuBtn.Size = UDim2.new(1, 0, 0, 32)
    menuBtn.Font = Enum.Font.Code
    menuBtn.Text = "  👻 " .. tabName
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
                btn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
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
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(168, 85, 247)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    return lbl
end

local function addParagraph(parent, title, desc)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
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
    tLbl.Text = title
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
    dLbl.Text = desc
    dLbl.TextColor3 = Color3.fromRGB(216, 180, 254)
    dLbl.TextSize = 9
    dLbl.TextXAlignment = Enum.TextXAlignment.Left
    dLbl.ZIndex = 7
end

local function addButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = "  " .. text
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

    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

local function addToggleButton(parent, text, defaultState, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(255, 140, 0) or Color3.fromRGB(25, 16, 38)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = defaultState and ("  [ เปิด ] " .. text) or ("  [ ปิด ] " .. text)
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
            btn.Text = "  [ เปิด ] " .. text
            btn.TextColor3 = Color3.fromRGB(15, 10, 20)
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
            btn.Text = "  [ ปิด ] " .. text
            btn.TextColor3 = Color3.fromRGB(216, 180, 254)
        end
        callback(state)
    end)
    return btn
end

local function addToggleWithInput(parent, text, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Size = UDim2.new(1, -70, 1, 0)
    toggleBtn.Font = Enum.Font.Code
    toggleBtn.Text = "  [ ปิด ] " .. text
    toggleBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
    toggleBtn.TextSize = 10
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    toggleBtn.ZIndex = 7

    local inputBox = Instance.new("TextBox")
    inputBox.Parent = frame
    inputBox.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
    inputBox.Size = UDim2.new(0, 55, 0, 26)
    inputBox.Position = UDim2.new(1, -62, 0.5, -13)
    inputBox.Font = Enum.Font.Code
    inputBox.Text = tostring(defaultVal)
    inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
    inputBox.TextSize = 11
    inputBox.ZIndex = 7
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)

    local boxStroke = Instance.new("UIStroke")
    boxStroke.Color = Color3.fromRGB(168, 85, 247)
    boxStroke.Thickness = 1
    boxStroke.Parent = inputBox

    local activeState = false
    local currentNum = defaultVal

    toggleBtn.MouseButton1Click:Connect(function()
        activeState = not activeState
        if activeState then
            frame.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            toggleBtn.Text = "  [ เปิด ] " .. text
            toggleBtn.TextColor3 = Color3.fromRGB(15, 10, 20)
            inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            frame.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
            toggleBtn.Text = "  [ ปิด ] " .. text
            toggleBtn.TextColor3 = Color3.fromRGB(216, 180, 254)
            inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
        end
        callback(activeState, currentNum)
    end)

    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val then
            currentNum = val
            if activeState then callback(activeState, currentNum) end
            triggerHalloweenToast("SUCCESS", "Updated value to " .. tostring(currentNum), "SUCCESS")
        else
            inputBox.Text = tostring(currentNum)
        end
    end)
end

local function addSlider(parent, title, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    frame.Size = UDim2.new(1, 0, 0, 48)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Parent = frame
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 10, 0, 6)
    lbl.Size = UDim2.new(1, -20, 0, 16)
    lbl.Font = Enum.Font.Code
    lbl.Text = string.format("  %s: [%d]", title, defaultVal)
    lbl.TextColor3 = Color3.fromRGB(216, 180, 254)
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 7

    local inputBox = Instance.new("TextBox")
    inputBox.Parent = frame
    inputBox.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
    inputBox.Size = UDim2.new(0, 65, 0, 22)
    inputBox.Position = UDim2.new(1, -72, 0, 21)
    inputBox.Font = Enum.Font.Code
    inputBox.Text = tostring(defaultVal)
    inputBox.TextColor3 = Color3.fromRGB(255, 140, 0)
    inputBox.TextSize = 10
    inputBox.ZIndex = 7
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 5)

    inputBox.FocusLost:Connect(function()
        local val = tonumber(inputBox.Text)
        if val then
            val = math.clamp(val, minVal, maxVal)
            inputBox.Text = tostring(val)
            lbl.Text = string.format("  %s: [%d]", title, val)
            callback(val)
        else
            inputBox.Text = tostring(defaultVal)
        end
    end)
end

local function addDropdown(parent, title, options, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.ZIndex = 6
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Font = Enum.Font.Code
    btn.Text = string.format("  %s: < %s >", title, defaultVal)
    btn.TextColor3 = Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 7

    local currentIdx = 1
    for i, opt in ipairs(options) do
        if opt == defaultVal then currentIdx = i break end
    end

    local dropdownObj = {}
    function dropdownObj:Refresh(newOptions)
        options = newOptions
        if #options > 0 then
            currentIdx = math.clamp(currentIdx, 1, #options)
            local selected = options[currentIdx]
            btn.Text = string.format("  %s: < %s >", title, selected)
            callback(selected)
        else
            currentIdx = 1
            btn.Text = string.format("  %s: < None >", title)
            callback(nil)
        end
    end

    btn.MouseButton1Click:Connect(function()
        if #options == 0 then return end
        currentIdx = currentIdx + 1
        if currentIdx > #options then currentIdx = 1 end
        local selected = options[currentIdx]
        btn.Text = string.format("  %s: < %s >", title, selected)
        callback(selected)
    end)

    return dropdownObj
end

local function addFloatingToggle(parent, text, defaultPos, themeColor, borderColor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Font = Enum.Font.Code
    btn.Text = "  [ ปิด ] " .. text
    btn.TextColor3 = Color3.fromRGB(216, 180, 254)
    btn.TextSize = 10
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local activeState = false
    local floatingButtonInstance = nil

    local function removeFloatBtn()
        if floatingButtonInstance then
            floatingButtonInstance:Destroy()
            floatingButtonInstance = nil
        end
    end

    local function createFloatBtn()
        removeFloatBtn()
        local fBtn = Instance.new("TextButton")
        fBtn.Name = "Float_" .. text
        fBtn.Parent = FloatGui
        fBtn.BackgroundColor3 = Color3.fromRGB(18, 10, 28)
        fBtn.Size = UDim2.new(0, 145, 0, 48)
        fBtn.Position = defaultPos
        fBtn.Font = Enum.Font.Code
        fBtn.Text = text
        fBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        fBtn.TextSize = 12
        fBtn.Active = true
        fBtn.Draggable = true
        fBtn.ZIndex = 100
        
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 12)
        fCorner.Parent = fBtn

        local stroke = Instance.new("UIStroke")
        stroke.Color = borderColor
        stroke.Thickness = 2
        stroke.Transparency = 0.1
        stroke.Parent = fBtn

        local innerGlow = Instance.new("Frame")
        innerGlow.Parent = fBtn
        innerGlow.BackgroundTransparency = 0.85
        innerGlow.BackgroundColor3 = themeColor
        innerGlow.Size = UDim2.new(1, 0, 1, 0)
        innerGlow.ZIndex = 99
        Instance.new("UICorner", innerGlow).CornerRadius = UDim.new(0, 12)

        fBtn.MouseButton1Click:Connect(function() callback(fBtn) end)
        floatingButtonInstance = fBtn
    end

    btn.MouseButton1Click:Connect(function()
        activeState = not activeState
        if activeState then
            btn.BackgroundColor3 = themeColor
            btn.Text = "  [ เปิด ] " .. text
            btn.TextColor3 = Color3.fromRGB(15, 10, 20)
            createFloatBtn()
            triggerHalloweenToast("SUCCESS", "Spawned floating button [" .. text .. "]", "SUCCESS")
        else
            btn.BackgroundColor3 = Color3.fromRGB(25, 16, 38)
            btn.Text = "  [ ปิด ] " .. text
            btn.TextColor3 = Color3.fromRGB(216, 180, 254)
            removeFloatBtn()
            triggerHalloweenToast("WARNING", "Removed floating button [" .. text .. "]", "WARNING")
        end
    end)
    return btn
end

----------------------------------------------------------------------------------------------------
-- [9] สร้างเนื้อหาแต่ละแท็บ
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
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end
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


-- 2. มองผู้เล่น (Role ESP)
local tabESP = createTabContent(T.tabESP)
addHeader(tabESP, T.espHead)

local espInnocent = false
local espMurderer = false
local espSheriff = false
local espTracer = false
local espBox = false

addToggleButton(tabESP, T.espInnocent, false, function(state) espInnocent = state end)
addToggleButton(tabESP, T.espMurderer, false, function(state) espMurderer = state end)
addToggleButton(tabESP, T.espSheriff, false, function(state) espSheriff = state end)
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
local function removeESP(char)
    if not char then return end
    local hl = char:FindFirstChild("RoleESP")
    if hl then hl:Destroy() end
    local tag = char:FindFirstChild("RoleTag")
    if tag then tag:Destroy() end
end

RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
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
                    if head and not char:FindFirstChild("RoleTag") then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "RoleTag"
                        bb.Size = UDim2.new(0, 160, 0, 30)
                        bb.StudsOffset = Vector3.new(0, 2, 0)
                        bb.AlwaysOnTop = true
                        bb.Adornee = head
                        bb.Parent = char

                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.TextScaled = true
                        lbl.Text = text
                        lbl.TextColor3 = color
                        lbl.Font = Enum.Font.Code
                        lbl.Parent = bb
                    end
                else
                    if char:FindFirstChild("RoleTag") then char.RoleTag:Destroy() end
                end
            else
                removeESP(char)
            end

            local line = tracerLines[plr]
            if espTracer and shouldShow and char:FindFirstChild("HumanoidRootPart") then
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
            if tracerLines[plr] then tracerLines[plr].Visible = false end
        end
    end
end)


-- 3. นายอำเภอ
local tabGun = createTabContent(T.tabGun)
addHeader(tabGun, T.gunHead)

addFloatingToggle(tabGun, T.gunGrab, UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(255, 140, 0), Color3.fromRGB(255, 165, 0), function(btn)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local gunPart = nil

    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "GunDrop" then
            gunPart = v:IsA("Model") and (v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart")) or (v:IsA("BasePart") and v)
            if gunPart then break end
        end
    end

    if not gunPart then return end
    local oldPos = root.CFrame
    root.CFrame = gunPart.CFrame
    if firetouchinterest then
        firetouchinterest(root, gunPart, 0)
        task.wait(0.05)
        firetouchinterest(root, gunPart, 1)
    end
    task.wait(0.1)
    root.CFrame = oldPos
end)

addFloatingToggle(tabGun, T.gunShoot, UDim2.new(0.05, 0, 0.35, 0), Color3.fromRGB(168, 85, 247), Color3.fromRGB(216, 180, 254), function(btn)
    local character = LocalPlayer.Character
    if not character then return end
    local tool = character:FindFirstChild("Gun") or character:FindFirstChild("Revolver")
    if not tool then return end

    local remote = tool:FindFirstChild("Shoot")
    local root = character:FindFirstChild("HumanoidRootPart")
    local attachment = root and root:FindFirstChild("GunRaycastAttachment")
    if not remote or not root or not attachment then return end

    local targetPlr = nil
    local shortestDist = math.huge

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if getRole(plr) == "Knife" then
                local pos, visible = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if visible then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        targetPlr = plr
                    end
                end
            end
        end
    end

    if targetPlr then
        remote:FireServer(attachment.WorldCFrame, CFrame.new(targetPlr.Character.HumanoidRootPart.Position))
    end
end)

local function getSheriff()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and getRole(plr) == "Gun" then return plr end
    end
    return nil
end

local function getMurderer()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and getRole(plr) == "Knife" then return plr end
    end
    return nil
end

local autoShootWall = false
addFloatingToggle(tabGun, T.gunAuto, UDim2.new(0.05, 0, 0.50, 0), Color3.fromRGB(59, 130, 246), Color3.fromRGB(147, 197, 253), function(btn)
    autoShootWall = not autoShootWall
end)

local function shootMurderer()
    local char = LocalPlayer.Character
    if not char then return end
    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
    if not gun then return end
    if gun.Parent ~= char then gun.Parent = char end

    local remote = gun:FindFirstChild("Shoot")
    local root = char:FindFirstChild("HumanoidRootPart")
    local attachment = root and root:FindFirstChild("GunRaycastAttachment")
    if not remote or not root or not attachment then return end

    local murderer = getMurderer()
    if not murderer or not murderer.Character or not murderer.Character:FindFirstChild("Head") then return end

    local head = murderer.Character.Head
    local velocity = head.AssemblyLinearVelocity
    local predictedPosition = head.Position + velocity * 0.18

    remote:FireServer(attachment.WorldCFrame, CFrame.new(predictedPosition))
end

RunService.RenderStepped:Connect(function()
    if not autoShootWall then return end
    shootMurderer()
end)


-- 4. ฆาตกร
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
            local enemyRoot = plr.Character.HumanoidRootPart
            enemyRoot.CFrame = root.CFrame * CFrame.new(0, 0, -3)
        end
    end
end

local killAllState = false
local autoKillState = false

addToggleButton(tabMurder, T.murdKillAll, false, function(state)
    killAllState = state
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
    if sheriff then teleportTo(sheriff) end
end)

addButton(tabTeleport, T.tpMurder, function()
    local murderer = getMurderer()
    if murderer then teleportTo(murderer) end
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

local function refreshPlayers()
    playerDropdown:Refresh(getPlayerList())
end
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)


-- 6. ฟาร์มฮาโลวีน
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

LocalPlayer.CharacterAdded:Connect(function(char)
    if not flying then return end
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")
    local lastPos = hrp.Position
    repeat
        task.wait(0.2)
        local newPos = hrp.Position
        if (newPos - lastPos).Magnitude > 1 then lastPos = newPos else break end
    until not flying

    task.wait(0.3)
    if flying then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
        noclipLoop(char)
    end
end)

local function getNearestCoin(root)
    local nearest
    local dist = math.huge
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "Coin_Server" and v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and v:FindFirstChild("CoinVisual") and not collectedCoins[v] and not v:GetAttribute("Collected") then
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

        if flyMode == "นอนคว่ำ" then
            hrp.CFrame = CFrame.new(hrp.Position, targetPart.Position) * CFrame.Angles(math.rad(90), 0, 0)
        else
            hrp.CFrame = CFrame.new(hrp.Position, targetPart.Position)
        end

        if (hrp.Position - targetPos).Magnitude < 2 then
            hrp.CFrame = CFrame.new(targetPos)
            break
        end
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

local AntiAFKConnection
addToggleButton(tabFarm, T.farmAntiAfk, true, function(state)
    if state then
        if not AntiAFKConnection then
            AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                pcall(function()
                    local VirtualUser = game:GetService("VirtualUser")
                    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                    task.wait(1)
                    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
                end)
            end)
        end
    else
        if AntiAFKConnection then
            AntiAFKConnection:Disconnect()
            AntiAFKConnection = nil
        end
    end
end)

AntiAFKConnection = LocalPlayer.Idled:Connect(function()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    end)
end)


-- 7. บันทึกอัพเดท (Update Log)
local tabUpdate = createTabContent(T.tabUpdate)
addHeader(tabUpdate, T.upHead)
addParagraph(tabUpdate, T.up1Title, T.up1Desc)
addParagraph(tabUpdate, T.up2Title, T.up2Desc)
addParagraph(tabUpdate, T.up3Title, T.up3Desc)


-- 8. วิธีใช้งาน (User Guide)
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
-- [10] Widget แสดง ปิง และ FPS
----------------------------------------------------------------------------------------------------
local StatsWidget = Instance.new("TextButton")
StatsWidget.Name = "MeridianStatsWidget"
StatsWidget.Parent = RootContainerNode
StatsWidget.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
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
-- [11] ปุ่มลอยเปิด/ปิด UI หลัก (สไตล์ + [ Meridian Hub ] ขอบวิบวับใหญ่ กดง่าย ลากย้ายได้)
----------------------------------------------------------------------------------------------------
local ToggleHubGui = Instance.new("ScreenGui")
ToggleHubGui.Name = "MeridianToggleHubGui"
ToggleHubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ToggleHubGui.Parent = CoreGui end)
if not ToggleHubGui.Parent then ToggleHubGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local HubFloatBtn = Instance.new("TextButton")
HubFloatBtn.Name = "HubFloatBtn"
HubFloatBtn.Parent = ToggleHubGui
HubFloatBtn.BackgroundColor3 = Color3.fromRGB(18, 10, 28)
HubFloatBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
HubFloatBtn.Size = UDim2.new(0, 175, 0, 52)
HubFloatBtn.Font = Enum.Font.Code
HubFloatBtn.Text = "+ [ Meridian Hub ]"
HubFloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HubFloatBtn.TextSize = 12
HubFloatBtn.Active = true
HubFloatBtn.Draggable = true
HubFloatBtn.ZIndex = 200
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
    local isVisible = not PrimaryWindowFrame.Visible
    PrimaryWindowFrame.Visible = isVisible
    triggerHalloweenToast("SUCCESS", isVisible and T.showUIToast or T.hideUIToast, isVisible and "SUCCESS" or "WARNING")
end)

HideWindowButton.MouseButton1Click:Connect(function()
    PrimaryWindowFrame.Visible = false
    triggerHalloweenToast("WARNING", T.hideUIToast, "WARNING")
end)

print("MERIDIAN HUB: Halloween Spooky V2.2 Ultra-Stable Edition Loaded Successfully! Ready to Share!")
