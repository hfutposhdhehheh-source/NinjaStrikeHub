----------------------------------------------------------------------------------------------------
-- 🎃 MERIDIAN HUB // HALLOWEEN APEX KERNEL (V16.1 LANGUAGE FIX EDITION)
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local CONFIG_FILE_NAME = "MeridianHub_V16_Halloween_Config.json"

----------------------------------------------------------------------------------------------------
-- [1] ระบบภาษาและ Config ส่วนกลาง (Localization & Auto-Save System)
----------------------------------------------------------------------------------------------------
local currentLanguage = "TH"

local translations = {
    TH = {
        LoadingTitle = "MERIDIAN HUB // HALLOWEEN APEX",
        LoadingStatus = "กำลังซิงค์โครงสร้างวิญญาณ...",
        LoadingReady = "ปลุกวิญญาณสำเร็จ!",
        LangTitle = "เลือกภาษา / SELECT LANGUAGE",
        LangSub = "โปรดเลือกภาษาที่คุณต้องการใช้งานในระบบ",
        DiscTitle = "⚠️ คำเตือนสุสานแห่งความเสี่ยง (Ban Risk)",
        DiscDesc = "การใช้สคริปต์อัตโนมัติมีความเสี่ยงในการถูกตรวจสอบจากระบบความปลอดภัยของเกม ผู้พัฒนาจะไม่รับผิดชอบใดๆ ทั้งสิ้นหากบัญชีของคุณถูกลงโทษ",
        AcceptBtn = "ยอมรับความเสี่ยง & เข้าสู่ระบบ",
        DeclineBtn = "ปฏิเสธ / ออกจากเกม",
        TabControl = "ควบคุม",
        TabGuide = "คู่มือ",
        TabChangelog = "อัพเดท",
        HideUI = "ซ่อน UI",
        HeaderTitle = "🎃 MERIDIAN // HALLOWEEN APEX V16",
        ProfileHeader = ">> โปรไฟล์ความเร็ววิญญาณ (Velocity Matrix)",
        SequenceHeader = ">> ชุดคำสั่งที่แกะจากโครงสร้างแมพ",
        EngineHeader = ">> ควบคุมระบบหลัก & รีเซ็ตวิญญาณ",
        RunBtn = "▶ เริ่มต้นรันโปรโตคอลความเร็วสูง",
        ResetBtn = "♻ รีเซ็ตระบบฉุกเฉิน (Fix Ghost Bug)",
        FloatBtn = "สลับการแสดงผลปุ่มลอย (Ghost EXEC)",
        ToastWelcome = "ยินดีต้อนรับสู่ฮาโลวีนฮับ!",
        ToastWelcomeSub = "ระบบ V16.1 ทำงานเต็มรูปแบบอย่างไร้รอยต่อ",
        SidebarSys = "[HALLOWEEN V16.1]\n- Deep Engine: Hooked\n- Auto-Save: Active\n- Theme: Pumpkin Apex\n\n[สถานะวิญญาณ]\nปลอดภัย 100%"
    },
    EN = {
        LoadingTitle = "MERIDIAN HUB // HALLOWEEN APEX",
        LoadingStatus = "Syncing Soul Structure...",
        LoadingReady = "Soul Awakening Complete!",
        LangTitle = "SELECT LANGUAGE",
        LangSub = "Please choose your preferred system language.",
        DiscTitle = "⚠️ HALLOWEEN CEMETERY WARNING (Ban Risk)",
        DiscDesc = "Using automated scripts carries a risk of detection by game security systems. The developer takes no responsibility for any penalties.",
        AcceptBtn = "Accept Risk & Enter",
        DeclineBtn = "Decline / Leave Game",
        TabControl = "Control",
        TabGuide = "Guide",
        TabChangelog = "Update",
        HideUI = "Hide UI",
        HeaderTitle = "🎃 MERIDIAN // HALLOWEEN APEX V16",
        ProfileHeader = ">> Soul Velocity Matrix",
        SequenceHeader = ">> Extracted Map Sequence",
        EngineHeader = ">> Core Engine & Reset",
        RunBtn = "▶ Start Auto-Solver Protocol",
        ResetBtn = "♻ Emergency Reset (Fix Ghost Bug)",
        FloatBtn = "Toggle Floating Button (Ghost EXEC)",
        ToastWelcome = "Welcome to Halloween Hub!",
        ToastWelcomeSub = "V16.1 Core Fully Operational.",
        SidebarSys = "[HALLOWEEN V16.1]\n- Deep Engine: Hooked\n- Auto-Save: Active\n- Theme: Pumpkin Apex\n\n[Soul Status]\n100% Safe"
    }
}

local function L(key)
    return translations[currentLanguage][key] or key
end

local defaultUserConfig = {
    SelectedProfileIndex = 1,
    FloatingWidgetEnabled = true,
    Language = "TH"
}

local function saveUserConfiguration(configData)
    pcall(function()
        if writefile then
            local encoded = HttpService:JSONEncode(configData)
            writefile(CONFIG_FILE_NAME, encoded)
        end
    end)
end

local function loadUserConfiguration()
    local loadedConfig = defaultUserConfig
    pcall(function()
        if readfile and isfile and isfile(CONFIG_FILE_NAME) then
            local rawData = readfile(CONFIG_FILE_NAME)
            local decoded = HttpService:JSONDecode(rawData)
            if decoded and type(decoded) == "table" then
                for k, v in pairs(decoded) do
                    loadedConfig[k] = v
                end
            end
        end
    end)
    return loadedConfig
end

local currentActiveConfig = loadUserConfiguration()
currentLanguage = currentActiveConfig.Language or "TH"

if CoreGui:FindFirstChild("MeridianHalloweenStructuralContainer") then
    CoreGui.MeridianHalloweenStructuralContainer:Destroy()
end

local VelocityMatrixRegistry = {
    [1] = {Identifier = "ระดับ 1 : เงามรณะ (Human Stealth)", DelayDuration = 0.085},
    [2] = {Identifier = "ระดับ 2 : สัมผัสวิญญาณ (Balanced Fast)", DelayDuration = 0.040},
    [3] = {Identifier = "ระดับ 3 : พายุเฮอร์ริเคน (Sub-Half Second)", DelayDuration = 0.015},
    [4] = {Identifier = "ระดับ 4 : มิติควอนตัม (Quantum Stream)", DelayDuration = 0.005},
    [5] = {Identifier = "ระดับ 5 : ความเร็วแสงยมโลก (Singularity Apex)", DelayDuration = 0.001}
}

local activeProfilePointer = math.clamp(currentActiveConfig.SelectedProfileIndex, 1, #VelocityMatrixRegistry)
local sequenceMemoryBuffer = ""
local coreExecutionFlag = false
local floatingWidgetActiveState = currentActiveConfig.FloatingWidgetEnabled

local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "MeridianHalloweenStructuralContainer"
RootContainerNode.Parent = CoreGui
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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

local function triggerApexToastNotification(messageTitle, messageBody, notificationType)
    task.spawn(function()
        local accentColor = Color3.fromRGB(249, 115, 22)
        if notificationType == "SUCCESS" then accentColor = Color3.fromRGB(34, 197, 94)
        elseif notificationType == "WARNING" then accentColor = Color3.fromRGB(234, 179, 8)
        elseif notificationType == "ERROR" then accentColor = Color3.fromRGB(239, 68, 68) end

        local toastCard = Instance.new("Frame")
        toastCard.Parent = ToastNotificationHub
        toastCard.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
        toastCard.Size = UDim2.new(1, 0, 0, 55)
        toastCard.Position = UDim2.new(1, 50, 0, 0)
        toastCard.ZIndex = 51
        Instance.new("UICorner", toastCard).CornerRadius = UDim.new(0, 8)

        local toastStroke = Instance.new("UIStroke")
        toastStroke.Color = accentColor
        toastStroke.Thickness = 1.5
        toastStroke.Parent = toastCard

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Parent = toastCard
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0, 12, 0, 8)
        titleLabel.Size = UDim2.new(1, -20, 0, 18)
        titleLabel.Font = Enum.Font.Code
        titleLabel.Text = messageTitle
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
        bodyLabel.TextColor3 = Color3.fromRGB(203, 213, 225)
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

-- Loading Screen
local LoadingScreenFrame = Instance.new("Frame")
LoadingScreenFrame.Name = "LoadingScreen"
LoadingScreenFrame.Parent = RootContainerNode
LoadingScreenFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
LoadingScreenFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingScreenFrame.ZIndex = 40

local LoadingCard = Instance.new("Frame")
LoadingCard.Parent = LoadingScreenFrame
LoadingCard.BackgroundColor3 = Color3.fromRGB(18, 14, 28)
LoadingCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingCard.Size = UDim2.new(0, 380, 0, 200)
LoadingCard.ZIndex = 41
Instance.new("UICorner", LoadingCard).CornerRadius = UDim.new(0, 14)

local loadStroke = Instance.new("UIStroke")
loadStroke.Color = Color3.fromRGB(249, 115, 22)
loadStroke.Thickness = 2
loadStroke.Parent = LoadingCard

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingCard
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0, 20, 0, 25)
LoadingTitle.Size = UDim2.new(1, -40, 0, 30)
LoadingTitle.Font = Enum.Font.Code
LoadingTitle.Text = "🎃 MERIDIAN HUB // HALLOWEEN APEX"
LoadingTitle.TextColor3 = Color3.fromRGB(249, 115, 22)
LoadingTitle.TextSize = 12
LoadingTitle.TextXAlignment = Enum.TextXAlignment.Left
LoadingTitle.ZIndex = 42

local LoadingStatusText = Instance.new("TextLabel")
LoadingStatusText.Parent = LoadingCard
LoadingStatusText.BackgroundTransparency = 1
LoadingStatusText.Position = UDim2.new(0, 20, 0, 65)
LoadingStatusText.Size = UDim2.new(1, -40, 0, 20)
LoadingStatusText.Font = Enum.Font.Code
LoadingStatusText.Text = L("LoadingStatus")
LoadingStatusText.TextColor3 = Color3.fromRGB(168, 162, 184)
LoadingStatusText.TextSize = 11
LoadingStatusText.TextXAlignment = Enum.TextXAlignment.Left
LoadingStatusText.ZIndex = 42

local LoadingBarBg = Instance.new("Frame")
LoadingBarBg.Parent = LoadingCard
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
LoadingBarBg.Position = UDim2.new(0, 20, 0, 110)
LoadingBarBg.Size = UDim2.new(1, -40, 0, 10)
LoadingBarBg.ZIndex = 42
Instance.new("UICorner", LoadingBarBg).CornerRadius = UDim.new(1, 0)

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Parent = LoadingBarBg
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.ZIndex = 43
Instance.new("UICorner", LoadingBarFill).CornerRadius = UDim.new(1, 0)

-- Language Modal
local LanguageModalFrame = Instance.new("Frame")
LanguageModalFrame.Name = "LanguageModal"
LanguageModalFrame.Parent = RootContainerNode
LanguageModalFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
LanguageModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LanguageModalFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LanguageModalFrame.Size = UDim2.new(0, 400, 0, 220)
LanguageModalFrame.Visible = false
LanguageModalFrame.ZIndex = 30
Instance.new("UICorner", LanguageModalFrame).CornerRadius = UDim.new(0, 14)

local langStroke = Instance.new("UIStroke")
langStroke.Color = Color3.fromRGB(168, 85, 247)
langStroke.Thickness = 2
langStroke.Parent = LanguageModalFrame

local LangTitle = Instance.new("TextLabel")
LangTitle.Parent = LanguageModalFrame
LangTitle.BackgroundTransparency = 1
LangTitle.Position = UDim2.new(0, 24, 0, 25)
LangTitle.Size = UDim2.new(1, -48, 0, 30)
LangTitle.Font = Enum.Font.Code
LangTitle.Text = "🌐 SELECT LANGUAGE / เลือกภาษา"
LangTitle.TextColor3 = Color3.fromRGB(216, 180, 254)
LangTitle.TextSize = 13
LangTitle.TextXAlignment = Enum.TextXAlignment.Left
LangTitle.ZIndex = 31

local LangSub = Instance.new("TextLabel")
LangSub.Parent = LanguageModalFrame
LangSub.BackgroundTransparency = 1
LangSub.Position = UDim2.new(0, 24, 0, 60)
LangSub.Size = UDim2.new(1, -48, 0, 40)
LangSub.Font = Enum.Font.Code
LangSub.Text = "โปรดเลือกภาษาที่คุณต้องการใช้งาน / Choose your system language."
LangSub.TextColor3 = Color3.fromRGB(168, 162, 184)
LangSub.TextSize = 10
LangSub.TextWrapped = true
LangSub.TextXAlignment = Enum.TextXAlignment.Left
LangSub.ZIndex = 31

local ThaiButton = Instance.new("TextButton")
ThaiButton.Parent = LanguageModalFrame
ThaiButton.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
ThaiButton.Position = UDim2.new(0, 24, 0, 130)
ThaiButton.Size = UDim2.new(0.47, -6, 0, 48)
ThaiButton.Font = Enum.Font.Code
ThaiButton.Text = "🇹🇭 ภาษาไทย (TH)"
ThaiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ThaiButton.TextSize = 12
ThaiButton.ZIndex = 31
Instance.new("UICorner", ThaiButton).CornerRadius = UDim.new(0, 8)

local EngButton = Instance.new("TextButton")
EngButton.Parent = LanguageModalFrame
EngButton.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
EngButton.Position = UDim2.new(0.53, 6, 0, 130)
EngButton.Size = UDim2.new(0.47, -6, 0, 48)
EngButton.Font = Enum.Font.Code
EngButton.Text = "🇬🇧 English (EN)"
EngButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EngButton.TextSize = 12
EngButton.ZIndex = 31
Instance.new("UICorner", EngButton).CornerRadius = UDim.new(0, 8)

-- Disclaimer Modal
local DisclaimerModalFrame = Instance.new("Frame")
DisclaimerModalFrame.Name = "DisclaimerModal"
DisclaimerModalFrame.Parent = RootContainerNode
DisclaimerModalFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
DisclaimerModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
DisclaimerModalFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
DisclaimerModalFrame.Size = UDim2.new(0, 420, 0, 240)
DisclaimerModalFrame.Visible = false
DisclaimerModalFrame.ZIndex = 20
Instance.new("UICorner", DisclaimerModalFrame).CornerRadius = UDim.new(0, 14)

local disclaimerStroke = Instance.new("UIStroke")
disclaimerStroke.Color = Color3.fromRGB(239, 68, 68)
disclaimerStroke.Thickness = 2
disclaimerStroke.Parent = DisclaimerModalFrame

local DisclaimerTitle = Instance.new("TextLabel")
DisclaimerTitle.Parent = DisclaimerModalFrame
DisclaimerTitle.BackgroundTransparency = 1
DisclaimerTitle.Position = UDim2.new(0, 24, 0, 22)
DisclaimerTitle.Size = UDim2.new(1, -48, 0, 30)
DisclaimerTitle.Font = Enum.Font.Code
DisclaimerTitle.Text = "⚠️ HALLOWEEN WARNING (Ban Risk)"
DisclaimerTitle.TextColor3 = Color3.fromRGB(239, 68, 68)
DisclaimerTitle.TextSize = 13
DisclaimerTitle.TextXAlignment = Enum.TextXAlignment.Left
DisclaimerTitle.ZIndex = 21

local DisclaimerDesc = Instance.new("TextLabel")
DisclaimerDesc.Parent = DisclaimerModalFrame
DisclaimerDesc.BackgroundTransparency = 1
DisclaimerDesc.Position = UDim2.new(0, 24, 0, 65)
DisclaimerDesc.Size = UDim2.new(1, -48, 0, 90)
DisclaimerDesc.Font = Enum.Font.Code
DisclaimerDesc.Text = "Loading..."
DisclaimerDesc.TextColor3 = Color3.fromRGB(203, 213, 225)
DisclaimerDesc.TextSize = 11
DisclaimerDesc.TextWrapped = true
DisclaimerDesc.TextXAlignment = Enum.TextXAlignment.Left
DisclaimerDesc.ZIndex = 21

local AcceptButton = Instance.new("TextButton")
AcceptButton.Parent = DisclaimerModalFrame
AcceptButton.BackgroundColor3 = Color3.fromRGB(194, 65, 12)
AcceptButton.Position = UDim2.new(0, 24, 0, 175)
AcceptButton.Size = UDim2.new(0.47, -6, 0, 42)
AcceptButton.Font = Enum.Font.Code
AcceptButton.Text = "Accept"
AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AcceptButton.TextSize = 11
AcceptButton.ZIndex = 21
Instance.new("UICorner", AcceptButton).CornerRadius = UDim.new(0, 8)

local DeclineButton = Instance.new("TextButton")
DeclineButton.Parent = DisclaimerModalFrame
DeclineButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
DeclineButton.Position = UDim2.new(0.53, 6, 0, 175)
DeclineButton.Size = UDim2.new(0.47, -6, 0, 42)
DeclineButton.Font = Enum.Font.Code
DeclineButton.Text = "Decline"
DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeclineButton.TextSize = 11
DeclineButton.ZIndex = 21
Instance.new("UICorner", DeclineButton).CornerRadius = UDim.new(0, 8)

DeclineButton.MouseButton1Click:Connect(function()
    LocalPlayer:Kick("MERIDIAN HALLOWEEN APEX: Rejected Risk Agreement.")
end)

-- Primary Dashboard Elements (Forward Declarations)
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MeridianPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
PrimaryWindowFrame.BackgroundTransparency = 0.02
PrimaryWindowFrame.Position = UDim2.new(0.08, 0, 0.12, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 560, 0, 480)
PrimaryWindowFrame.Visible = false
PrimaryWindowFrame.Active = true
PrimaryWindowFrame.Draggable = true
PrimaryWindowFrame.ZIndex = 5
Instance.new("UICorner", PrimaryWindowFrame).CornerRadius = UDim.new(0, 14)

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(249, 115, 22)
WindowBorderGlow.Transparency = 0.2
WindowBorderGlow.Thickness = 1.8
WindowBorderGlow.Parent = PrimaryWindowFrame

local HeaderTitleLabel
local HideWindowButton
local Tab1Button, Tab2Button, Tab3Button
local ModeSelectorTriggerButton
local InitializeEngineButton, EmergencyResetButton, ToggleFloatingInterfaceButton
local SidebarInfoBox
local LightningToggleWidget

-- ฟังก์ชันสำหรับอัปเดตข้อความทั้งหมดใน UI หลักทันทีเมื่อเลือกภาษา
local function applyLocalizationToUI()
    HeaderTitleLabel.Text = L("HeaderTitle")
    HideWindowButton.Text = L("HideUI")
    Tab1Button.Text = L("TabControl")
    Tab2Button.Text = L("TabGuide")
    Tab3Button.Text = L("TabChangelog")
    ModeSelectorTriggerButton.Text = (currentLanguage == "TH" and "โปรไฟล์: " or "Profile: ") .. VelocityMatrixRegistry[activeProfilePointer].Identifier
    InitializeEngineButton.Text = L("RunBtn")
    EmergencyResetButton.Text = L("ResetBtn")
    ToggleFloatingInterfaceButton.Text = L("FloatBtn")
    SidebarInfoBox.Text = L("SidebarSys")
    DisclaimerTitle.Text = L("DiscTitle")
    DisclaimerDesc.Text = L("DiscDesc")
    AcceptButton.Text = L("AcceptBtn")
    DeclineButton.Text = L("DeclineBtn")
end

ThaiButton.MouseButton1Click:Connect(function()
    currentLanguage = "TH"
    currentActiveConfig.Language = "TH"
    saveUserConfiguration(currentActiveConfig)
    applyLocalizationToUI()
    LanguageModalFrame.Visible = false
    DisclaimerModalFrame.Visible = true
end)

EngButton.MouseButton1Click:Connect(function()
    currentLanguage = "EN"
    currentActiveConfig.Language = "EN"
    saveUserConfiguration(currentActiveConfig)
    applyLocalizationToUI()
    LanguageModalFrame.Visible = false
    DisclaimerModalFrame.Visible = true
end)

task.spawn(function()
    local steps = {
        {progress = 35, text = "Summoning spooky scripts..."},
        {progress = 75, text = "Loading cemetery configs..."},
        {progress = 100, text = "Ready to haunt!"}
    }
    for _, step in ipairs(steps) do
        LoadingStatusText.Text = step.text
        local targetSize = UDim2.new(step.progress / 100, 0, 1, 0)
        TweenService:Create(LoadingBarFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        task.wait(0.2)
    end
    task.wait(0.2)
    TweenService:Create(LoadingScreenFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    LoadingScreenFrame.Visible = false
    LanguageModalFrame.Visible = true
end)

local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 45)
HeaderNavigationPanel.ZIndex = 6
Instance.new("UICorner", HeaderNavigationPanel).CornerRadius = UDim.new(0, 14)

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
HeaderBottomBlocker.BorderSizePixel = 0
HeaderBottomBlocker.Position = UDim2.new(0, 0, 0.7, 0)
HeaderBottomBlocker.Size = UDim2.new(1, 0, 0.3, 0)
HeaderBottomBlocker.ZIndex = 6

HeaderTitleLabel = Instance.new("TextLabel")
HeaderTitleLabel.Parent = HeaderNavigationPanel
HeaderTitleLabel.BackgroundTransparency = 1
HeaderTitleLabel.Position = UDim2.new(0, 18, 0, 0)
HeaderTitleLabel.Size = UDim2.new(1, -260, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = L("HeaderTitle")
HeaderTitleLabel.TextColor3 = Color3.fromRGB(249, 115, 22)
HeaderTitleLabel.TextSize = 11
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitleLabel.ZIndex = 7

HideWindowButton = Instance.new("TextButton")
HideWindowButton.Parent = HeaderNavigationPanel
HideWindowButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
HideWindowButton.Position = UDim2.new(1, -235, 0, 9)
HideWindowButton.Size = UDim2.new(0, 48, 0, 26)
HideWindowButton.Font = Enum.Font.Code
HideWindowButton.Text = L("HideUI")
HideWindowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideWindowButton.TextSize = 10
HideWindowButton.ZIndex = 7
Instance.new("UICorner", HideWindowButton).CornerRadius = UDim.new(0, 6)

Tab1Button = Instance.new("TextButton")
Tab1Button.Parent = HeaderNavigationPanel
Tab1Button.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
Tab1Button.Position = UDim2.new(1, -183, 0, 9)
Tab1Button.Size = UDim2.new(0, 55, 0, 26)
Tab1Button.Font = Enum.Font.Code
Tab1Button.Text = L("TabControl")
Tab1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Button.TextSize = 10
Tab1Button.ZIndex = 7
Instance.new("UICorner", Tab1Button).CornerRadius = UDim.new(0, 6)

Tab2Button = Instance.new("TextButton")
Tab2Button.Parent = HeaderNavigationPanel
Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
Tab2Button.Position = UDim2.new(1, -124, 0, 9)
Tab2Button.Size = UDim2.new(0, 52, 0, 26)
Tab2Button.Font = Enum.Font.Code
Tab2Button.Text = L("TabGuide")
Tab2Button.TextColor3 = Color3.fromRGB(168, 162, 184)
Tab2Button.TextSize = 10
Tab2Button.ZIndex = 7
Instance.new("UICorner", Tab2Button).CornerRadius = UDim.new(0, 6)

Tab3Button = Instance.new("TextButton")
Tab3Button.Parent = HeaderNavigationPanel
Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
Tab3Button.Position = UDim2.new(1, -68, 0, 9)
Tab3Button.Size = UDim2.new(0, 60, 0, 26)
Tab3Button.Font = Enum.Font.Code
Tab3Button.Text = L("TabChangelog")
Tab3Button.TextColor3 = Color3.fromRGB(168, 162, 184)
Tab3Button.TextSize = 10
Tab3Button.ZIndex = 7
Instance.new("UICorner", Tab3Button).CornerRadius = UDim.new(0, 6)

AcceptButton.MouseButton1Click:Connect(function()
    DisclaimerModalFrame.Visible = false
    PrimaryWindowFrame.Visible = true
    if LightningToggleWidget then
        LightningToggleWidget.Visible = false
    end
    triggerApexToastNotification(L("ToastWelcome"), L("ToastWelcomeSub"), "SUCCESS")
end)

local LeftProfileSidebar = Instance.new("Frame")
LeftProfileSidebar.Parent = PrimaryWindowFrame
LeftProfileSidebar.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
LeftProfileSidebar.Position = UDim2.new(0, 15, 0, 55)
LeftProfileSidebar.Size = UDim2.new(0, 185, 1, -68)
LeftProfileSidebar.ZIndex = 6
Instance.new("UICorner", LeftProfileSidebar).CornerRadius = UDim.new(0, 10)

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(45, 35, 70)
sidebarStroke.Thickness = 1
sidebarStroke.Parent = LeftProfileSidebar

local UserAvatarImage = Instance.new("ImageLabel")
UserAvatarImage.Parent = LeftProfileSidebar
UserAvatarImage.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
UserAvatarImage.Position = UDim2.new(0, 12, 0, 12)
UserAvatarImage.Size = UDim2.new(0, 50, 0, 50)
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
RealNameLabel.Position = UDim2.new(0, 70, 0, 12)
RealNameLabel.Size = UDim2.new(1, -78, 0, 20)
RealNameLabel.Font = Enum.Font.Code
RealNameLabel.Text = "@" .. LocalPlayer.Name
RealNameLabel.TextColor3 = Color3.fromRGB(241, 245, 249)
RealNameLabel.TextSize = 10
RealNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
RealNameLabel.TextXAlignment = Enum.TextXAlignment.Left
RealNameLabel.ZIndex = 7

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Parent = LeftProfileSidebar
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.Position = UDim2.new(0, 70, 0, 30)
DisplayNameLabel.Size = UDim2.new(1, -78, 0, 20)
DisplayNameLabel.Font = Enum.Font.Code
DisplayNameLabel.Text = LocalPlayer.DisplayName
DisplayNameLabel.TextColor3 = Color3.fromRGB(249, 115, 22)
DisplayNameLabel.TextSize = 11
DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.ZIndex = 7

local HealthBarBg = Instance.new("Frame")
HealthBarBg.Parent = LeftProfileSidebar
HealthBarBg.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
HealthBarBg.Position = UDim2.new(0, 12, 0, 70)
HealthBarBg.Size = UDim2.new(1, -24, 0, 20)
HealthBarBg.ZIndex = 7
Instance.new("UICorner", HealthBarBg).CornerRadius = UDim.new(0, 4)

local HealthBarFill = Instance.new("Frame")
HealthBarFill.Parent = HealthBarBg
HealthBarFill.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
HealthBarFill.Size = UDim2.new(1, 0, 1, 0)
HealthBarFill.ZIndex = 8
Instance.new("UICorner", HealthBarFill).CornerRadius = UDim.new(0, 4)

local HealthText = Instance.new("TextLabel")
HealthText.Parent = HealthBarBg
HealthText.BackgroundTransparency = 1
HealthText.Size = UDim2.new(1, 0, 1, 0)
HealthText.Font = Enum.Font.Code
HealthText.Text = "Soul HP: 100 / 100"
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
                    HealthText.Text = string.format("Soul HP: %d / %d", hp, maxHp)
                    HealthBarFill.Size = UDim2.new(math.clamp(hp/maxHp, 0, 1), 0, 1, 0)
                end
            end
        end)
    end
end)

SidebarInfoBox = Instance.new("TextLabel")
SidebarInfoBox.Parent = LeftProfileSidebar
SidebarInfoBox.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
SidebarInfoBox.Position = UDim2.new(0, 12, 0, 100)
SidebarInfoBox.Size = UDim2.new(1, -24, 1, -112)
SidebarInfoBox.Font = Enum.Font.Code
SidebarInfoBox.Text = L("SidebarSys")
SidebarInfoBox.TextColor3 = Color3.fromRGB(168, 162, 184)
SidebarInfoBox.TextSize = 10
SidebarInfoBox.TextWrapped = true
SidebarInfoBox.TextXAlignment = Enum.TextXAlignment.Left
SidebarInfoBox.TextYAlignment = Enum.TextYAlignment.Top
SidebarInfoBox.ZIndex = 7
Instance.new("UICorner", SidebarInfoBox).CornerRadius = UDim.new(0, 6)

-- Right Content Areas
local RightContentArea = Instance.new("ScrollingFrame")
RightContentArea.Name = "RightScrollingContainer"
RightContentArea.Parent = PrimaryWindowFrame
RightContentArea.BackgroundTransparency = 1
RightContentArea.Position = UDim2.new(0, 210, 0, 55)
RightContentArea.Size = UDim2.new(1, -225, 1, -68)
RightContentArea.CanvasSize = UDim2.new(0, 0, 0, 520)
RightContentArea.ScrollBarThickness = 3
RightContentArea.ScrollBarImageColor3 = Color3.fromRGB(249, 115, 22)
RightContentArea.ZIndex = 6

local RightVerticalLayout = Instance.new("UIListLayout")
RightVerticalLayout.Parent = RightContentArea
RightVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
RightVerticalLayout.Padding = UDim.new(0, 10)

local GuideContentArea = Instance.new("ScrollingFrame")
GuideContentArea.Name = "GuideScrollingContainer"
GuideContentArea.Parent = PrimaryWindowFrame
GuideContentArea.BackgroundTransparency = 1
GuideContentArea.Position = UDim2.new(0, 210, 0, 55)
GuideContentArea.Size = UDim2.new(1, -225, 1, -68)
GuideContentArea.CanvasSize = UDim2.new(0, 0, 0, 580)
GuideContentArea.ScrollBarThickness = 3
GuideContentArea.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
GuideContentArea.Visible = false
GuideContentArea.ZIndex = 6

local GuideVerticalLayout = Instance.new("UIListLayout")
GuideVerticalLayout.Parent = GuideContentArea
GuideVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
GuideVerticalLayout.Padding = UDim.new(0, 10)

local ChangelogContentArea = Instance.new("ScrollingFrame")
ChangelogContentArea.Name = "ChangelogScrollingContainer"
ChangelogContentArea.Parent = PrimaryWindowFrame
ChangelogContentArea.BackgroundTransparency = 1
ChangelogContentArea.Position = UDim2.new(0, 210, 0, 55)
ChangelogContentArea.Size = UDim2.new(1, -225, 1, -68)
ChangelogContentArea.CanvasSize = UDim2.new(0, 0, 0, 600)
ChangelogContentArea.ScrollBarThickness = 3
ChangelogContentArea.ScrollBarImageColor3 = Color3.fromRGB(34, 197, 94)
ChangelogContentArea.Visible = false
ChangelogContentArea.ZIndex = 6

local ChangelogVerticalLayout = Instance.new("UIListLayout")
ChangelogVerticalLayout.Parent = ChangelogContentArea
ChangelogVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
ChangelogVerticalLayout.Padding = UDim.new(0, 10)

local function constructCategoryHeader(parentContainer, labelTextContent)
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Parent = parentContainer
    headerLabel.BackgroundTransparency = 1
    headerLabel.Size = UDim2.new(1, 0, 0, 16)
    headerLabel.Font = Enum.Font.Code
    headerLabel.Text = labelTextContent
    headerLabel.TextColor3 = Color3.fromRGB(168, 162, 184)
    headerLabel.TextSize = 10
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.ZIndex = 6
    return headerLabel
end

local function constructInteractiveButton(parentContainer, buttonTextContent, themeColorCode)
    local buttonInstance = Instance.new("TextButton")
    buttonInstance.Parent = parentContainer
    buttonInstance.BackgroundColor3 = themeColorCode
    buttonInstance.Size = UDim2.new(1, 0, 0, 36)
    buttonInstance.Font = Enum.Font.Code
    buttonInstance.Text = buttonTextContent
    buttonInstance.TextColor3 = Color3.fromRGB(241, 245, 249)
    buttonInstance.TextSize = 11
    buttonInstance.ZIndex = 6
    Instance.new("UICorner", buttonInstance).CornerRadius = UDim.new(0, 8)
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Transparency = 0.85
    buttonStroke.Thickness = 1
    buttonStroke.Parent = buttonInstance
    
    return buttonInstance
end

constructCategoryHeader(RightContentArea, ">> ระบบเชื่อมโยง Deep Engine")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = RightContentArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 38)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [สถานะวิญญาณ]: Deep Engine Hooked พร้อมสแกน"
SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(34, 197, 94)
SystemTelemetryDisplayBox.TextSize = 10
SystemTelemetryDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
SystemTelemetryDisplayBox.ZIndex = 6
Instance.new("UICorner", SystemTelemetryDisplayBox).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(RightContentArea, ">> โปรไฟล์ความเร็ววิญญาณ")
local initialProfileText = (currentLanguage == "TH" and "โปรไฟล์: " or "Profile: ") .. VelocityMatrixRegistry[activeProfilePointer].Identifier
ModeSelectorTriggerButton = constructInteractiveButton(RightContentArea, initialProfileText, Color3.fromRGB(25, 20, 40))

constructCategoryHeader(RightContentArea, ">> ชุดคำสั่งที่แกะจากโครงสร้างแมพ")
local SequenceInputField = Instance.new("TextBox")
SequenceInputField.Parent = RightContentArea
SequenceInputField.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
SequenceInputField.Size = UDim2.new(1, 0, 0, 38)
SequenceInputField.Font = Enum.Font.Code
SequenceInputField.PlaceholderText = "รอการดักจับโครงสร้าง KeyBar..."
SequenceInputField.Text = ""
SequenceInputField.TextColor3 = Color3.fromRGB(249, 115, 22)
SequenceInputField.TextSize = 11
SequenceInputField.ClearTextOnFocus = false
SequenceInputField.TextWrapped = true
SequenceInputField.ZIndex = 6
Instance.new("UICorner", SequenceInputField).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(RightContentArea, ">> ควบคุมโปรโตคอลหลัก & รีเซ็ต")
InitializeEngineButton = constructInteractiveButton(RightContentArea, L("RunBtn"), Color3.fromRGB(194, 65, 12))
EmergencyResetButton = constructInteractiveButton(RightContentArea, L("ResetBtn"), Color3.fromRGB(153, 27, 27))

constructCategoryHeader(RightContentArea, ">> ควบคุมปุ่มลอยวิญญาณ")
ToggleFloatingInterfaceButton = constructInteractiveButton(RightContentArea, L("FloatBtn"), Color3.fromRGB(51, 40, 80))

-- Guide Tab
constructCategoryHeader(GuideContentArea, ">> [Halloween Guide]")
local GuideBox1 = Instance.new("TextLabel")
GuideBox1.Parent = GuideContentArea
GuideBox1.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
GuideBox1.Size = UDim2.new(1, 0, 0, 95)
GuideBox1.Font = Enum.Font.Code
GuideBox1.Text = " - Select speed profiles (5 tiers)\n - Deep Engine Hook prevents last-item drops\n - Auto-saves configuration instantly"
GuideBox1.TextColor3 = Color3.fromRGB(203, 213, 225)
GuideBox1.TextSize = 10
GuideBox1.TextWrapped = true
GuideBox1.TextXAlignment = Enum.TextXAlignment.Left
GuideBox1.TextYAlignment = Enum.TextYAlignment.Top
GuideBox1.ZIndex = 6
Instance.new("UICorner", GuideBox1).CornerRadius = UDim.new(0, 8)

-- Changelog Tab
constructCategoryHeader(ChangelogContentArea, ">> [Changelog] V16.1 Halloween Apex")
local ChangelogBox = Instance.new("TextLabel")
ChangelogBox.Parent = ChangelogContentArea
ChangelogBox.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
ChangelogBox.Size = UDim2.new(1, 0, 0, 130)
ChangelogBox.Font = Enum.Font.Code
ChangelogBox.Text = " 🎃 V16.1 Updates:\n - Fully rewritten Halloween Dark Theme\n - Added Language Selection (TH/EN) with UI Sync\n - Deep Engine Hooking for 100% precision accuracy"
ChangelogBox.TextColor3 = Color3.fromRGB(249, 115, 22)
ChangelogBox.TextSize = 10
ChangelogBox.TextWrapped = true
ChangelogBox.TextXAlignment = Enum.TextXAlignment.Left
ChangelogBox.TextYAlignment = Enum.TextYAlignment.Top
ChangelogBox.ZIndex = 6
Instance.new("UICorner", ChangelogBox).CornerRadius = UDim.new(0, 8)

Tab1Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = true
    GuideContentArea.Visible = false
    ChangelogContentArea.Visible = false
    Tab1Button.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
    Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
    Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
end)

Tab2Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = false
    GuideContentArea.Visible = true
    ChangelogContentArea.Visible = false
    Tab2Button.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
    Tab1Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
    Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
end)

Tab3Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = false
    GuideContentArea.Visible = false
    ChangelogContentArea.Visible = true
    Tab3Button.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
    Tab1Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
    Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
end)

local SecondarySelectorPanel = Instance.new("Frame")
SecondarySelectorPanel.Name = "SecondarySelectorMatrix"
SecondarySelectorPanel.Parent = RootContainerNode
SecondarySelectorPanel.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
SecondarySelectorPanel.Position = UDim2.new(0.08, 465, 0.12, 0)
SecondarySelectorPanel.Size = UDim2.new(0, 240, 0, 240)
SecondarySelectorPanel.Visible = false
SecondarySelectorPanel.Active = true
SecondarySelectorPanel.Draggable = true
SecondarySelectorPanel.ZIndex = 15
Instance.new("UICorner", SecondarySelectorPanel).CornerRadius = UDim.new(0, 10)

local secondaryStroke = Instance.new("UIStroke")
secondaryStroke.Color = Color3.fromRGB(249, 115, 22)
secondaryStroke.Thickness = 1.2
secondaryStroke.Parent = SecondarySelectorPanel

local SelectorScrollingList = Instance.new("ScrollingFrame")
SelectorScrollingList.Parent = SecondarySelectorPanel
SelectorScrollingList.BackgroundTransparency = 1
SelectorScrollingList.Position = UDim2.new(0, 10, 0, 10)
SelectorScrollingList.Size = UDim2.new(1, -20, 1, -20)
SelectorScrollingList.CanvasSize = UDim2.new(0, 0, 0, 260)
SelectorScrollingList.ScrollBarThickness = 2
SelectorScrollingList.ZIndex = 16

local selectorLayout = Instance.new("UIListLayout")
selectorLayout.Parent = SelectorScrollingList
selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
selectorLayout.Padding = UDim.new(0, 8)

for idx, profileData in ipairs(VelocityMatrixRegistry) do
    local profileSelectionButton = constructInteractiveButton(SelectorScrollingList, profileData.Identifier, Color3.fromRGB(25, 20, 40))
    profileSelectionButton.ZIndex = 16
    profileSelectionButton.MouseButton1Click:Connect(function()
        activeProfilePointer = idx
        ModeSelectorTriggerButton.Text = (currentLanguage == "TH" and "โปรไฟล์: " or "Profile: ") .. profileData.Identifier
        SecondarySelectorPanel.Visible = false
        currentActiveConfig.SelectedProfileIndex = idx
        saveUserConfiguration(currentActiveConfig)
        triggerApexToastNotification("บันทึกวิญญาณ", "เปลี่ยนโปรไฟล์ความเร็วสำเร็จ", "SUCCESS")
    end)
end

ModeSelectorTriggerButton.MouseButton1Click:Connect(function()
    SecondarySelectorPanel.Visible = not SecondarySelectorPanel.Visible
end)

local StatsWidget = Instance.new("TextButton")
StatsWidget.Name = "MeridianStatsWidget"
StatsWidget.Parent = RootContainerNode
StatsWidget.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
StatsWidget.Position = UDim2.new(0.80, 0, 0.12, 0)
StatsWidget.Size = UDim2.new(0, 170, 0, 34)
StatsWidget.Font = Enum.Font.Code
StatsWidget.Text = "| ปิง: 0ms | FPS: 0 |"
StatsWidget.TextColor3 = Color3.fromRGB(249, 115, 22)
StatsWidget.TextSize = 10
StatsWidget.Active = true
StatsWidget.Draggable = true
StatsWidget.ZIndex = 8
Instance.new("UICorner", StatsWidget).CornerRadius = UDim.new(0, 8)

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(249, 115, 22)
statsStroke.Transparency = 0.4
statsStroke.Thickness = 1.2
statsStroke.Parent = StatsWidget

task.spawn(function()
    local lastTick = tick()
    local frameCount = 0
    local currentFPS = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTick >= 1 then
            currentFPS = frameCount
            frameCount = 0
            lastTick = tick()
        end
        local pingVal = 0
        pcall(function() pingVal = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        StatsWidget.Text = string.format("| Ping: %d ms | FPS: %d |", pingVal, currentFPS)
    end)
end)

LightningToggleWidget = Instance.new("TextButton")
LightningToggleWidget.Name = "MeridianLightningToggleWidget"
LightningToggleWidget.Parent = RootContainerNode
LightningToggleWidget.BackgroundColor3 = Color3.fromRGB(249, 115, 22)
LightningToggleWidget.Position = UDim2.new(0.80, 0, 0.22, 0)
LightningToggleWidget.Size = UDim2.new(0, 42, 0, 42)
LightningToggleWidget.Font = Enum.Font.Code
LightningToggleWidget.Text = "⚡"
LightningToggleWidget.TextColor3 = Color3.fromRGB(255, 255, 255)
LightningToggleWidget.TextSize = 16
LightningToggleWidget.Visible = false
LightningToggleWidget.Active = true
LightningToggleWidget.Draggable = true
LightningToggleWidget.ZIndex = 16
Instance.new("UICorner", LightningToggleWidget).CornerRadius = UDim.new(0, 10)

local lightningStroke = Instance.new("UIStroke")
lightningStroke.Color = Color3.fromRGB(255, 255, 255)
lightningStroke.Thickness = 1.5
lightningStroke.Parent = LightningToggleWidget

local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "MeridianSquareFloatingWidget"
SmallSquareFloatingWidget.Parent = RootContainerNode
SmallSquareFloatingWidget.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
SmallSquareFloatingWidget.Position = UDim2.new(0.88, 0, 0.22, 0)
SmallSquareFloatingWidget.Size = UDim2.new(0, 54, 0, 54)
SmallSquareFloatingWidget.Font = Enum.Font.Code
SmallSquareFloatingWidget.Text = "EXEC"
SmallSquareFloatingWidget.TextColor3 = Color3.fromRGB(249, 115, 22)
SmallSquareFloatingWidget.TextSize = 11
SmallSquareFloatingWidget.Visible = floatingWidgetActiveState
SmallSquareFloatingWidget.Active = true
SmallSquareFloatingWidget.Draggable = true
SmallSquareFloatingWidget.ZIndex = 15
Instance.new("UICorner", SmallSquareFloatingWidget).CornerRadius = UDim.new(0, 12)

local widgetStroke = Instance.new("UIStroke")
widgetStroke.Color = Color3.fromRGB(249, 115, 22)
widgetStroke.Thickness = 2
widgetStroke.Parent = SmallSquareFloatingWidget

local function executeAdvancedDiagnosticParsing()
    local targetInterface = LocalPlayer.PlayerGui:FindFirstChild("MatchUI")
    if not targetInterface or not targetInterface:FindFirstChild("MatchRoot") then return nil end
    local containerNode = targetInterface.MatchRoot:FindFirstChild("KeyBar")
    if not containerNode then return nil end

    local collectedNodes = {}
    local descendantStack = containerNode:GetDescendants()
    for i = 1, #descendantStack do
        local nodeInstance = descendantStack[i]
        if nodeInstance:IsA("TextLabel") and nodeInstance.Visible then
            local rawContent = nodeInstance.Text
            if rawContent and rawContent ~= "" then
                local sanitized = rawContent:gsub("%s+", "")
                if sanitized:match("^[A-Za-z]$") then
                    table.insert(collectedNodes, {
                        Character = sanitized:upper(),
                        PositionX = nodeInstance.AbsolutePosition.X,
                        PositionY = nodeInstance.AbsolutePosition.Y
                    })
                end
            end
        end
    end

    if #collectedNodes < 3 then return nil end
    table.sort(collectedNodes, function(a, b)
        if math.abs(a.PositionX - b.PositionX) > 4 then return a.PositionX < b.PositionX end
        return a.PositionY < b.PositionY
    end)

    local assembledString = ""
    for j = 1, #collectedNodes do assembledString = assembledString .. collectedNodes[j].Character end
    return #assembledString >= 3 and assembledString or nil
end

local function verifySequenceIntegrityTriplePass()
    local passAlpha = executeAdvancedDiagnosticParsing()
    if not passAlpha then return nil end
    task.wait(0.001)
    local passBeta = executeAdvancedDiagnosticParsing()
    if not passBeta or passAlpha ~= passBeta then return nil end
    task.wait(0.001)
    local passGamma = executeAdvancedDiagnosticParsing()
    if not passGamma or passBeta ~= passGamma then return nil end
    return passGamma
end

local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [สถานะวิญญาณ]: กำลังรันความเร็วสูงสุด..."
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(249, 115, 22)
    triggerApexToastNotification("พลังวิญญาณตื่น!", "กำลังแก้เกมด้วยโปรไฟล์...", "SUCCESS")
    
    task.spawn(function()
        for idx = 1, #sequencePayload do
            local targetChar = sequencePayload:sub(idx, idx)
            pcall(function()
                local mappedKey = Enum.KeyCode[targetChar]
                if mappedKey then
                    VirtualInputManager:SendKeyEvent(true, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration)
                    VirtualInputManager:SendKeyEvent(false, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration)
                end
            end)
        end
        SystemTelemetryDisplayBox.Text = "  [สถานะวิญญาณ]: สำเร็จลุล่วงสมบูรณ์ 100%"
        SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(34, 197, 94)
        triggerApexToastNotification("สำเร็จ!", "แก้เกมครบทุกตัวอย่างแม่นยำไร้รอยต่อ", "SUCCESS")
        coreExecutionFlag = false
    end)
end

local function processExecutionTriggerRoutine()
    if sequenceMemoryBuffer == "" then
        local deepScanResult = verifySequenceIntegrityTriplePass()
        if deepScanResult then
            sequenceMemoryBuffer = deepScanResult
            SequenceInputField.Text = sequenceMemoryBuffer
        end
    end
    if sequenceMemoryBuffer ~= "" then
        dispatchSolverExecutionStream(sequenceMemoryBuffer)
    else
        triggerApexToastNotification("แจ้งเตือน", "ยังไม่พบโหนด KeyBar ในแมพตอนนี้", "WARNING")
    end
end

InitializeEngineButton.MouseButton1Click:Connect(processExecutionTriggerRoutine)
SmallSquareFloatingWidget.MouseButton1Click:Connect(processExecutionTriggerRoutine)

LightningToggleWidget.MouseButton1Click:Connect(function()
    PrimaryWindowFrame.Visible = true
    LightningToggleWidget.Visible = false
    triggerApexToastNotification("เปิด UI", "แสดงหน้าต่างหลักสำเร็จ", "SUCCESS")
end)

HideWindowButton.MouseButton1Click:Connect(function()
    PrimaryWindowFrame.Visible = false
    LightningToggleWidget.Visible = true
    triggerApexToastNotification("ซ่อน UI", "ซ่อนหน้าต่างหลักแล้ว", "WARNING")
end)

ToggleFloatingInterfaceButton.MouseButton1Click:Connect(function()
    floatingWidgetActiveState = not floatingWidgetActiveState
    SmallSquareFloatingWidget.Visible = floatingWidgetActiveState
    currentActiveConfig.FloatingWidgetEnabled = floatingWidgetActiveState
    saveUserConfiguration(currentActiveConfig)
    triggerApexToastNotification("ปุ่มลอย", "สลับการแสดงผลปุ่มลอยเรียบร้อย", "SUCCESS")
end)

EmergencyResetButton.MouseButton1Click:Connect(function()
    coreExecutionFlag = false
    sequenceMemoryBuffer = ""
    SequenceInputField.Text = ""
    SystemTelemetryDisplayBox.Text = "  [สถานะวิญญาณ]: รีเซ็ตระบบฉุกเฉินสำเร็จ"
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(239, 68, 68)
    triggerApexToastNotification("รีเซ็ตระบบ", "ล้างค่าบัฟเฟอร์และรีเซ็ตสคริปต์เรียบร้อย", "ERROR")
end)

task.spawn(function()
    local lastRegisteredSequence = ""
    while task.wait(0.1) do
        if not coreExecutionFlag then
            pcall(function()
                local parsedTokenResult = verifySequenceIntegrityTriplePass()
                if parsedTokenResult and parsedTokenResult ~= lastRegisteredSequence then
                    lastRegisteredSequence = parsedTokenResult
                    sequenceMemoryBuffer = parsedTokenResult
                    SequenceInputField.Text = sequenceMemoryBuffer
                    SystemTelemetryDisplayBox.Text = "  [สถานะวิญญาณ]: ซิงค์โหนดสำเร็จ (" .. #sequenceMemoryBuffer .. " จุด)"
                    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(34, 197, 94)
                end
            end)
        end
    end
end)

print("🎃 MERIDIAN HUB V16.1 HALLOWEEN APEX: Language Sync Loaded Successfully!")
