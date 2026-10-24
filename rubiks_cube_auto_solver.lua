----------------------------------------------------------------------------------------------------
-- MERIDIAN HUB // ULTIMATE STRUCTURAL KERNEL (V6.1 FIXED EDITION)
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Safe Structural Memory Purge
if CoreGui:FindFirstChild("MeridianHubStructuralContainer") then
    CoreGui.MeridianHubStructuralContainer:Destroy()
end

----------------------------------------------------------------------------------------------------
-- 1. ระบบควบคุมโปรไฟล์ความเร็วเชิงโครงสร้าง (Tuned Speed Profiles)
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
-- 3. หน้าโหลดก่อนเปิดสคริปต์ (Loading Screen)
----------------------------------------------------------------------------------------------------
local LoadingScreenFrame = Instance.new("Frame")
LoadingScreenFrame.Name = "LoadingScreen"
LoadingScreenFrame.Parent = RootContainerNode
LoadingScreenFrame.BackgroundColor3 = Color3.fromRGB(8, 11, 16)
LoadingScreenFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingScreenFrame.ZIndex = 20

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingScreenFrame
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0.5, -200, 0.4, -40)
LoadingTitle.Size = UDim2.new(0, 400, 0, 50)
LoadingTitle.Font = Enum.Font.Code
LoadingTitle.Text = "MERIDIAN HUB // INITIALIZING..."
LoadingTitle.TextColor3 = Color3.fromRGB(45, 212, 191)
LoadingTitle.TextSize = 16
LoadingTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Parent = LoadingScreenFrame
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
LoadingBarBackground.Position = UDim2.new(0.5, -150, 0.4, 30)
LoadingBarBackground.Size = UDim2.new(0, 300, 0, 8)

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = LoadingBarBackground

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Parent = LoadingBarBackground
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = LoadingBarFill

----------------------------------------------------------------------------------------------------
-- 4. หน้าต่างยอมรับความเสี่ยง (Disclaimer Modal)
----------------------------------------------------------------------------------------------------
local DisclaimerModalFrame = Instance.new("Frame")
DisclaimerModalFrame.Name = "DisclaimerModal"
DisclaimerModalFrame.Parent = RootContainerNode
DisclaimerModalFrame.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
DisclaimerModalFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
DisclaimerModalFrame.Size = UDim2.new(0, 400, 0, 220)
DisclaimerModalFrame.Visible = false
DisclaimerModalFrame.ZIndex = 15

local disclaimerCorner = Instance.new("UICorner")
disclaimerCorner.CornerRadius = UDim.new(0, 12)
disclaimerCorner.Parent = DisclaimerModalFrame

local disclaimerStroke = Instance.new("UIStroke")
disclaimerStroke.Color = Color3.fromRGB(20, 184, 166)
disclaimerStroke.Thickness = 1.5
disclaimerStroke.Parent = DisclaimerModalFrame

local DisclaimerTitle = Instance.new("TextLabel")
DisclaimerTitle.Parent = DisclaimerModalFrame
DisclaimerTitle.BackgroundTransparency = 1
DisclaimerTitle.Position = UDim2.new(0, 20, 0, 20)
DisclaimerTitle.Size = UDim2.new(1, -40, 0, 30)
DisclaimerTitle.Font = Enum.Font.Code
DisclaimerTitle.Text = "⚠️ ข้อควรระวังและยอมรับความเสี่ยง"
DisclaimerTitle.TextColor3 = Color3.fromRGB(248, 113, 113)
DisclaimerTitle.TextSize = 13
DisclaimerTitle.TextXAlignment = Enum.TextXAlignment.Left

local DisclaimerDesc = Instance.new("TextLabel")
DisclaimerDesc.Parent = DisclaimerModalFrame
DisclaimerDesc.BackgroundTransparency = 1
DisclaimerDesc.Position = UDim2.new(0, 20, 0, 60)
DisclaimerDesc.Size = UDim2.new(1, -40, 0, 80)
DisclaimerDesc.Font = Enum.Font.Code
DisclaimerDesc.Text = "การใช้สคริปต์อาจมีความเสี่ยงต่อการถูกระงับบัญชี (Ban) ผู้ใช้งานต้องยอมรับความเสี่ยงได้ เพราะถ้ารับไม่ได้ รหัสโดนแบนทางเราก็รับผิดชอบไม่ได้ เพราะเองต้องรับความเสี่ยงเองนะ"
DisclaimerDesc.TextColor3 = Color3.fromRGB(203, 213, 225)
DisclaimerDesc.TextSize = 11
DisclaimerDesc.TextWrapped = true
DisclaimerDesc.TextXAlignment = Enum.TextXAlignment.Left

local AcceptButton = Instance.new("TextButton")
AcceptButton.Parent = DisclaimerModalFrame
AcceptButton.BackgroundColor3 = Color3.fromRGB(13, 148, 136)
AcceptButton.Position = UDim2.new(0, 20, 0, 155)
AcceptButton.Size = UDim2.new(0.46, 0, 0, 40)
AcceptButton.Font = Enum.Font.Code
AcceptButton.Text = "ยอมรับ (AGREE)"
AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AcceptButton.TextSize = 11
AcceptButton.ZIndex = 16

local acceptCorner = Instance.new("UICorner")
acceptCorner.CornerRadius = UDim.new(0, 8)
acceptCorner.Parent = AcceptButton

local DeclineButton = Instance.new("TextButton")
DeclineButton.Parent = DisclaimerModalFrame
DeclineButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
DeclineButton.Position = UDim2.new(0.54, 0, 0, 155)
DeclineButton.Size = UDim2.new(0.46, 0, 0, 40)
DeclineButton.Font = Enum.Font.Code
DeclineButton.Text = "ไม่ยอมรับ (DECLINE)"
DeclineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeclineButton.TextSize = 11
DeclineButton.ZIndex = 16

local declineCorner = Instance.new("UICorner")
declineCorner.CornerRadius = UDim.new(0, 8)
declineCorner.Parent = DeclineButton

----------------------------------------------------------------------------------------------------
-- รันแอนิเมชันหน้าโหลด (ปรับปรุงใหม่ให้ลื่นและไม่ค้าง)
----------------------------------------------------------------------------------------------------
task.spawn(function()
    for i = 1, 100 do
        LoadingBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        task.wait(0.01)
    end
    LoadingScreenFrame.Visible = false
    DisclaimerModalFrame.Visible = true
end)

DeclineButton.MouseButton1Click:Connect(function()
    LocalPlayer:Kick("MERIDIAN HUB: คุณปฏิเสธเงื่อนไขความปลอดภัย ระบบจึงตัดการเชื่อมต่อ")
end)

----------------------------------------------------------------------------------------------------
-- 5. หน้าต่างหลักของ MERIDIAN HUB (Dashboard UI)
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MeridianPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(8, 11, 16)
PrimaryWindowFrame.BackgroundTransparency = 0.02
PrimaryWindowFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 400, 0, 520)
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
    DisclaimerModalFrame.Visible = false
    PrimaryWindowFrame.Visible = true
end)

-- แถบหัวข้อหลักแบรนด์ MERIDIAN HUB
local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 50)
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
HeaderTitleLabel.Text = "MERIDIAN HUB // v6.0 Core"
HeaderTitleLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
HeaderTitleLabel.TextSize = 12
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitleLabel.ZIndex = 7

-- ปุ่มซ่อน UI (Ghost Mode)
local HideInterfaceButton = Instance.new("TextButton")
HideInterfaceButton.Parent = HeaderNavigationPanel
HideInterfaceButton.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
HideInterfaceButton.Position = UDim2.new(1, -44, 0, 11)
HideInterfaceButton.Size = UDim2.new(0, 30, 0, 28)
HideInterfaceButton.Font = Enum.Font.Code
HideInterfaceButton.Text = "⚡"
HideInterfaceButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideInterfaceButton.TextSize = 14
HideInterfaceButton.ZIndex = 7

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 6)
hideBtnCorner.Parent = HideInterfaceButton

-- พื้นที่เลื่อนเนื้อหา
local MainScrollingArea = Instance.new("ScrollingFrame")
MainScrollingArea.Name = "ScrollingContainer"
MainScrollingArea.Parent = PrimaryWindowFrame
MainScrollingArea.BackgroundTransparency = 1
MainScrollingArea.Position = UDim2.new(0, 16, 0, 60)
MainScrollingArea.Size = UDim2.new(1, -32, 1, -72)
MainScrollingArea.CanvasSize = UDim2.new(0, 0, 0, 600)
MainScrollingArea.ScrollBarThickness = 3
MainScrollingArea.ScrollBarImageColor3 = Color3.fromRGB(20, 184, 166)
MainScrollingArea.ZIndex = 6

local VerticalLayoutEngine = Instance.new("UIListLayout")
VerticalLayoutEngine.Parent = MainScrollingArea
VerticalLayoutEngine.SortOrder = Enum.SortOrder.LayoutOrder
VerticalLayoutEngine.Padding = UDim.new(0, 12)

----------------------------------------------------------------------------------------------------
-- 6. ฟังก์ชันสร้างองค์ประกอบ UI ย่อย
----------------------------------------------------------------------------------------------------
local function constructCategoryHeader(parentContainer, labelTextContent)
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Parent = parentContainer
    headerLabel.BackgroundTransparency = 1
    headerLabel.Size = UDim2.new(1, 0, 0, 18)
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
    buttonInstance.Size = UDim2.new(1, 0, 0, 40)
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

----------------------------------------------------------------------------------------------------
-- 7. ระบบ Telemetry และตัวเลือกโปรไฟล์
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> สถานะระบบและเครดิต (System Telemetry & Credits)")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = MainScrollingArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 42)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [สถานะ]: พร้อมปฏิบัติการ | เครดิต: MERIDIAN HUB"
SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
SystemTelemetryDisplayBox.TextSize = 10
SystemTelemetryDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
SystemTelemetryDisplayBox.ZIndex = 6

local telemetryCorner = Instance.new("UICorner")
telemetryCorner.CornerRadius = UDim.new(0, 8)
telemetryCorner.Parent = SystemTelemetryDisplayBox

local telemetryStroke = Instance.new("UIStroke")
telemetryStroke.Color = Color3.fromRGB(30, 41, 59)
telemetryStroke.Thickness = 1
telemetryStroke.Parent = SystemTelemetryDisplayBox

constructCategoryHeader(MainScrollingArea, ">> เลือกโปรไฟล์ความเร็วโครงสร้าง (Velocity Profiles)")
local ModeSelectorTriggerButton = constructInteractiveButton(MainScrollingArea, "โปรไฟล์: ระดับ 1 : เนียนตา เล่นกับคน", Color3.fromRGB(17, 24, 39))

local ProfileDetailsDisplayBox = Instance.new("TextLabel")
ProfileDetailsDisplayBox.Parent = MainScrollingArea
ProfileDetailsDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
ProfileDetailsDisplayBox.Size = UDim2.new(1, 0, 0, 45)
ProfileDetailsDisplayBox.Font = Enum.Font.Code
ProfileDetailsDisplayBox.Text = "  หน่วงเวลา: 0.08500s | ความแม่นยำ: 100.0% | ความเสี่ยง: ปลอดภัยสูงสุด"
ProfileDetailsDisplayBox.TextColor3 = Color3.fromRGB(203, 213, 225)
ProfileDetailsDisplayBox.TextSize = 10
ProfileDetailsDisplayBox.TextWrapped = true
ProfileDetailsDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
ProfileDetailsDisplayBox.TextYAlignment = Enum.TextYAlignment.Center
ProfileDetailsDisplayBox.ZIndex = 6

local detailsCorner = Instance.new("UICorner")
detailsCorner.CornerRadius = UDim.new(0, 8)
detailsCorner.Parent = ProfileDetailsDisplayBox

local detailsStroke = Instance.new("UIStroke")
detailsStroke.Color = Color3.fromRGB(30, 41, 59)
detailsStroke.Thickness = 1
detailsStroke.Parent = ProfileDetailsDisplayBox

constructCategoryHeader(MainScrollingArea, ">> ชุดคำสั่งที่สแกนจากโครงสร้างแมพ (Sequence Registry)")
local SequenceInputField = Instance.new("TextBox")
SequenceInputField.Parent = MainScrollingArea
SequenceInputField.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SequenceInputField.Size = UDim2.new(1, 0, 0, 45)
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

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(30, 41, 59)
inputStroke.Thickness = 1
inputStroke.Parent = SequenceInputField

constructCategoryHeader(MainScrollingArea, ">> ควบคุมการทำงานหลัก (Execution Engine & Auto-Tuner)")
local InitializeEngineButton = constructInteractiveButton(MainScrollingArea, "▶ เริ่มต้นรันโปรโตคอลโครงสร้างอัตโนมัติ", Color3.fromRGB(13, 148, 136))
local EmergencyResetButton = constructInteractiveButton(MainScrollingArea, "♻ ล้างระบบ/รีเซ็ตสคริปต์ฉุกเฉิน (Fix Bug)", Color3.fromRGB(153, 27, 27))

constructCategoryHeader(MainScrollingArea, ">> ปุ่มลอยด่วนบนหน้าจอ (Floating Widget)")
local ToggleFloatingInterfaceButton = constructInteractiveButton(MainScrollingArea, "เปิดใช้งานปุ่มลอยด่วน (EXEC)", Color3.fromRGB(51, 65, 85))

----------------------------------------------------------------------------------------------------
-- 8. หน้าต่างป๊อปอัปเลือกโปรไฟล์ความเร็ว
----------------------------------------------------------------------------------------------------
local SecondarySelectorPanel = Instance.new("Frame")
SecondarySelectorPanel.Name = "SecondarySelectorMatrix"
SecondarySelectorPanel.Parent = RootContainerNode
SecondarySelectorPanel.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
SecondarySelectorPanel.Position = UDim2.new(0.1, 410, 0.15, 0)
SecondarySelectorPanel.Size = UDim2.new(0, 260, 0, 260)
SecondarySelectorPanel.Visible = false
SecondarySelectorPanel.Active = true
SecondarySelectorPanel.Draggable = true
SecondarySelectorPanel.ZIndex = 10

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
SelectorScrollingList.CanvasSize = UDim2.new(0, 0, 0, 280)
SelectorScrollingList.ScrollBarThickness = 2
SelectorScrollingList.ZIndex = 11

local selectorLayout = Instance.new("UIListLayout")
selectorLayout.Parent = SelectorScrollingList
selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
selectorLayout.Padding = UDim.new(0, 8)

for idx, profileData in ipairs(VelocityMatrixRegistry) do
    local profileSelectionButton = constructInteractiveButton(SelectorScrollingList, profileData.Identifier, Color3.fromRGB(17, 24, 39))
    profileSelectionButton.ZIndex = 11
    profileSelectionButton.MouseButton1Click:Connect(function()
        activeProfilePointer = idx
        ModeSelectorTriggerButton.Text = "โปรไฟล์: " .. profileData.Identifier
        ProfileDetailsDisplayBox.Text = string.format("  หน่วงเวลา: %.5fs | ความแม่นยำ: %s | ความเสี่ยง: %s", profileData.DelayDuration, profileData.PrecisionRate, profileData.KernelRisk)
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
StatsWidget.Position = UDim2.new(0.82, 0, 0.15, 0)
StatsWidget.Size = UDim2.new(0, 160, 0, 36)
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
-- 10. ปุ่มลอยและโหมดซ่อนตัว
----------------------------------------------------------------------------------------------------
local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "MeridianSquareFloatingWidget"
SmallSquareFloatingWidget.Parent = RootContainerNode
SmallSquareFloatingWidget.BackgroundColor3 = Color3.fromRGB(13, 148, 136)
SmallSquareFloatingWidget.Position = UDim2.new(0.85, 0, 0.4, 0)
SmallSquareFloatingWidget.Size = UDim2.new(0, 55, 0, 55)
SmallSquareFloatingWidget.Font = Enum.Font.Code
SmallSquareFloatingWidget.Text = "EXEC"
SmallSquareFloatingWidget.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.TextSize = 11
SmallSquareFloatingWidget.Visible = false
SmallSquareFloatingWidget.Active = true
SmallSquareFloatingWidget.Draggable = true
SmallSquareFloatingWidget.ZIndex = 8

local widgetCorner = Instance.new("UICorner")
widgetCorner.CornerRadius = UDim.new(0, 10)
widgetCorner.Parent = SmallSquareFloatingWidget

local widgetStroke = Instance.new("UIStroke")
widgetStroke.Color = Color3.fromRGB(255, 255, 255)
widgetStroke.Transparency = 0.4
widgetStroke.Thickness = 1.5
widgetStroke.Parent = SmallSquareFloatingWidget

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
GhostWidget.Position = UDim2.new(0.05, 0, 0.15, 0)
GhostWidget.Size = UDim2.new(0, 50, 0, 50)
GhostWidget.Font = Enum.Font.Code
GhostWidget.Text = "⚡"
GhostWidget.TextSize = 20
GhostWidget.Visible = false
GhostWidget.Active = true
GhostWidget.Draggable = true
GhostWidget.ZIndex = 8

local ghostCorner = Instance.new("UICorner")
ghostCorner.CornerRadius = UDim.new(1, 0)
ghostCorner.Parent = GhostWidget

local ghostStroke = Instance.new("UIStroke")
ghostStroke.Color = Color3.fromRGB(45, 212, 191)
ghostStroke.Thickness = 2
ghostStroke.Parent = GhostWidget

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
    
    task.wait(0.003)
    local passBeta = executeAdvancedDiagnosticParsing()
    if not passBeta or passAlpha ~= passBeta then return nil end
    
    task.wait(0.003)
    local passGamma = executeAdvancedDiagnosticParsing()
    if not passGamma or passBeta ~= passGamma then return nil end
    
    return passGamma
end

----------------------------------------------------------------------------------------------------
-- 12. ระบบสตรีมการส่งคำสั่งและระบบรีเซ็ตแก้บั๊กฉุกเฉิน
----------------------------------------------------------------------------------------------------
local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: กำลังประมวลผลโครงสร้าง [" .. activeProfile.Identifier .. "]"
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
                    task.wait(activeProfile.DelayDuration)
                end
            end)
            if idx % 6 == 0 then
                task.wait(0.001)
            end
        end
        
        SystemTelemetryDisplayBox.Text = "  [สถานะ]: แก้รูบิคโครงสร้างสำเร็จ 100%"
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
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: รีเซ็ตระบบสำเร็จ เคลียร์บั๊กเรียบร้อย"
    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(248, 113, 113)
end)

----------------------------------------------------------------------------------------------------
-- 13. ระบบสแกนพื้นหลังตลอดเวลา
----------------------------------------------------------------------------------------------------
task.spawn(function()
    local lastRegisteredSequence = ""
    while task.wait(0.12) do
        if isBackgroundScannerActive and not coreExecutionFlag then
            pcall(function()
                local parsedTokenResult = verifySequenceIntegrityTriplePass()
                if parsedTokenResult and parsedTokenResult ~= lastRegisteredSequence then
                    lastRegisteredSequence = parsedTokenResult
                    sequenceMemoryBuffer = parsedTokenResult
                    SequenceInputField.Text = sequenceMemoryBuffer
                    SystemTelemetryDisplayBox.Text = "  [สถานะ]: ตรวจพบโหนดโครงสร้างใหม่ (" .. #sequenceMemoryBuffer + 0 .. " จุด)"
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
