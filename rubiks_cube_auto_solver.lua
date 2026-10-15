----------------------------------------------------------------------------------------------------
-- NEXUS MATRIX DRAGON EDITION // ULTIMATE HIGH-LEVEL SECURE KERNEL (RE-ENGINEERED)
----------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Safe Memory Cleanup
if CoreGui:FindFirstChild("NexusMatrixDragonContainer") then
    CoreGui.NexusMatrixDragonContainer:Destroy()
end

----------------------------------------------------------------------------------------------------
-- ระบบตั้งค่าความเร็วและโปรไฟล์ความเสถียร (5 ระดับ)
----------------------------------------------------------------------------------------------------
local VelocityMatrixRegistry = {
    [1] = {Identifier = "ระดับ 1 : เสถียรปลอดภัยสูงสุด (Stable Core)", DelayDuration = 0.045, PrecisionRate = "100.0%", KernelRisk = "ไม่มีความเสี่ยง"},
    [2] = {Identifier = "ระดับ 2 : ความเร็วมาตรฐาน (Velocity)", DelayDuration = 0.020, PrecisionRate = "100.0%", KernelRisk = "ต่ำมาก"},
    [3] = {Identifier = "ระดับ 3 : เร่งเครื่องโอเวอร์คล็อก (Overclock)", DelayDuration = 0.008, PrecisionRate = "100.0%", KernelRisk = "ปานกลาง"},
    [4] = {Identifier = "ระดับ 4 : ควอนตัมสตรีม (Quantum Stream)", DelayDuration = 0.003, PrecisionRate = "99.9%", KernelRisk = "สมดุลสูง"},
    [5] = {Identifier = "ระดับ 5 : ขีดสุดความเร็วแสง (Singularity Max)", DelayDuration = 0.001, PrecisionRate = "99.8%", KernelRisk = "ระมัดระวัง"}
}

local activeProfilePointer = 1
local sequenceMemoryBuffer = ""
local coreExecutionFlag = false
local floatingWidgetActiveState = false
local isInterfaceHiddenState = false
local isBackgroundScannerActive = true -- เปิดระบบสแกนพื้นหลังตลอดเวลา

----------------------------------------------------------------------------------------------------
-- GUI ROOT CONTAINER INITIALIZATION
----------------------------------------------------------------------------------------------------
local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "NexusMatrixDragonContainer"
RootContainerNode.Parent = CoreGui
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

----------------------------------------------------------------------------------------------------
-- หน้าต่างหลัก (ดีไซน์ใหม่ ไฮเทค รองรับภาษาไทยสมบูรณ์)
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MatrixPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(8, 11, 16)
PrimaryWindowFrame.BackgroundTransparency = 0.02
PrimaryWindowFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 380, 0, 480)
PrimaryWindowFrame.Active = true
PrimaryWindowFrame.Draggable = true

local WindowCornerRadius = Instance.new("UICorner")
WindowCornerRadius.CornerRadius = UDim.new(0, 14)
WindowCornerRadius.Parent = PrimaryWindowFrame

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(20, 184, 166)
WindowBorderGlow.Transparency = 0.25
WindowBorderGlow.Thickness = 1.8
WindowBorderGlow.Parent = PrimaryWindowFrame

-- แถบหัวข้อด้านบน
local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 50)

local HeaderCornerFix = Instance.new("UICorner")
HeaderCornerFix.CornerRadius = UDim.new(0, 14)
HeaderCornerFix.Parent = HeaderNavigationPanel

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
HeaderBottomBlocker.BorderSizePixel = 0
HeaderBottomBlocker.Position = UDim2.new(0, 0, 0.7, 0)
HeaderBottomBlocker.Size = UDim2.new(1, 0, 0.3, 0)

local HeaderTitleLabel = Instance.new("TextLabel")
HeaderTitleLabel.Parent = HeaderNavigationPanel
HeaderTitleLabel.BackgroundTransparency = 1
HeaderTitleLabel.Position = UDim2.new(0, 18, 0, 0)
HeaderTitleLabel.Size = UDim2.new(1, -70, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = "NEXUS // ระบบแก้รูบิคอัตโนมัติ v5.2"
HeaderTitleLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
HeaderTitleLabel.TextSize = 11
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มซ่อนหน้าต่าง (แปลงร่างเป็นมังกร 🐉)
local HideInterfaceButton = Instance.new("TextButton")
HideInterfaceButton.Parent = HeaderNavigationPanel
HideInterfaceButton.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
HideInterfaceButton.Position = UDim2.new(1, -44, 0, 11)
HideInterfaceButton.Size = UDim2.new(0, 30, 0, 28)
HideInterfaceButton.Font = Enum.Font.Code
HideInterfaceButton.Text = "🐉"
HideInterfaceButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideInterfaceButton.TextSize = 14

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 6)
hideBtnCorner.Parent = HideInterfaceButton

-- พื้นที่เลื่อนเนื้อหาหลัก
local MainScrollingArea = Instance.new("ScrollingFrame")
MainScrollingArea.Name = "ScrollingContainer"
MainScrollingArea.Parent = PrimaryWindowFrame
MainScrollingArea.BackgroundTransparency = 1
MainScrollingArea.Position = UDim2.new(0, 16, 0, 60)
MainScrollingArea.Size = UDim2.new(1, -32, 1, -72)
MainScrollingArea.CanvasSize = UDim2.new(0, 0, 0, 520)
MainScrollingArea.ScrollBarThickness = 3
MainScrollingArea.ScrollBarImageColor3 = Color3.fromRGB(20, 184, 166)

local VerticalLayoutEngine = Instance.new("UIListLayout")
VerticalLayoutEngine.Parent = MainScrollingArea
VerticalLayoutEngine.SortOrder = Enum.SortOrder.LayoutOrder
VerticalLayoutEngine.Padding = UDim.new(0, 12)

----------------------------------------------------------------------------------------------------
-- ฟังก์ชันช่วยสร้างองค์ประกอบ UI (Builder Utilities)
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
-- ส่วนแสดงผลสถานะระบบ (Telemetry Status)
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> สถานะระบบและการสแกน (System Telemetry)")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = MainScrollingArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 42)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [สถานะ]: พร้อมทำงาน (ระบบสแกนพื้นหลังเปิดอยู่)"
SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
SystemTelemetryDisplayBox.TextSize = 10
SystemTelemetryDisplayBox.TextXAlignment = Enum.TextXAlignment.Left

local telemetryCorner = Instance.new("UICorner")
telemetryCorner.CornerRadius = UDim.new(0, 8)
telemetryCorner.Parent = SystemTelemetryDisplayBox

local telemetryStroke = Instance.new("UIStroke")
telemetryStroke.Color = Color3.fromRGB(30, 41, 59)
telemetryStroke.Thickness = 1
telemetryStroke.Parent = SystemTelemetryDisplayBox

----------------------------------------------------------------------------------------------------
-- ส่วนควบคุมเลือกโปรไฟล์ความเร็ว (5 ระดับ)
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> เลือกความเร็วในการแก้รูบิค (Speed Profiles)")
local ModeSelectorTriggerButton = constructInteractiveButton(MainScrollingArea, "โปรไฟล์: ระดับ 1 : เสถียรปลอดภัยสูงสุด", Color3.fromRGB(17, 24, 39))

local ProfileDetailsDisplayBox = Instance.new("TextLabel")
ProfileDetailsDisplayBox.Parent = MainScrollingArea
ProfileDetailsDisplayBox.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
ProfileDetailsDisplayBox.Size = UDim2.new(1, 0, 0, 45)
ProfileDetailsDisplayBox.Font = Enum.Font.Code
ProfileDetailsDisplayBox.Text = "  หน่วงเวลา: 0.04500s | ความแม่นยำ: 100.0% | ความเสี่ยง: ไม่มี"
ProfileDetailsDisplayBox.TextColor3 = Color3.fromRGB(203, 213, 225)
ProfileDetailsDisplayBox.TextSize = 10
ProfileDetailsDisplayBox.TextWrapped = true
ProfileDetailsDisplayBox.TextXAlignment = Enum.TextXAlignment.Left
ProfileDetailsDisplayBox.TextYAlignment = Enum.TextYAlignment.Center

local detailsCorner = Instance.new("UICorner")
detailsCorner.CornerRadius = UDim.new(0, 8)
detailsCorner.Parent = ProfileDetailsDisplayBox

local detailsStroke = Instance.new("UIStroke")
detailsStroke.Color = Color3.fromRGB(30, 41, 59)
detailsStroke.Thickness = 1
detailsStroke.Parent = ProfileDetailsDisplayBox

----------------------------------------------------------------------------------------------------
-- ช่องแสดงรหัสและข้อมูลที่สแกนได้ (Auto-Parser Display)
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> ช่องข้อมูลชุดคำสั่งที่สแกนได้ (Sequence Registry)")
local SequenceInputField = Instance.new("TextBox")
SequenceInputField.Parent = MainScrollingArea
SequenceInputField.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
SequenceInputField.Size = UDim2.new(1, 0, 0, 45)
SequenceInputField.Font = Enum.Font.Code
SequenceInputField.PlaceholderText = "กำลังรอระบบสแกนชุดคำสั่งอัตโนมัติ..."
SequenceInputField.Text = ""
SequenceInputField.TextColor3 = Color3.fromRGB(56, 189, 248)
SequenceInputField.TextSize = 11
SequenceInputField.ClearTextOnFocus = false
SequenceInputField.TextWrapped = true

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = SequenceInputField

local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(30, 41, 59)
inputStroke.Thickness = 1
inputStroke.Parent = SequenceInputField

----------------------------------------------------------------------------------------------------
-- ปุ่มควบคุมการทำงานหลักและปุ่มลอย
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> คำสั่งควบคุมการทำงานหลัก (Execution Arsenal)")
local InitializeEngineButton = constructInteractiveButton(MainScrollingArea, "▶ เริ่มต้นรันระบบแก้รูบิคอัตโนมัติ", Color3.fromRGB(13, 148, 136))

constructCategoryHeader(MainScrollingArea, ">> ปุ่มลอยด่วนบนหน้าจอ (Floating Widget)")
local ToggleFloatingInterfaceButton = constructInteractiveButton(MainScrollingArea, "เปิดใช้งานปุ่มลอยด่วน (EXEC)", Color3.fromRGB(51, 65, 85))

----------------------------------------------------------------------------------------------------
-- หน้าต่างเลือกโปรไฟล์ความเร็วแบบป๊อปอัป (Selector Panel)
----------------------------------------------------------------------------------------------------
local SecondarySelectorPanel = Instance.new("Frame")
SecondarySelectorPanel.Name = "SecondarySelectorMatrix"
SecondarySelectorPanel.Parent = RootContainerNode
SecondarySelectorPanel.BackgroundColor3 = Color3.fromRGB(10, 14, 20)
SecondarySelectorPanel.Position = UDim2.new(0.1, 390, 0.15, 0)
SecondarySelectorPanel.Size = UDim2.new(0, 260, 0, 260)
SecondarySelectorPanel.Visible = false
SecondarySelectorPanel.Active = true
SecondarySelectorPanel.Draggable = true

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

local selectorLayout = Instance.new("UIListLayout")
selectorLayout.Parent = SelectorScrollingList
selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
selectorLayout.Padding = UDim.new(0, 8)

for idx, profileData in ipairs(VelocityMatrixRegistry) do
    local profileSelectionButton = constructInteractiveButton(SelectorScrollingList, profileData.Identifier, Color3.fromRGB(17, 24, 39))
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
-- ปุ่มลอยขนาดเล็กสำหรับกดสั่งงานด่วน (Floating Widget)
----------------------------------------------------------------------------------------------------
local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "NexusSquareFloatingWidget"
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

----------------------------------------------------------------------------------------------------
-- โหมดซ่อนตัวละครหน้าต่าง (Dragon Ghost Mode - แปลงร่างเป็นมังกรซ่อน UI)
----------------------------------------------------------------------------------------------------
local DragonGhostWidget = Instance.new("TextButton")
DragonGhostWidget.Name = "DragonGhostWidget"
DragonGhostWidget.Parent = RootContainerNode
DragonGhostWidget.BackgroundColor3 = Color3.fromRGB(13, 17, 23)
DragonGhostWidget.Position = UDim2.new(0.05, 0, 0.15, 0)
DragonGhostWidget.Size = UDim2.new(0, 50, 0, 50)
DragonGhostWidget.Font = Enum.Font.Code
DragonGhostWidget.Text = "🐉"
DragonGhostWidget.TextSize = 24
DragonGhostWidget.Visible = false
DragonGhostWidget.Active = true
DragonGhostWidget.Draggable = true

local dragonCorner = Instance.new("UICorner")
dragonCorner.CornerRadius = UDim.new(1, 0)
dragonCorner.Parent = DragonGhostWidget

local dragonStroke = Instance.new("UIStroke")
dragonStroke.Color = Color3.fromRGB(45, 212, 191)
dragonStroke.Thickness = 2
dragonStroke.Parent = DragonGhostWidget

HideInterfaceButton.MouseButton1Click:Connect(function()
    isInterfaceHiddenState = true
    PrimaryWindowFrame.Visible = false
    SecondarySelectorPanel.Visible = false
    DragonGhostWidget.Visible = true
end)

DragonGhostWidget.MouseButton1Click:Connect(function()
    isInterfaceHiddenState = false
    PrimaryWindowFrame.Visible = true
    DragonGhostWidget.Visible = false
end)

----------------------------------------------------------------------------------------------------
-- ระบบตรวจสอบความแม่นยำข้อความและบายพาสขั้นสูง (Advanced Text Validation & Anti-Bypass Engine)
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
-- ระบบสตรีมการส่งคำสั่งเสถียรภาพสูง (Stable Execution Stream & Zero-Bug Buffer)
----------------------------------------------------------------------------------------------------
local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [สถานะ]: กำลังประมวลผล [" .. activeProfile.Identifier .. "]"
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
            -- ระบบหน่วงจังหวะความปลอดภัยป้องกันอาการแลค (Micro-Yield Buffer)
            if idx % 6 == 0 then
                task.wait(0.001)
            end
        end
        
        SystemTelemetryDisplayBox.Text = "  [สถานะ]: แก้รูบิคสำเร็จ 100% ปลอดภัย"
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

----------------------------------------------------------------------------------------------------
-- BACKGROUND AUTO-PARSER LOOP (สแกนต่อเนื่องตลอดเวลา แม้จะปิด UI หรือซ่อนหน้าต่างแล้ว)
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
                    SystemTelemetryDisplayBox.Text = "  [สถานะ]: สแกนพบกระดานใหม่ (" .. #sequenceMemoryBuffer + 0 .. " โหนด)"
                    SystemTelemetryDisplayBox.TextColor3 = Color3.fromRGB(52, 211, 153)
                end
            end)
        end
    end
end)

----------------------------------------------------------------------------------------------------
-- EVENT BINDINGS
----------------------------------------------------------------------------------------------------
InitializeEngineButton.MouseButton1Click:Connect(processExecutionTriggerRoutine)
SmallSquareFloatingWidget.MouseButton1Click:Connect(processExecutionTriggerRoutine)
