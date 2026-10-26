----------------------------------------------------------------------------------------------------
-- 🌌 MERIDIAN HUB // QUANTUM APEX MASTERPIECE KERNEL (V15.3.3 ULTRA-PRECISION FIXED)
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local CONFIG_FILE_NAME = "MeridianHub_V15_Config.json"

----------------------------------------------------------------------------------------------------
-- [1] ระบบจัดการ Config อัตโนมัติ (Local Config Auto-Save & Load System)
----------------------------------------------------------------------------------------------------
local defaultUserConfig = {
    SelectedProfileIndex = 1,
    FloatingWidgetEnabled = true,
    AutoExecuteActive = true
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

-- Safe Structural Memory Purge
if CoreGui:FindFirstChild("MeridianApexStructuralContainer") then
    CoreGui.MeridianApexStructuralContainer:Destroy()
end

----------------------------------------------------------------------------------------------------
-- [2] ระบบควบคุมโปรไฟล์ความเร็วโครงสร้างหลัก (Pure Velocity Matrix - Optimized)
----------------------------------------------------------------------------------------------------
local VelocityMatrixRegistry = {
    [1] = {Identifier = "ระดับ 1 : เนียนตา เล่นกับคน (Human Stealth)", DelayDuration = 0.090, PrecisionRate = "100.0%", KernelRisk = "ปลอดภัยสูงสุด"},
    [2] = {Identifier = "ระดับ 2 : สมดุล ไวทันใจ (Balanced Fast)", DelayDuration = 0.045, PrecisionRate = "100.0%", KernelRisk = "ต่ำมาก"},
    [3] = {Identifier = "ระดับ 3 : กึ่งครึ่งวิ (Sub-Half Second)", DelayDuration = 0.022, PrecisionRate = "100.0%", KernelRisk = "ปานกลาง"},
    [4] = {Identifier = "ระดับ 4 : ควอนตัมสตรีม (Quantum Stream)", DelayDuration = 0.010, PrecisionRate = "100.0%", KernelRisk = "สมดุลสูง"},
    [5] = {Identifier = "ระดับ 5 : ขีดสุดความเร็วแสง (Singularity Apex)", DelayDuration = 0.003, PrecisionRate = "100.0%", KernelRisk = "ระมัดระวัง"}
}

local activeProfilePointer = math.clamp(currentActiveConfig.SelectedProfileIndex, 1, #VelocityMatrixRegistry)
local sequenceMemoryBuffer = ""
local coreExecutionFlag = false
local floatingWidgetActiveState = currentActiveConfig.FloatingWidgetEnabled
local isBackgroundScannerActive = true

----------------------------------------------------------------------------------------------------
-- [3] การสร้างรากฐาน GUI ระดับโครงสร้าง
----------------------------------------------------------------------------------------------------
local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "MeridianApexStructuralContainer"
RootContainerNode.Parent = CoreGui
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

----------------------------------------------------------------------------------------------------
-- [4] ระบบแจ้งเตือนสถานะมุมจอสุดล้ำ (Dynamic Toast Notification Engine)
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

local function triggerApexToastNotification(messageTitle, messageBody, notificationType)
    task.spawn(function()
        local accentColor = Color3.fromRGB(20, 184, 166)
        if notificationType == "SUCCESS" then accentColor = Color3.fromRGB(52, 211, 153)
        elseif notificationType == "WARNING" then accentColor = Color3.fromRGB(251, 191, 36)
        elseif notificationType == "ERROR" then accentColor = Color3.fromRGB(248, 113, 113) end

        local toastCard = Instance.new("Frame")
        toastCard.Parent = ToastNotificationHub
        toastCard.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
        toastCard.Size = UDim2.new(1, 0, 0, 55)
        toastCard.Position = UDim2.new(1, 50, 0, 0)
        toastCard.ZIndex = 51
        Instance.new("UICorner", toastCard).CornerRadius = UDim.new(0, 8)

        local toastStroke = Instance.new("UIStroke")
        toastStroke.Color = accentColor
        toastStroke.Thickness = 1.2
        toastStroke.Transparency = 0.2
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

----------------------------------------------------------------------------------------------------
-- [5] หน้าโหลดระบบก่อนเข้าใช้งาน
----------------------------------------------------------------------------------------------------
local LoadingScreenFrame = Instance.new("Frame")
LoadingScreenFrame.Name = "LoadingScreen"
LoadingScreenFrame.Parent = RootContainerNode
LoadingScreenFrame.BackgroundColor3 = Color3.fromRGB(8, 11, 16)
LoadingScreenFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingScreenFrame.ZIndex = 25

local LoadingCard = Instance.new("Frame")
LoadingCard.Parent = LoadingScreenFrame
LoadingCard.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
LoadingCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingCard.Size = UDim2.new(0, 380, 0, 200)
LoadingCard.ZIndex = 26
Instance.new("UICorner", LoadingCard).CornerRadius = UDim.new(0, 14)

local cardStroke = Instance.new("UIStroke")
cardStroke.Color = Color3.fromRGB(20, 184, 166)
cardStroke.Thickness = 1.5
cardStroke.Transparency = 0.3
cardStroke.Parent = LoadingCard

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingCard
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0, 20, 0, 25)
LoadingTitle.Size = UDim2.new(1, -40, 0, 30)
LoadingTitle.Font = Enum.Font.Code
LoadingTitle.Text = "MERIDIAN HUB // V15.3.3"
LoadingTitle.TextColor3 = Color3.fromRGB(45, 212, 191)
LoadingTitle.TextSize = 12
LoadingTitle.TextXAlignment = Enum.TextXAlignment.Left
LoadingTitle.ZIndex = 27

local LoadingStatusText = Instance.new("TextLabel")
LoadingStatusText.Parent = LoadingCard
LoadingStatusText.BackgroundTransparency = 1
LoadingStatusText.Position = UDim2.new(0, 20, 0, 65)
LoadingStatusText.Size = UDim2.new(1, -40, 0, 20)
LoadingStatusText.Font = Enum.Font.Code
LoadingStatusText.Text = "กำลังโหลดระบบ..."
LoadingStatusText.TextColor3 = Color3.fromRGB(148, 163, 184)
LoadingStatusText.TextSize = 11
LoadingStatusText.TextXAlignment = Enum.TextXAlignment.Left
LoadingStatusText.ZIndex = 27

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Parent = LoadingCard
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
LoadingBarBackground.Position = UDim2.new(0, 20, 0, 110)
LoadingBarBackground.Size = UDim2.new(1, -40, 0, 10)
LoadingBarBackground.ZIndex = 27
Instance.new("UICorner", LoadingBarBackground).CornerRadius = UDim.new(1, 0)

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Parent = LoadingBarBackground
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.ZIndex = 28
Instance.new("UICorner", LoadingBarFill).CornerRadius = UDim.new(1, 0)

local LoadingPercentage = Instance.new("TextLabel")
LoadingPercentage.Parent = LoadingCard
LoadingPercentage.BackgroundTransparency = 1
LoadingPercentage.Position = UDim2.new(0, 20, 0, 140)
LoadingPercentage.Size = UDim2.new(1, -40, 0, 20)
LoadingPercentage.Font = Enum.Font.Code
LoadingPercentage.Text = "0%"
LoadingPercentage.TextColor3 = Color3.fromRGB(52, 211, 153)
LoadingPercentage.TextSize = 11
LoadingPercentage.TextXAlignment = Enum.TextXAlignment.Right
LoadingPercentage.ZIndex = 27

----------------------------------------------------------------------------------------------------
-- [6] หน้าต่างยอมรับความเสี่ยง (Disclaimer Modal - เตือนเรื่องการโดนแบน)
----------------------------------------------------------------------------------------------------
local DisclaimerModalFrame = Instance.new("Frame")
DisclaimerModalFrame.Name = "DisclaimerModal"
DisclaimerModalFrame.Parent = RootContainerNode
DisclaimerModalFrame.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
DisclaimerModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
DisclaimerModalFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
DisclaimerModalFrame.Size = UDim2.new(0, 420, 0, 240)
DisclaimerModalFrame.Visible = false
DisclaimerModalFrame.ZIndex = 20
Instance.new("UICorner", DisclaimerModalFrame).CornerRadius = UDim.new(0, 14)

local disclaimerStroke = Instance.new("UIStroke")
disclaimerStroke.Color = Color3.fromRGB(248, 113, 113)
disclaimerStroke.Thickness = 1.8
disclaimerStroke.Parent = DisclaimerModalFrame

local DisclaimerTitle = Instance.new("TextLabel")
DisclaimerTitle.Parent = DisclaimerModalFrame
DisclaimerTitle.BackgroundTransparency = 1
DisclaimerTitle.Position = UDim2.new(0, 24, 0, 22)
DisclaimerTitle.Size = UDim2.new(1, -48, 0, 30)
DisclaimerTitle.Font = Enum.Font.Code
DisclaimerTitle.Text = "⚠️ แจ้งเตือนความเสี่ยงการโดนแบน (Ban Risk)"
DisclaimerTitle.TextColor3 = Color3.fromRGB(248, 113, 113)
DisclaimerTitle.TextSize = 13
DisclaimerTitle.TextXAlignment = Enum.TextXAlignment.Left
DisclaimerTitle.ZIndex = 21

local DisclaimerDesc = Instance.new("TextLabel")
DisclaimerDesc.Parent = DisclaimerModalFrame
DisclaimerDesc.BackgroundTransparency = 1
DisclaimerDesc.Position = UDim2.new(0, 24, 0, 65)
DisclaimerDesc.Size = UDim2.new(1, -48, 0, 90)
DisclaimerDesc.Font = Enum.Font.Code
DisclaimerDesc.Text = "การใช้สคริปต์ออโต้โซลเวอร์ (Auto-Solver) มีความเสี่ยงที่ระบบตรวจสอบของเกมอาจตรวจพบและส่งผลให้บัญชีของคุณถูกแบน ผู้พัฒนาจะไม่รับผิดชอบใดๆ ทั้งสิ้น หากคุณยอมรับความเสี่ยงนี้ได้ สามารถกดปุ่มยอมรับเพื่อเข้าใช้งาน"
DisclaimerDesc.TextColor3 = Color3.fromRGB(203, 213, 225)
DisclaimerDesc.TextSize = 11
DisclaimerDesc.TextWrapped = true
DisclaimerDesc.TextXAlignment = Enum.TextXAlignment.Left
DisclaimerDesc.ZIndex = 21

local AcceptButton = Instance.new("TextButton")
AcceptButton.Parent = DisclaimerModalFrame
AcceptButton.BackgroundColor3 = Color3.fromRGB(13, 148, 136)
AcceptButton.Position = UDim2.new(0, 24, 0, 175)
AcceptButton.Size = UDim2.new(0.47, -6, 0, 42)
AcceptButton.Font = Enum.Font.Code
AcceptButton.Text = "ยอมรับความเสี่ยง"
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
DeclineButton.Text = "ปฏิเสธ/ออกเกม"
DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeclineButton.TextSize = 11
DeclineButton.ZIndex = 21
Instance.new("UICorner", DeclineButton).CornerRadius = UDim.new(0, 8)

task.spawn(function()
    local steps = {
        {progress = 35, text = "กำลังคอมไพล์ระบบ..."},
        {progress = 75, text = "โหลด Config สำเร็จ..."},
        {progress = 100, text = "ระบบพร้อมใช้งาน!"}
    }
    
    for _, step in ipairs(steps) do
        LoadingStatusText.Text = step.text
        local targetSize = UDim2.new(step.progress / 100, 0, 1, 0)
        TweenService:Create(LoadingBarFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        LoadingPercentage.Text = step.progress .. "%"
        task.wait(0.2)
    end
    
    task.wait(0.1)
    TweenService:Create(LoadingScreenFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    LoadingScreenFrame.Visible = false
    DisclaimerModalFrame.Visible = true
end)

DeclineButton.MouseButton1Click:Connect(function()
    LocalPlayer:Kick("MERIDIAN APEX: คุณปฏิเสธเงื่อนไขความเสี่ยง ระบบจึงตัดการเชื่อมต่อ")
end)

----------------------------------------------------------------------------------------------------
-- [7] หน้าต่างหลักแดชบอร์ด (มี 3 แท็บ: ควบคุม, คู่มือ, ประวัติการอัพเดท)
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MeridianPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(8, 11, 16)
PrimaryWindowFrame.BackgroundTransparency = 0.02
PrimaryWindowFrame.Position = UDim2.new(0.08, 0, 0.12, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 560, 0, 480)
PrimaryWindowFrame.Visible = false
PrimaryWindowFrame.Active = true
PrimaryWindowFrame.Draggable = true
PrimaryWindowFrame.ZIndex = 5
Instance.new("UICorner", PrimaryWindowFrame).CornerRadius = UDim.new(0, 14)

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(20, 184, 166)
WindowBorderGlow.Transparency = 0.25
WindowBorderGlow.Thickness = 1.8
WindowBorderGlow.Parent = PrimaryWindowFrame

-- Forward declaration สำหรับปุ่มสายฟ้า
local LightningToggleWidget

AcceptButton.MouseButton1Click:Connect(function()
    DisclaimerModalFrame.Visible = false
    PrimaryWindowFrame.Visible = true
    if LightningToggleWidget then
        LightningToggleWidget.Visible = false
    end
    triggerApexToastNotification("ยินดีต้อนรับ!", "ระบบ Meridian V15.3.3 เริ่มต้นทำงานสำเร็จ", "SUCCESS")
end)

local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 45)
HeaderNavigationPanel.ZIndex = 6
Instance.new("UICorner", HeaderNavigationPanel).CornerRadius = UDim.new(0, 14)

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderBottomBlocker.BorderSizePixel = 0
HeaderBottomBlocker.Position = UDim2.new(0, 0, 0.7, 0)
HeaderBottomBlocker.Size = UDim2.new(1, 0, 0.3, 0)
HeaderBottomBlocker.ZIndex = 6

local HeaderTitleLabel = Instance.new("TextLabel")
HeaderTitleLabel.Parent = HeaderNavigationPanel
HeaderTitleLabel.BackgroundTransparency = 1
HeaderTitleLabel.Position = UDim2.new(0, 18, 0, 0)
HeaderTitleLabel.Size = UDim2.new(1, -260, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = "MERIDIAN HUB // V15.3.3"
HeaderTitleLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
HeaderTitleLabel.TextSize = 11
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitleLabel.ZIndex = 7

-- ปุ่มซ่อน UI จากในหัวข้อ
local HideWindowButton = Instance.new("TextButton")
HideWindowButton.Parent = HeaderNavigationPanel
HideWindowButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
HideWindowButton.Position = UDim2.new(1, -235, 0, 9)
HideWindowButton.Size = UDim2.new(0, 48, 0, 26)
HideWindowButton.Font = Enum.Font.Code
HideWindowButton.Text = "ซ่อน UI"
HideWindowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideWindowButton.TextSize = 10
HideWindowButton.ZIndex = 7
Instance.new("UICorner", HideWindowButton).CornerRadius = UDim.new(0, 6)

-- ปุ่มแท็บที่ 1: ควบคุม
local Tab1Button = Instance.new("TextButton")
Tab1Button.Parent = HeaderNavigationPanel
Tab1Button.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
Tab1Button.Position = UDim2.new(1, -183, 0, 9)
Tab1Button.Size = UDim2.new(0, 55, 0, 26)
Tab1Button.Font = Enum.Font.Code
Tab1Button.Text = "ควบคุม"
Tab1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1Button.TextSize = 10
Tab1Button.ZIndex = 7
Instance.new("UICorner", Tab1Button).CornerRadius = UDim.new(0, 6)

-- ปุ่มแท็บที่ 2: คู่มือ
local Tab2Button = Instance.new("TextButton")
Tab2Button.Parent = HeaderNavigationPanel
Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Tab2Button.Position = UDim2.new(1, -124, 0, 9)
Tab2Button.Size = UDim2.new(0, 52, 0, 26)
Tab2Button.Font = Enum.Font.Code
Tab2Button.Text = "คู่มือ"
Tab2Button.TextColor3 = Color3.fromRGB(148, 163, 184)
Tab2Button.TextSize = 10
Tab2Button.ZIndex = 7
Instance.new("UICorner", Tab2Button).CornerRadius = UDim.new(0, 6)

-- ปุ่มแท็บที่ 3: ประวัติการอัพเดท (Changelog)
local Tab3Button = Instance.new("TextButton")
Tab3Button.Parent = HeaderNavigationPanel
Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
Tab3Button.Position = UDim2.new(1, -68, 0, 9)
Tab3Button.Size = UDim2.new(0, 60, 0, 26)
Tab3Button.Font = Enum.Font.Code
Tab3Button.Text = "อัพเดท"
Tab3Button.TextColor3 = Color3.fromRGB(148, 163, 184)
Tab3Button.TextSize = 10
Tab3Button.ZIndex = 7
Instance.new("UICorner", Tab3Button).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------------------------------------------
-- [8] เลย์เอาต์ฝั่งซ้าย: ข้อมูลตัวละครจริง + สถานะระบบ Config
----------------------------------------------------------------------------------------------------
local LeftProfileSidebar = Instance.new("Frame")
LeftProfileSidebar.Parent = PrimaryWindowFrame
LeftProfileSidebar.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
LeftProfileSidebar.Position = UDim2.new(0, 15, 0, 55)
LeftProfileSidebar.Size = UDim2.new(0, 185, 1, -68)
LeftProfileSidebar.ZIndex = 6
Instance.new("UICorner", LeftProfileSidebar).CornerRadius = UDim.new(0, 10)

local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(30, 41, 59)
sidebarStroke.Thickness = 1
sidebarStroke.Parent = LeftProfileSidebar

local UserAvatarImage = Instance.new("ImageLabel")
UserAvatarImage.Parent = LeftProfileSidebar
UserAvatarImage.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
UserAvatarImage.Position = UDim2.new(0, 12, 0, 12)
UserAvatarImage.Size = UDim2.new(0, 50, 0, 50)
UserAvatarImage.Image = "rbxassetid://0"
UserAvatarImage.ZIndex = 7
Instance.new("UICorner", UserAvatarImage).CornerRadius = UDim.new(0, 8)

task.spawn(function()
    pcall(function()
        local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if isReady then
            UserAvatarImage.Image = content
        end
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
DisplayNameLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
DisplayNameLabel.TextSize = 11
DisplayNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.ZIndex = 7

local HealthBarBg = Instance.new("Frame")
HealthBarBg.Parent = LeftProfileSidebar
HealthBarBg.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
HealthBarBg.Position = UDim2.new(0, 12, 0, 70)
HealthBarBg.Size = UDim2.new(1, -24, 0, 20)
HealthBarBg.ZIndex = 7
Instance.new("UICorner", HealthBarBg).CornerRadius = UDim.new(0, 4)

local HealthBarFill = Instance.new("Frame")
HealthBarFill.Parent = HealthBarBg
HealthBarFill.BackgroundColor3 = Color3.fromRGB(52, 211, 153)
HealthBarFill.Size = UDim2.new(1, 0, 1, 0)
HealthBarFill.ZIndex = 8
Instance.new("UICorner", HealthBarFill).CornerRadius = UDim.new(0, 4)

local HealthText = Instance.new("TextLabel")
HealthText.Parent = HealthBarBg
HealthText.BackgroundTransparency = 1
HealthText.Size = UDim2.new(1, 0, 1, 0)
HealthText.Font = Enum.Font.Code
HealthText.Text = "Health: 100 / 100"
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
                    HealthText.Text = string.format("Health: %d / %d", hp, maxHp)
                    local ratio = math.clamp(hp / maxHp, 0, 1)
                    HealthBarFill.Size = UDim2.new(ratio, 0, 1, 0)
                end
            end
        end)
    end
end)

local SidebarInfoBox = Instance.new("TextLabel")
SidebarInfoBox.Parent = LeftProfileSidebar
SidebarInfoBox.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
SidebarInfoBox.Position = UDim2.new(0, 12, 0, 100)
SidebarInfoBox.Size = UDim2.new(1, -24, 1, -112)
SidebarInfoBox.Font = Enum.Font.Code
SidebarInfoBox.Text = "\n[ระบบ V15.3.3]\n- Config: Auto-Save\n- Precision Engine\n- Changelog: Added\n\n[สถานะ]\nพร้อมใช้งาน 100%"
SidebarInfoBox.TextColor3 = Color3.fromRGB(148, 163, 184)
SidebarInfoBox.TextSize = 10
SidebarInfoBox.TextWrapped = true
SidebarInfoBox.TextXAlignment = Enum.TextXAlignment.Left
SidebarInfoBox.TextYAlignment = Enum.TextYAlignment.Top
SidebarInfoBox.ZIndex = 7
Instance.new("UICorner", SidebarInfoBox).CornerRadius = UDim.new(0, 6)

----------------------------------------------------------------------------------------------------
-- [9] พื้นที่เนื้อหาหลักฝั่งขวา (แบ่งเป็น 3 แท็บ: ควบคุม, คู่มือ, อัพเดท)
----------------------------------------------------------------------------------------------------
local RightContentArea = Instance.new("ScrollingFrame")
RightContentArea.Name = "RightScrollingContainer"
RightContentArea.Parent = PrimaryWindowFrame
RightContentArea.BackgroundTransparency = 1
RightContentArea.Position = UDim2.new(0, 210, 0, 55)
RightContentArea.Size = UDim2.new(1, -225, 1, -68)
RightContentArea.CanvasSize = UDim2.new(0, 0, 0, 520)
RightContentArea.ScrollBarThickness = 3
RightContentArea.ScrollBarImageColor3 = Color3.fromRGB(20, 184, 166)
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
GuideContentArea.ScrollBarImageColor3 = Color3.fromRGB(45, 212, 191)
GuideContentArea.Visible = false
GuideContentArea.ZIndex = 6

local GuideVerticalLayout = Instance.new("UIListLayout")
GuideVerticalLayout.Parent = GuideContentArea
GuideVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
GuideVerticalLayout.Padding = UDim.new(0, 10)

-- หน้าที่ 3: ประวัติการอัพเดท (Changelog Panel)
local ChangelogContentArea = Instance.new("ScrollingFrame")
ChangelogContentArea.Name = "ChangelogScrollingContainer"
ChangelogContentArea.Parent = PrimaryWindowFrame
ChangelogContentArea.BackgroundTransparency = 1
ChangelogContentArea.Position = UDim2.new(0, 210, 0, 55)
ChangelogContentArea.Size = UDim2.new(1, -225, 1, -68)
ChangelogContentArea.CanvasSize = UDim2.new(0, 0, 0, 600)
ChangelogContentArea.ScrollBarThickness = 3
ChangelogContentArea.ScrollBarImageColor3 = Color3.fromRGB(52, 211, 153)
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
    headerLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
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

-- สร้างองค์ประกอบในแท็บควบคุม (Tab 1)
constructCategoryHeader(RightContentArea, ">> สถานะระบบ Config และความเสถียร")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = RightContentArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 38)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [สถานะ]: Config Auto-Save ทำงานสมบูรณ์"
SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
SystemTelemetryDisplayBox.TextSize = 10
SystemTelemetryDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
SystemTelemetryDisplayBox.ZIndex = 6
Instance.new("UICorner", SystemTelemetryDisplayBox).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(RightContentArea, ">> เลือกโปรไฟล์ความเร็วโครงสร้าง (จำค่าอัตโนมัติ)")
local initialProfileText = "โปรไฟล์: " .. VelocityMatrixRegistry[activeProfilePointer].Identifier
local ModeSelectorTriggerButton = constructInteractiveButton(RightContentArea, initialProfileText, Color3.fromRGB(17, 24, 39))

constructCategoryHeader(RightContentArea, ">> ชุดคำสั่งที่สแกนจากโครงสร้างแมพ")
local SequenceInputField = Instance.new("TextBox")
SequenceInputField.Parent = RightContentArea
SequenceInputField.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SequenceInputField.Size = UDim2.new(1, 0, 0, 38)
SequenceInputField.Font = Enum.Font.Code
SequenceInputField.PlaceholderText = "รอการเชื่อมโยงโครงสร้าง KeyBar..."
SequenceInputField.Text = ""
SequenceInputField.TextColor3 = Color3.fromRGB(56, 189, 248)
SequenceInputField.TextSize = 11
SequenceInputField.ClearTextOnFocus = false
SequenceInputField.TextWrapped = true
SequenceInputField.ZIndex = 6
Instance.new("UICorner", SequenceInputField).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(RightContentArea, ">> ควบคุมการทำงานหลัก & รีเซ็ต")
local InitializeEngineButton = constructInteractiveButton(RightContentArea, "▶ เริ่มต้นรันโปรโตคอลโครงสร้างอัตโนมัติ", Color3.fromRGB(13, 148, 136))
local EmergencyResetButton = constructInteractiveButton(RightContentArea, "♻ ล้างระบบ/รีเซ็ตสคริปต์ฉุกเฉิน (Fix Bug)", Color3.fromRGB(153, 27, 27))

constructCategoryHeader(RightContentArea, ">> ควบคุมปุ่มลอยบนหน้าจอ")
local ToggleFloatingInterfaceButton = constructInteractiveButton(RightContentArea, "สลับการแสดงผลปุ่มลอยสายรุ้ง (Auto Play)", Color3.fromRGB(51, 65, 85))

-- สร้างองค์ประกอบในแท็บคู่มือ (Tab 2)
constructCategoryHeader(GuideContentArea, ">> [คู่มือ] 1. ระบบเลือกโปรไฟล์และความเร็ว")
local GuideDescBox1 = Instance.new("TextLabel")
GuideDescBox1.Parent = GuideContentArea
GuideDescBox1.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
GuideDescBox1.Size = UDim2.new(1, 0, 0, 95)
GuideDescBox1.Font = Enum.Font.Code
GuideDescBox1.Text = " - เลือกระดับความเร็วที่ปุ่ม 'โปรไฟล์' (ปรับปรุงให้เสถียรขึ้นทุกระดับ)\n - ระดับ 1-5 ถูกจูนระบบส่งคีย์ป้องกันการตกหล่นช่วงท้าย\n - ระบบจะบันทึกค่าลง Config อัตโนมัติทันที"
GuideDescBox1.TextColor3 = Color3.fromRGB(203, 213, 225)
GuideDescBox1.TextSize = 10
GuideDescBox1.TextWrapped = true
GuideDescBox1.TextXAlignment = Enum.TextXAlignment.Left
GuideDescBox1.TextYAlignment = Enum.TextYAlignment.Top
GuideDescBox1.ZIndex = 6
Instance.new("UICorner", GuideDescBox1).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(GuideContentArea, ">> [คู่มือ] 2. ปุ่มสายฟ้า (ซ่อน/เปิด UI) & ปุ่มสายรุ้ง (ออโต้)")
local GuideDescBox2 = Instance.new("TextLabel")
GuideDescBox2.Parent = GuideContentArea
GuideDescBox2.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
GuideDescBox2.Size = UDim2.new(1, 0, 0, 115)
GuideDescBox2.Font = Enum.Font.Code
GuideDescBox2.Text = " - ปุ่มรูปสายฟ้า (⚡): จะโผล่ขึ้นมาก็ต่อเมื่อ 'ซ่อน UI หลัก' และจะหายไปทันทีเมื่อกดเปิด UI\n - ปุ่มสายรุ้ง (EXEC): คือปุ่มลัดสั่งรันเกมออโต้ (Auto-Solver) ด่วน"
GuideDescBox2.TextColor3 = Color3.fromRGB(248, 113, 113)
GuideDescBox2.TextSize = 10
GuideDescBox2.TextWrapped = true
GuideDescBox2.TextXAlignment = Enum.TextXAlignment.Left
GuideDescBox2.TextYAlignment = Enum.TextYAlignment.Top
GuideDescBox2.ZIndex = 6
Instance.new("UICorner", GuideDescBox2).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(GuideContentArea, ">> [คู่มือ] 3. การแก้ปัญหาเฉพาะหน้า (Fix Bug)")
local GuideDescBox3 = Instance.new("TextLabel")
GuideDescBox3.Parent = GuideContentArea
GuideDescBox3.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
GuideDescBox3.Size = UDim2.new(1, 0, 0, 95)
GuideDescBox3.Font = Enum.Font.Code
GuideDescBox3.Text = " - หากสคริปต์ค้างหรือไม่ขยับ ให้กดปุ่ม '♻ ล้างระบบ/รีเซ็ตสคริปต์ฉุกเฉิน'\n - ระบบจะล้างค่าบัฟเฟอร์ค้างและรีเซ็ตการทำงานทันทีอย่างไร้รอยต่อ"
GuideDescBox3.TextColor3 = Color3.fromRGB(52, 211, 153)
GuideDescBox3.TextSize = 10
GuideDescBox3.TextWrapped = true
GuideDescBox3.TextXAlignment = Enum.TextXAlignment.Left
GuideDescBox3.TextYAlignment = Enum.TextYAlignment.Top
GuideDescBox3.ZIndex = 6
Instance.new("UICorner", GuideDescBox3).CornerRadius = UDim.new(0, 8)

-- สร้างองค์ประกอบในแท็บอัพเดท หน้าที่ 3 (Tab 3: Changelog)
constructCategoryHeader(ChangelogContentArea, ">> [Changelog] V15.3.3 - Ultra-Precision Fix")
local ChangelogBox1 = Instance.new("TextLabel")
ChangelogBox1.Parent = ChangelogContentArea
ChangelogBox1.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
ChangelogBox1.Size = UDim2.new(1, 0, 0, 115)
ChangelogBox1.Font = Enum.Font.Code
ChangelogBox1.Text = " ✨ ฟีเจอร์ใหม่ในเวอร์ชัน V15.3.3:\n - อัปเกรดระบบส่งคำสั่ง (Precision Engine): แก้ไขปัญหาการกดผิดพลาดหรือตกหล่นในช่วงท้าย (ตัวที่ 14-15) ด้วยการจูนความหน่วงทุกโปรไฟล์ให้มีความเสถียรสูงสุดไม่ให้คิวล้น"
ChangelogBox1.TextColor3 = Color3.fromRGB(52, 211, 153)
ChangelogBox1.TextSize = 10
ChangelogBox1.TextWrapped = true
ChangelogBox1.TextXAlignment = Enum.TextXAlignment.Left
ChangelogBox1.TextYAlignment = Enum.TextYAlignment.Top
ChangelogBox1.ZIndex = 6
Instance.new("UICorner", ChangelogBox1).CornerRadius = UDim.new(0, 8)

constructCategoryHeader(ChangelogContentArea, ">> [Changelog] V14.0 ถึง V15.2 - Previous Upgrades")
local ChangelogBox2 = Instance.new("TextLabel")
ChangelogBox2.Parent = ChangelogContentArea
ChangelogBox2.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
ChangelogBox2.Size = UDim2.new(1, 0, 0, 125)
ChangelogBox2.Font = Enum.Font.Code
ChangelogBox2.Text = " 🚀 ประวัติการพัฒนาที่ผ่านมา:\n - V15.2: เพิ่มระบบ Smart UI Toggle ปุ่มสายฟ้าซ่อน/เปิดอัจฉริยะ\n - V15.0-V15.1: พัฒนาระบบ Config Auto-Save และ Triple-Pass Diagnostics"
ChangelogBox2.TextColor3 = Color3.fromRGB(203, 213, 225)
ChangelogBox2.TextSize = 10
ChangelogBox2.TextWrapped = true
ChangelogBox2.TextXAlignment = Enum.TextXAlignment.Left
ChangelogBox2.TextYAlignment = Enum.TextYAlignment.Top
ChangelogBox2.ZIndex = 6
Instance.new("UICorner", ChangelogBox2).CornerRadius = UDim.new(0, 8)

-- ระบบสลับแท็บ (Tab Switching Logic)
Tab1Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = true
    GuideContentArea.Visible = false
    ChangelogContentArea.Visible = false
    Tab1Button.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
    Tab1Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab2Button.TextColor3 = Color3.fromRGB(148, 163, 184)
    Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab3Button.TextColor3 = Color3.fromRGB(148, 163, 184)
end)

Tab2Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = false
    GuideContentArea.Visible = true
    ChangelogContentArea.Visible = false
    Tab2Button.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
    Tab2Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab1Button.TextColor3 = Color3.fromRGB(148, 163, 184)
    Tab3Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab3Button.TextColor3 = Color3.fromRGB(148, 163, 184)
end)

Tab3Button.MouseButton1Click:Connect(function()
    RightContentArea.Visible = false
    GuideContentArea.Visible = false
    ChangelogContentArea.Visible = true
    Tab3Button.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
    Tab3Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tab1Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab1Button.TextColor3 = Color3.fromRGB(148, 163, 184)
    Tab2Button.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
    Tab2Button.TextColor3 = Color3.fromRGB(148, 163, 184)
end)

----------------------------------------------------------------------------------------------------
-- [10] หน้าต่างป๊อปอัปเลือกโปรไฟล์ความเร็ว
----------------------------------------------------------------------------------------------------
local SecondarySelectorPanel = Instance.new("Frame")
SecondarySelectorPanel.Name = "SecondarySelectorMatrix"
SecondarySelectorPanel.Parent = RootContainerNode
SecondarySelectorPanel.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
SecondarySelectorPanel.Position = UDim2.new(0.08, 465, 0.12, 0)
SecondarySelectorPanel.Size = UDim2.new(0, 240, 0, 240)
SecondarySelectorPanel.Visible = false
SecondarySelectorPanel.Active = true
SecondarySelectorPanel.Draggable = true
SecondarySelectorPanel.ZIndex = 15
Instance.new("UICorner", SecondarySelectorPanel).CornerRadius = UDim.new(0, 10)

local secondaryStroke = Instance.new("UIStroke")
secondaryStroke.Color = Color3.fromRGB(20, 184, 166)
secondaryStroke.Transparency = 0.3
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
    local profileSelectionButton = constructInteractiveButton(SelectorScrollingList, profileData.Identifier, Color3.fromRGB(17, 24, 39))
    profileSelectionButton.ZIndex = 16
    profileSelectionButton.MouseButton1Click:Connect(function()
        activeProfilePointer = idx
        ModeSelectorTriggerButton.Text = "โปรไฟล์: " .. profileData.Identifier
        SecondarySelectorPanel.Visible = false
        
        currentActiveConfig.SelectedProfileIndex = idx
        saveUserConfiguration(currentActiveConfig)
        triggerApexToastNotification("บันทึกการตั้งค่า", "เปลี่ยนโปรไฟล์และเซฟ Config สำเร็จ", "SUCCESS")
    end)
end

ModeSelectorTriggerButton.MouseButton1Click:Connect(function()
    SecondarySelectorPanel.Visible = not SecondarySelectorPanel.Visible
end)

----------------------------------------------------------------------------------------------------
-- [11] ระบบแสดงค่า ปิง และ FPS
----------------------------------------------------------------------------------------------------
local StatsWidget = Instance.new("TextButton")
StatsWidget.Name = "MeridianStatsWidget"
StatsWidget.Parent = RootContainerNode
StatsWidget.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
StatsWidget.Position = UDim2.new(0.80, 0, 0.12, 0)
StatsWidget.Size = UDim2.new(0, 170, 0, 34)
StatsWidget.Font = Enum.Font.Code
StatsWidget.Text = "| ปิง: 0ms | FPS: 0 |"
StatsWidget.TextColor3 = Color3.fromRGB(45, 212, 191)
StatsWidget.TextSize = 10
StatsWidget.Active = true
StatsWidget.Draggable = true
StatsWidget.ZIndex = 8
Instance.new("UICorner", StatsWidget).CornerRadius = UDim.new(0, 8)

local statsStroke = Instance.new("UIStroke")
statsStroke.Color = Color3.fromRGB(20, 184, 166)
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
        pcall(function()
            pingVal = math.floor(LocalPlayer:GetNetworkPing() * 1000)
        end)
        
        StatsWidget.Text = string.format("| ปิง: %d ms | FPS: %d |", pingVal, currentFPS)
    end)
end)

----------------------------------------------------------------------------------------------------
-- [12.1] ปุ่มสี่เหลี่ยมเล็กรูปสายฟ้า (⚡ Lightning Toggle UI Widget)
----------------------------------------------------------------------------------------------------
LightningToggleWidget = Instance.new("TextButton")
LightningToggleWidget.Name = "MeridianLightningToggleWidget"
LightningToggleWidget.Parent = RootContainerNode
LightningToggleWidget.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
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

----------------------------------------------------------------------------------------------------
-- [12.2] ปุ่มลอยสีรุ้งไล่เฉดอลังการ (Rainbow Gradient Auto-Play Widget)
----------------------------------------------------------------------------------------------------
local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "MeridianSquareFloatingWidget"
SmallSquareFloatingWidget.Parent = RootContainerNode
SmallSquareFloatingWidget.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.Position = UDim2.new(0.88, 0, 0.22, 0)
SmallSquareFloatingWidget.Size = UDim2.new(0, 54, 0, 54)
SmallSquareFloatingWidget.Font = Enum.Font.Code
SmallSquareFloatingWidget.Text = "EXEC"
SmallSquareFloatingWidget.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.TextSize = 11
SmallSquareFloatingWidget.Visible = floatingWidgetActiveState
SmallSquareFloatingWidget.Active = true
SmallSquareFloatingWidget.Draggable = true
SmallSquareFloatingWidget.ZIndex = 15
Instance.new("UICorner", SmallSquareFloatingWidget).CornerRadius = UDim.new(0, 12)

local RainbowGradient = Instance.new("UIGradient")
RainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 128, 0)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 128)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 128, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(128, 0, 255))
})
RainbowGradient.Rotation = 45
RainbowGradient.Parent = SmallSquareFloatingWidget

local widgetStroke = Instance.new("UIStroke")
widgetStroke.Color = Color3.fromRGB(255, 255, 255)
widgetStroke.Thickness = 2
widgetStroke.Parent = SmallSquareFloatingWidget

task.spawn(function()
    while task.wait(0.03) do
        RainbowGradient.Rotation = (RainbowGradient.Rotation + 2) % 360
    end
end)

----------------------------------------------------------------------------------------------------
-- [13] ระบบสแกนเชิงโครงสร้างแมพ (Triple-Pass Integrity Check)
----------------------------------------------------------------------------------------------------
local function executeAdvancedDiagnosticParsing()
    local targetInterface = LocalPlayer.PlayerGui:FindFirstChild("MatchUI")
    if not targetInterface or not targetInterface:FindFirstChild("MatchRoot") then 
        return nil 
    end
    
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

    table.sort(collectedNodes, function(elementA, elementB)
        if math.abs(elementA.PositionX - elementB.PositionX) > 4 then
            return elementA.PositionX < elementB.PositionX
        end
        return elementA.PositionY < elementB.PositionY
    end)

    local assembledString = ""
    for j = 1, #collectedNodes do
        assembledString = assembledString .. collectedNodes[j].Character
    end

    return #assembledString >= 3 and assembledString or nil
end

local function verifySequenceIntegrityTriplePass()
    local passAlpha = executeAdvancedDiagnosticParsing()
    if not passAlpha then return nil end
    
    task.wait(0.002)
    local passBeta = executeAdvancedDiagnosticParsing()
    if not passBeta or passAlpha ~= passBeta then return nil end
    
    task.wait(0.002)
    local passGamma = executeAdvancedDiagnosticParsing()
    if not passGamma or passBeta ~= passGamma then return nil end
    
    return passGamma
end

----------------------------------------------------------------------------------------------------
-- [14] ระบบส่งคำสั่งความเร็วความแม่นยำสูง (Precision Optimized Execution Stream)
----------------------------------------------------------------------------------------------------
local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: กำลังประมวลผลความเร็วความแม่นยำสูง..."
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(56, 189, 248)
    triggerApexToastNotification("กำลังทำงาน", "กำลังแก้รูบิคด้วยโปรไฟล์: " .. activeProfile.Identifier, "SUCCESS")
    
    task.spawn(function()
        for idx = 1, #sequencePayload do
            local targetChar = sequencePayload:sub(idx, idx)
            pcall(function()
                local mappedKey = Enum.KeyCode[targetChar]
                if mappedKey then
                    -- ส่งสัญญาณกดปุ่มลงและปล่อยอย่างเป็นระเบียบ ป้องกันคิวล้นช่วงท้าย
                    VirtualInputManager:SendKeyEvent(true, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration)
                    VirtualInputManager:SendKeyEvent(false, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration)
                end
            end)
        end
        
        SystemTelemetryDisplayBox.Text = "  [สถานะ]: ดำเนินการเสร็จสิ้นสมบูรณ์ 100%"
        SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
        triggerApexToastNotification("สำเร็จ!", "แก้รูบิคเสร็จสิ้นสมบูรณ์ครบทุกตัว", "SUCCESS")
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

----------------------------------------------------------------------------------------------------
-- [15] การเชื่อมโยงอีเวนต์ปุ่มกดทั้งหมด (Event Bindings)
----------------------------------------------------------------------------------------------------
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
    triggerApexToastNotification("ซ่อน UI", "ซ่อนหน้าต่างหลักแล้ว (กดปุ่มสายฟ้าเพื่อเปิด)", "WARNING")
end)

ToggleFloatingInterfaceButton.MouseButton1Click:Connect(function()
    floatingWidgetActiveState = not floatingWidgetActiveState
    SmallSquareFloatingWidget.Visible = floatingWidgetActiveState
    if floatingWidgetActiveState then
        triggerApexToastNotification("ปุ่มลอย", "เปิดแสดงผลปุ่มลอยสายรุ้ง (Auto Play) แล้ว", "SUCCESS")
    else
        triggerApexToastNotification("ปุ่มลอย", "ซ่อนปุ่มลอยสายรุ้งเรียบร้อย", "WARNING")
    end
    currentActiveConfig.FloatingWidgetEnabled = floatingWidgetActiveState
    saveUserConfiguration(currentActiveConfig)
end)

EmergencyResetButton.MouseButton1Click:Connect(function()
    coreExecutionFlag = false
    sequenceMemoryBuffer = ""
    SequenceInputField.Text = ""
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: รีเซ็ตระบบฉุกเฉินและล้างบัฟเฟอร์สำเร็จ"
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(248, 113, 113)
    triggerApexToastNotification("รีเซ็ตระบบ", "ล้างค่าบัฟเฟอร์และรีเซ็ตสคริปต์เรียบร้อย", "ERROR")
end)

----------------------------------------------------------------------------------------------------
-- [16] ระบบสแกนพื้นหลังตลอดเวลา (Background Anti-Overlap Threading)
----------------------------------------------------------------------------------------------------
task.spawn(function()
    local lastRegisteredSequence = ""
    while task.wait(0.1) do
        if isBackgroundScannerActive and not coreExecutionFlag then
            pcall(function()
                local parsedTokenResult = verifySequenceIntegrityTriplePass()
                if parsedTokenResult and parsedTokenResult ~= lastRegisteredSequence then
                    lastRegisteredSequence = parsedTokenResult
                    sequenceMemoryBuffer = parsedTokenResult
                    SequenceInputField.Text = sequenceMemoryBuffer
                    SystemTelemetryDisplayBox.Text = "  [สถานะ]: ซิงค์โหนดสำเร็จ (" .. #sequenceMemoryBuffer + 0 .. " จุด)"
                    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
                end
            end)
        end
    end
end)

print("MERIDIAN HUB V15.3.3 APEX: Loaded Successfully with Ultra-Precision Execution Fix!")
