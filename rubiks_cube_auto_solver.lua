----------------------------------------------------------------------------------------------------
-- MERIDIAN HUB // QUANTUM MATRIX APEX KERNEL (V8.1 STABLE PURE EDITION)
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Safe Structural Memory Purge
if CoreGui:FindFirstChild("MeridianHubStructuralContainer") then
    CoreGui.MeridianHubStructuralContainer:Destroy()
end

----------------------------------------------------------------------------------------------------
-- 1. ระบบควบคุมโปรไฟล์ความเร็วโครงสร้างหลัก (Pure Velocity Matrix - ไม่มีระบบคูลดาวน์ตีกัน)
----------------------------------------------------------------------------------------------------
local VelocityMatrixRegistry = {
    [1] = {Identifier = "ระดับ 1 : เนียนตา เล่นกับคน (Human Stealth)", DelayDuration = 0.085, PrecisionRate = "100.0%", KernelRisk = "ปลอดภัยสูงสุด"},
    [2] = {Identifier = "ระดับ 2 : สมดุล ไวทันใจ (Balanced Fast)", DelayDuration = 0.040, PrecisionRate = "100.0%", KernelRisk = "ต่ำมาก"},
    [3] = {Identifier = "ระดับ 3 : กึ่งครึ่งวิ (Sub-Half Second)", DelayDuration = 0.015, PrecisionRate = "99.9%", KernelRisk = "ปานกลาง"},
    [4] = {Identifier = "ระดับ 4 : ควอนตัมสตรีม (Quantum Stream)", DelayDuration = 0.005, PrecisionRate = "99.9%", KernelRisk = "สมดุลสูง"},
    [5] = {Identifier = "ระดับ 5 : ขีดสุดความเร็วแสง (Singularity Apex)", DelayDuration = 0.001, PrecisionRate = "99.8%", KernelRisk = "ระมัดระวัง"}
}

local activeProfilePointer = 1
local sequenceMemoryBuffer = ""
local coreExecutionFlag = false
local floatingWidgetActiveState = false
local isInterfaceHiddenState = false
local isBackgroundScannerActive = true

----------------------------------------------------------------------------------------------------
-- 2. การสร้างรากฐาน GUI ระดับโครงสร้าง (Structural Root Container)
----------------------------------------------------------------------------------------------------
local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "MeridianHubStructuralContainer"
RootContainerNode.Parent = CoreGui
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

----------------------------------------------------------------------------------------------------
-- 3. หน้าโหลดก่อนเปิดสคริปต์
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

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 14)
cardCorner.Parent = LoadingCard

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
LoadingTitle.Text = "MERIDIAN HUB // V8.1 PURE CORE"
LoadingTitle.TextColor3 = Color3.fromRGB(45, 212, 191)
LoadingTitle.TextSize = 14
LoadingTitle.TextXAlignment = Enum.TextXAlignment.Left
LoadingTitle.ZIndex = 27

local LoadingStatusText = Instance.new("TextLabel")
LoadingStatusText.Parent = LoadingCard
LoadingStatusText.BackgroundTransparency = 1
LoadingStatusText.Position = UDim2.new(0, 20, 0, 65)
LoadingStatusText.Size = UDim2.new(1, -40, 0, 20)
LoadingStatusText.Font = Enum.Font.Code
LoadingStatusText.Text = "กำลังเริ่มต้นระบบเสถียรภาพ..."
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

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = LoadingBarBackground

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Parent = LoadingBarBackground
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.ZIndex = 28

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = LoadingBarFill

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
-- 4. หน้าต่างยอมรับความเสี่ยง
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

local disclaimerCorner = Instance.new("UICorner")
disclaimerCorner.CornerRadius = UDim.new(0, 14)
disclaimerCorner.Parent = DisclaimerModalFrame

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
DisclaimerTitle.Text = "⚠️ แจ้งเตือนข้อตกลงและความเสี่ยง"
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
DisclaimerDesc.Text = "การใช้งานสคริปต์ระบบเสริมประสิทธิภาพ มีความเสี่ยงต่อการถูกตรวจสอบ ผู้ใช้งานต้องยอมรับความเสี่ยงทั้งหมดด้วยตนเอง หากกดปฏิเสธ ระบบจะทำการตัดการเชื่อมต่อทันที"
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
AcceptButton.Text = "ยอมรับเงื่อนไข"
AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AcceptButton.TextSize = 11
AcceptButton.ZIndex = 21

local acceptCorner = Instance.new("UICorner")
acceptCorner.CornerRadius = UDim.new(0, 8)
acceptCorner.Parent = AcceptButton

local DeclineButton = Instance.new("TextButton")
DeclineButton.Parent = DisclaimerModalFrame
DeclineButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
DeclineButton.Position = UDim2.new(0.53, 6, 0, 175)
DeclineButton.Size = UDim2.new(0.47, -6, 0, 42)
DeclineButton.Font = Enum.Font.Code
DeclineButton.Text = "ปฏิเสธ"
DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeclineButton.TextSize = 11
DeclineButton.ZIndex = 21

local declineCorner = Instance.new("UICorner")
declineCorner.CornerRadius = UDim.new(0, 8)
declineCorner.Parent = DeclineButton

task.spawn(function()
    local steps = {
        {progress = 30, text = "กำลังคอมไพล์ Pure Kernel..."},
        {progress = 70, text = "กำลังซิงโครไนซ์โปรไฟล์ความเร็ว..."},
        {progress = 100, text = "ระบบพร้อมใช้งาน 100%!"}
    }
    
    for _, step in ipairs(steps) do
        LoadingStatusText.Text = step.text
        local targetSize = UDim2.new(step.progress / 100, 0, 1, 0)
        TweenService:Create(LoadingBarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
        LoadingPercentage.Text = step.progress .. "%"
        task.wait(0.35)
    end
    
    task.wait(0.2)
    TweenService:Create(LoadingScreenFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    LoadingScreenFrame.Visible = false
    DisclaimerModalFrame.Visible = true
end)

DeclineButton.MouseButton1Click:Connect(function()
    LocalPlayer:Kick("MERIDIAN HUB: คุณปฏิเสธเงื่อนไขความปลอดภัย ระบบจึงตัดการเชื่อมต่อ")
end)

----------------------------------------------------------------------------------------------------
-- 5. หน้าต่างหลักแดชบอร์ด
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

local WindowCornerRadius = Instance.new("UICorner")
WindowCornerRadius.CornerRadius = UDim.new(0, 14)
WindowCornerRadius.Parent = PrimaryWindowFrame

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(20, 184, 166)
WindowBorderGlow.Transparency = 0.25
WindowBorderGlow.Thickness = 1.8
WindowBorderGlow.Parent = PrimaryWindowFrame

AcceptButton.MouseButton1Click:Connect(function()
    TweenService:Create(DisclaimerModalFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    DisclaimerModalFrame.Visible = false
    PrimaryWindowFrame.Visible = true
end)

local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 45)
HeaderNavigationPanel.ZIndex = 6

local HeaderCornerFix = Instance.new("UICorner")
HeaderCornerFix.CornerRadius = UDim.new(0, 14)
HeaderCornerFix.Parent = HeaderNavigationPanel

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
HeaderTitleLabel.Size = UDim2.new(1, -70, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = "MERIDIAN HUB // V8.1 PURE STABLE"
HeaderTitleLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
HeaderTitleLabel.TextSize = 12
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitleLabel.ZIndex = 7

local HideInterfaceButton = Instance.new("TextButton")
HideInterfaceButton.Parent = HeaderNavigationPanel
HideInterfaceButton.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
HideInterfaceButton.Position = UDim2.new(1, -44, 0, 9)
HideInterfaceButton.Size = UDim2.new(0, 28, 0, 26)
HideInterfaceButton.Font = Enum.Font.Code
HideInterfaceButton.Text = "⚡"
HideInterfaceButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideInterfaceButton.TextSize = 13
HideInterfaceButton.ZIndex = 7

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 6)
hideBtnCorner.Parent = HideInterfaceButton

----------------------------------------------------------------------------------------------------
-- เลย์เอาต์ฝั่งซ้าย: ข้อมูลตัวละครจริง
----------------------------------------------------------------------------------------------------
local LeftProfileSidebar = Instance.new("Frame")
LeftProfileSidebar.Parent = PrimaryWindowFrame
LeftProfileSidebar.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
LeftProfileSidebar.Position = UDim2.new(0, 15, 0, 55)
LeftProfileSidebar.Size = UDim2.new(0, 185, 1, -68)
LeftProfileSidebar.ZIndex = 6

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 10)
sidebarCorner.Parent = LeftProfileSidebar

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

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 8)
avatarCorner.Parent = UserAvatarImage

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

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 4)
hbCorner.Parent = HealthBarBg

local HealthBarFill = Instance.new("Frame")
HealthBarFill.Parent = HealthBarBg
HealthBarFill.BackgroundColor3 = Color3.fromRGB(52, 211, 153)
HealthBarFill.Size = UDim2.new(1, 0, 1, 0)
HealthBarFill.ZIndex = 8

local hbfCorner = Instance.new("UICorner")
hbfCorner.CornerRadius = UDim.new(0, 4)
hbfCorner.Parent = HealthBarFill

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
SidebarInfoBox.Text = "\n[สถานะระบบ]\n- Matrix: Pure Stable\n- โหมด: ความเร็วตรงเวลา\n- ไม่มีดีเลย์ตีกัน\n\n[เครดิต]\nMERIDIAN V8.1"
SidebarInfoBox.TextColor3 = Color3.fromRGB(148, 163, 184)
SidebarInfoBox.TextSize = 10
SidebarInfoBox.TextWrapped = true
SidebarInfoBox.TextXAlignment = Enum.TextXAlignment.Left
SidebarInfoBox.TextYAlignment = Enum.TextYAlignment.Top
SidebarInfoBox.ZIndex = 7

local sbibCorner = Instance.new("UICorner")
sbibCorner.CornerRadius = UDim.new(0, 6)
sbibCorner.Parent = SidebarInfoBox

----------------------------------------------------------------------------------------------------
-- พื้นที่เนื้อหาหลักฝั่งขวา
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
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = buttonInstance
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Transparency = 0.85
    buttonStroke.Thickness = 1
    buttonStroke.Parent = buttonInstance
    
    return buttonInstance
end

constructCategoryHeader(RightContentArea, ">> ระบบ Telemetry & Pure Status")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = RightContentArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 38)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [สถานะ]: พร้อมปฏิบัติการ (Pure Speed Active)"
SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
SystemTelemetryDisplayBox.TextSize = 10
SystemTelemetryDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
SystemTelemetryDisplayBox.ZIndex = 6

local telemetryCorner = Instance.new("UICorner")
telemetryCorner.CornerRadius = UDim.new(0, 8)
telemetryCorner.Parent = SystemTelemetryDisplayBox

constructCategoryHeader(RightContentArea, ">> เลือกโปรไฟล์ความเร็วโครงสร้าง")
local ModeSelectorTriggerButton = constructInteractiveButton(RightContentArea, "โปรไฟล์: ระดับ 1 : เนียนตา เล่นกับคน", Color3.fromRGB(17, 24, 39))

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

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = SequenceInputField

constructCategoryHeader(RightContentArea, ">> ควบคุมการทำงานหลัก & รีเซ็ต")
local InitializeEngineButton = constructInteractiveButton(RightContentArea, "▶ เริ่มต้นรันโปรโตคอลโครงสร้างอัตโนมัติ", Color3.fromRGB(13, 148, 136))
local EmergencyResetButton = constructInteractiveButton(RightContentArea, "♻ ล้างระบบ/รีเซ็ตสคริปต์ฉุกเฉิน (Fix Bug)", Color3.fromRGB(153, 27, 27))

constructCategoryHeader(RightContentArea, ">> ปุ่มลอยด่วนบนหน้าจอ")
local ToggleFloatingInterfaceButton = constructInteractiveButton(RightContentArea, "เปิดใช้งานปุ่มลอยด่วน (EXEC)", Color3.fromRGB(51, 65, 85))

----------------------------------------------------------------------------------------------------
-- 8. หน้าต่างป๊อปอัปเลือกโปรไฟล์ความเร็ว
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

local secondaryCorner = Instance.new("UICorner")
secondaryCorner.CornerRadius = UDim.new(0, 10)
secondaryCorner.Parent = SecondarySelectorPanel

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
    end)
end

ModeSelectorTriggerButton.MouseButton1Click:Connect(function()
    SecondarySelectorPanel.Visible = not SecondarySelectorPanel.Visible
end)

----------------------------------------------------------------------------------------------------
-- 9. ระบบแสดงค่า ปิง (Ping) และ FPS
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

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 8)
statsCorner.Parent = StatsWidget

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
-- 10. ปุ่มลอยสีรุ้งไล่เฉดอลังการ (Rainbow Gradient Dynamic Floating Widget)
----------------------------------------------------------------------------------------------------
local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "MeridianSquareFloatingWidget"
SmallSquareFloatingWidget.Parent = RootContainerNode
SmallSquareFloatingWidget.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.Position = UDim2.new(0.85, 0, 0.35, 0)
SmallSquareFloatingWidget.Size = UDim2.new(0, 60, 0, 60)
SmallSquareFloatingWidget.Font = Enum.Font.Code
SmallSquareFloatingWidget.Text = "EXEC"
SmallSquareFloatingWidget.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.TextSize = 12
SmallSquareFloatingWidget.Visible = false
SmallSquareFloatingWidget.Active = true
SmallSquareFloatingWidget.Draggable = true
SmallSquareFloatingWidget.ZIndex = 15

local widgetCorner = Instance.new("UICorner")
widgetCorner.CornerRadius = UDim.new(0, 14)
widgetCorner.Parent = SmallSquareFloatingWidget

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
widgetStroke.Thickness = 2.5
widgetStroke.Parent = SmallSquareFloatingWidget

task.spawn(function()
    while task.wait(0.03) do
        RainbowGradient.Rotation = (RainbowGradient.Rotation + 2) % 360
    end
end)

SmallSquareFloatingWidget.MouseButton1Down:Connect(function()
    TweenService:Create(SmallSquareFloatingWidget, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 52, 0, 52)}):Play()
end)

SmallSquareFloatingWidget.MouseButton1Up:Connect(function()
    TweenService:Create(SmallSquareFloatingWidget, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 60, 0, 60)}):Play()
end)

ToggleFloatingInterfaceButton.MouseButton1Click:Connect(function()
    floatingWidgetActiveState = not floatingWidgetActiveState
    SmallSquareFloatingWidget.Visible = floatingWidgetActiveState
    if floatingWidgetActiveState then
        ToggleFloatingInterfaceButton.Text = "ปิดการใช้งานปุ่มลอย"
        ToggleFloatingInterfaceButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
    else
        ToggleFloatingInterfaceButton.Text = "เปิดใช้งานปุ่มลอยด่วน (EXEC)"
        ToggleFloatingInterfaceButton.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
    end
end)

local GhostWidget = Instance.new("TextButton")
GhostWidget.Name = "MeridianGhostWidget"
GhostWidget.Parent = RootContainerNode
GhostWidget.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
GhostWidget.Position = UDim2.new(0.03, 0, 0.12, 0)
GhostWidget.Size = UDim2.new(0, 45, 0, 45)
GhostWidget.Font = Enum.Font.Code
GhostWidget.Text = "⚡"
GhostWidget.TextSize = 18
GhostWidget.Visible = false
GhostWidget.Active = true
GhostWidget.Draggable = true
GhostWidget.ZIndex = 8

local ghostCorner = Instance.new("UICorner")
ghostCorner.CornerRadius = UDim.new(1, 0)
ghostCorner.Parent = GhostWidget

HideInterfaceButton.MouseButton1Click:Connect(function()
    isInterfaceHiddenState = true
    PrimaryWindowFrame.Visible = false
    SecondarySelectorPanel.Visible = false
    GhostWidget.Visible = true
end)

GhostWidget.MouseButton1Click:Connect(function()
    isInterfaceHiddenState = false
    PrimaryWindowFrame.Visible = true
    GhostWidget.Visible = false
end)

----------------------------------------------------------------------------------------------------
-- 11. ระบบสแกนเชิงโครงสร้างแมพ
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
-- 12. ระบบส่งคำสั่งความเร็วเพียวๆ (ถอดระบบสุ่มคูลดาวน์ออก ไม่ให้ตีกันแล้ว)
----------------------------------------------------------------------------------------------------
local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: กำลังประมวลผลความเร็วเพียว..."
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(56, 189, 248)
    
    task.spawn(function()
        for idx = 1, #sequencePayload do
            local targetChar = sequencePayload:sub(idx, idx)
            pcall(function()
                local mappedKey = Enum.KeyCode[targetChar]
                if mappedKey then
                    VirtualInputManager:SendKeyEvent(true, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration)
                    VirtualInputManager:SendKeyEvent(false, mappedKey, false, game)
                    task.wait(activeProfile.DelayDuration) -- วิ่งตามความเร็วโปรไฟล์เป๊ะๆ ไม่ตีกัน
                end
            end)
        end
        
        SystemTelemetryDisplayBox.Text = "  [สถานะ]: ดำเนินการเสร็จสิ้นตามเวลาโปรไฟล์ 100%"
        SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
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
    end
end

EmergencyResetButton.MouseButton1Click:Connect(function()
    coreExecutionFlag = false
    sequenceMemoryBuffer = ""
    SequenceInputField.Text = ""
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: รีเซ็ตระบบฉุกเฉินสำเร็จ"
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(248, 113, 113)
end)

----------------------------------------------------------------------------------------------------
-- 13. ระบบสแกนพื้นหลังตลอดเวลา
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

----------------------------------------------------------------------------------------------------
-- 14. การเชื่อมโยงอีเวนต์หลัก
----------------------------------------------------------------------------------------------------
InitializeEngineButton.MouseButton1Click:Connect(processExecutionTriggerRoutine)
SmallSquareFloatingWidget.MouseButton1Click:Connect(processExecutionTriggerRoutine)

print("MERIDIAN HUB V8.1 PURE STABLE: Loaded Successfully!")
