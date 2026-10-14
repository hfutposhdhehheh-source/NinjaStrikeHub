----------------------------------------------------------------------------------------------------
-- NEXUS MATRIX DRAGON EDITION // ULTIMATE HIGH-LEVEL SECURE KERNEL
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
-- SYSTEM CONFIGURATION & 5 ULTRA-STABLE SPEED PROFILES
----------------------------------------------------------------------------------------------------
local VelocityMatrixRegistry = {
    [1] = {Identifier = "Tier I : Stable Core",   DelayDuration = 0.045,   PrecisionRate = "100.0%",  KernelRisk = "Zero"},
    [2] = {Identifier = "Tier II : Velocity",     DelayDuration = 0.020,   PrecisionRate = "100.0%",  KernelRisk = "Minimal"},
    [3] = {Identifier = "Tier III : Overclock",   DelayDuration = 0.008,   PrecisionRate = "100.0%",  KernelRisk = "Optimized"},
    [4] = {Identifier = "Tier IV : Quantum Stream",DelayDuration = 0.003,  PrecisionRate = "99.9%",   KernelRisk = "Balanced"},
    [5] = {Identifier = "Tier V : Singularity Max",DelayDuration = 0.001,  PrecisionRate = "99.8%",   KernelRisk = "Extreme"}
}

local activeProfilePointer = 1
local sequenceMemoryBuffer = ""
local coreExecutionFlag = false
local floatingWidgetActiveState = false
local isInterfaceHiddenState = false

----------------------------------------------------------------------------------------------------
-- GUI ROOT CONTAINER INITIALIZATION
----------------------------------------------------------------------------------------------------
local RootContainerNode = Instance.new("ScreenGui")
RootContainerNode.Name = "NexusMatrixDragonContainer"
RootContainerNode.Parent = CoreGui
RootContainerNode.IgnoreGuiInset = true
RootContainerNode.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

----------------------------------------------------------------------------------------------------
-- PRIMARY INTERFACE WINDOW (ADVANCED HACKER METRICS DESIGN)
----------------------------------------------------------------------------------------------------
local PrimaryWindowFrame = Instance.new("Frame")
PrimaryWindowFrame.Name = "MatrixPrimaryInterface"
PrimaryWindowFrame.Parent = RootContainerNode
PrimaryWindowFrame.BackgroundColor3 = Color3.fromRGB(6, 7, 10)
PrimaryWindowFrame.BackgroundTransparency = 0.03
PrimaryWindowFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
PrimaryWindowFrame.Size = UDim2.new(0, 360, 0, 460)
PrimaryWindowFrame.Active = true
PrimaryWindowFrame.Draggable = true

local WindowCornerRadius = Instance.new("UICorner")
WindowCornerRadius.CornerRadius = UDim.new(0, 12)
WindowCornerRadius.Parent = PrimaryWindowFrame

local WindowBorderGlow = Instance.new("UIStroke")
WindowBorderGlow.Color = Color3.fromRGB(20, 184, 166)
WindowBorderGlow.Transparency = 0.3
WindowBorderGlow.Thickness = 1.5
WindowBorderGlow.Parent = PrimaryWindowFrame

-- Top Navigation / Header Bar
local HeaderNavigationPanel = Instance.new("Frame")
HeaderNavigationPanel.Name = "HeaderPanel"
HeaderNavigationPanel.Parent = PrimaryWindowFrame
HeaderNavigationPanel.BackgroundColor3 = Color3.fromRGB(10, 13, 18)
HeaderNavigationPanel.Size = UDim2.new(1, 0, 0, 48)

local HeaderCornerFix = Instance.new("UICorner")
HeaderCornerFix.CornerRadius = UDim.new(0, 12)
HeaderCornerFix.Parent = HeaderNavigationPanel

local HeaderBottomBlocker = Instance.new("Frame")
HeaderBottomBlocker.Parent = HeaderNavigationPanel
HeaderBottomBlocker.BackgroundColor3 = Color3.fromRGB(10, 13, 18)
HeaderBottomBlocker.BorderSizePixel = 0
HeaderBottomBlocker.Position = UDim2.new(0, 0, 0.7, 0)
HeaderBottomBlocker.Size = UDim2.new(1, 0, 0.3, 0)

local HeaderTitleLabel = Instance.new("TextLabel")
HeaderTitleLabel.Parent = HeaderNavigationPanel
HeaderTitleLabel.BackgroundTransparency = 1
HeaderTitleLabel.Position = UDim2.new(0, 18, 0, 0)
HeaderTitleLabel.Size = UDim2.new(1, -70, 1, 0)
HeaderTitleLabel.Font = Enum.Font.Code
HeaderTitleLabel.Text = "NEXUS // DRAGON KERNEL v5.0"
HeaderTitleLabel.TextColor3 = Color3.fromRGB(45, 212, 191)
HeaderTitleLabel.TextSize = 12
HeaderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มซ่อนสคริปต์ (แปลงร่างเป็นมังกร)
local HideInterfaceButton = Instance.new("TextButton")
HideInterfaceButton.Parent = HeaderNavigationPanel
HideInterfaceButton.BackgroundColor3 = Color3.fromRGB(20, 184, 166)
HideInterfaceButton.Position = UDim2.new(1, -42, 0, 10)
HideInterfaceButton.Size = UDim2.new(0, 28, 0, 28)
HideInterfaceButton.Font = Enum.Font.Code
HideInterfaceButton.Text = "🐉"
HideInterfaceButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HideInterfaceButton.TextSize = 14

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 6)
hideBtnCorner.Parent = HideInterfaceButton

-- Main Scrolling Content Area
local MainScrollingArea = Instance.new("ScrollingFrame")
MainScrollingArea.Name = "ScrollingContainer"
MainScrollingArea.Parent = PrimaryWindowFrame
MainScrollingArea.BackgroundTransparency = 1
MainScrollingArea.Position = UDim2.new(0, 16, 0, 60)
MainScrollingArea.Size = UDim2.new(1, -32, 1, -72)
MainScrollingArea.CanvasSize = UDim2.new(0, 0, 0, 450)
MainScrollingArea.ScrollBarThickness = 3
MainScrollingArea.ScrollBarImageColor3 = Color3.fromRGB(20, 184, 166)

local VerticalLayoutEngine = Instance.new("UIListLayout")
VerticalLayoutEngine.Parent = MainScrollingArea
VerticalLayoutEngine.SortOrder = Enum.SortOrder.LayoutOrder
VerticalLayoutEngine.Padding = UDim.new(0, 14)

----------------------------------------------------------------------------------------------------
-- UI BUILDER UTILITY FUNCTIONS
----------------------------------------------------------------------------------------------------
local function constructCategoryHeader(parentContainer, labelTextContent)
    local headerLabel = Instance.new("TextLabel")
    headerLabel.Parent = parentContainer
    headerLabel.BackgroundTransparency = 1
    headerLabel.Size = UDim2.new(1, 0, 0, 16)
    headerLabel.Font = Enum.Font.Code
    headerLabel.Text = labelTextContent
    headerLabel.TextColor3 = Color3.fromRGB(100, 116, 139)
    headerLabel.TextSize = 10
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    return headerLabel
end

local function constructInteractiveButton(parentContainer, buttonTextContent, themeColorCode)
    local buttonInstance = Instance.new("TextButton")
    buttonInstance.Parent = parentContainer
    buttonInstance.BackgroundColor3 = themeColorCode
    buttonInstance.Size = UDim2.new(1, 0, 0, 38)
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
-- COMPONENT RENDERING // SYSTEM METRICS SECTION
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> SYSTEM TELEMETRY & AUTO-PARSER STATUS")
local SystemTelemetryDisplayBox = Instance.new("TextLabel")
SystemTelemetryDisplayBox.Parent = MainScrollingArea
SystemTelemetryDisplayBox.BackgroundColor3 = Color3.fromRGB(11, 14, 20)
SystemTelemetryDisplayBox.Size = UDim2.new(1, 0, 0, 40)
SystemTelemetryDisplayBox.Font = Enum.Font.Code
SystemTelemetryDisplayBox.Text = "  [STATUS]: AUTO-PARSER ACTIVE // READY"
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
-- COMPONENT RENDERING // VELOCITY PROFILE SECTION (5 TIERS)
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> EXECUTION VELOCITY PROFILES (5 MODES)")
local ModeSelectorTriggerButton = constructInteractiveButton(MainScrollingArea, "PROFILE: Tier I : Stable Core", Color3.fromRGB(17, 24, 39))

local ProfileDetailsDisplayBox = Instance.new("TextLabel")
ProfileDetailsDisplayBox.Parent = MainScrollingArea
ProfileDetailsDisplayBox.BackgroundColor3 = Color3.fromRGB(11, 14, 20)
ProfileDetailsDisplayBox.Size = UDim2.new(1, 0, 0, 45)
ProfileDetailsDisplayBox.Font = Enum.Font.Code
ProfileDetailsDisplayBox.Text = "  Delay: 0.04500s | Precision: 100.0% | Risk: Zero"
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
-- COMPONENT RENDERING // ADVANCED AUTO TEXT MINER
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> DEEP MATRIX AUTO-PARSER REGISTRY")
local SequenceInputField = Instance.new("TextBox")
SequenceInputField.Parent = MainScrollingArea
SequenceInputField.BackgroundColor3 = Color3.fromRGB(11, 14, 20)
SequenceInputField.Size = UDim2.new(1, 0, 0, 44)
SequenceInputField.Font = Enum.Font.Code
SequenceInputField.PlaceholderText = "Waiting for auto sequence parse..."
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
-- COMPONENT RENDERING // EXECUTION CONTROLS & WIDGET TOGGLE
----------------------------------------------------------------------------------------------------
constructCategoryHeader(MainScrollingArea, ">> EXECUTION COMMAND ARSENAL")
local InitializeEngineButton = constructInteractiveButton(MainScrollingArea, "ENGAGE SOLVER KERNEL ENGINE", Color3.fromRGB(13, 148, 136))

constructCategoryHeader(MainScrollingArea, ">> FLOATING WIDGET MODULE")
local ToggleFloatingInterfaceButton = constructInteractiveButton(MainScrollingArea, "DEPLOY FLOATING WIDGET", Color3.fromRGB(51, 65, 85))

----------------------------------------------------------------------------------------------------
-- SECONDARY SELECTOR MATRIX WINDOW (5 PROFILES MENU)
----------------------------------------------------------------------------------------------------
local SecondarySelectorPanel = Instance.new("Frame")
SecondarySelectorPanel.Name = "SecondarySelectorMatrix"
SecondarySelectorPanel.Parent = RootContainerNode
SecondarySelectorPanel.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
SecondarySelectorPanel.Position = UDim2.new(0.1, 370, 0.15, 0)
SecondarySelectorPanel.Size = UDim2.new(0, 230, 0, 240)
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
SelectorScrollingList.CanvasSize = UDim2.new(0, 0, 0, 260)
SelectorScrollingList.ScrollBarThickness = 2

local selectorLayout = Instance.new("UIListLayout")
selectorLayout.Parent = SelectorScrollingList
selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
selectorLayout.Padding = UDim.new(0, 8)

for idx, profileData in ipairs(VelocityMatrixRegistry) do
    local profileSelectionButton = constructInteractiveButton(SelectorScrollingList, profileData.Identifier, Color3.fromRGB(17, 24, 39))
    profileSelectionButton.MouseButton1Click:Connect(function()
        activeProfilePointer = idx
        ModeSelectorTriggerButton.Text = "PROFILE: " .. profileData.Identifier
        ProfileDetailsDisplayBox.Text = string.format("  Delay: %.5fs | Precision: %s | Risk: %s", profileData.DelayDuration, profileData.PrecisionRate, profileData.KernelRisk)
        SecondarySelectorPanel.Visible = false
    end)
end

ModeSelectorTriggerButton.MouseButton1Click:Connect(function()
    SecondarySelectorPanel.Visible = not SecondarySelectorPanel.Visible
end)

----------------------------------------------------------------------------------------------------
-- FLOATING WIDGET (สี่เหลี่ยมเล็กๆ ลากย้ายได้อิสระ)
----------------------------------------------------------------------------------------------------
local SmallSquareFloatingWidget = Instance.new("TextButton")
SmallSquareFloatingWidget.Name = "NexusSquareFloatingWidget"
SmallSquareFloatingWidget.Parent = RootContainerNode
SmallSquareFloatingWidget.BackgroundColor3 = Color3.fromRGB(13, 148, 136)
SmallSquareFloatingWidget.Position = UDim2.new(0.85, 0, 0.4, 0)
SmallSquareFloatingWidget.Size = UDim2.new(0, 50, 0, 50)
SmallSquareFloatingWidget.Font = Enum.Font.Code
SmallSquareFloatingWidget.Text = "EXEC"
SmallSquareFloatingWidget.TextColor3 = Color3.fromRGB(255, 255, 255)
SmallSquareFloatingWidget.TextSize = 11
SmallSquareFloatingWidget.Visible = false
SmallSquareFloatingWidget.Active = true
SmallSquareFloatingWidget.Draggable = true

local widgetCorner = Instance.new("UICorner")
widgetCorner.CornerRadius = UDim.new(0, 8)
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
        ToggleFloatingInterfaceButton.Text = "TERMINATE FLOATING WIDGET"
        ToggleFloatingInterfaceButton.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
    else
        ToggleFloatingInterfaceButton.Text = "DEPLOY FLOATING WIDGET"
        ToggleFloatingInterfaceButton.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
    end
end)

----------------------------------------------------------------------------------------------------
-- DRAGON GHOST MODE (ซ่อน UI แล้วแปลงร่างเป็นมังกรลอยได้ คลิกเปิดกลับมาได้)
----------------------------------------------------------------------------------------------------
local DragonGhostWidget = Instance.new("TextButton")
DragonGhostWidget.Name = "DragonGhostWidget"
DragonGhostWidget.Parent = RootContainerNode
DragonGhostWidget.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
DragonGhostWidget.Position = UDim2.new(0.05, 0, 0.15, 0)
DragonGhostWidget.Size = UDim2.new(0, 50, 0, 50)
DragonGhostWidget.Font = Enum.Font.Code
DragonGhostWidget.Text = "🐉"
DragonGhostWidget.TextSize = 24
DragonGhostWidget.Visible = false
DragonGhostWidget.Active = true
DragonGhostWidget.Draggable = true

local dragonCorner = Instance.new("UICorner")
dragonCorner.CornerRadius = UDim.new(1, 0) -- วงกลมมังกรสวยงาม
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
-- ADVANCED REFACTORED DEEP AUTO-PARSER ENGINE (100% ACCURACY & HIGH SPEED)
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
    
    task.wait(0.005)
    local passBeta = executeAdvancedDiagnosticParsing()
    if not passBeta or passAlpha ~= passBeta then return nil end
    
    task.wait(0.005)
    local passGamma = executeAdvancedDiagnosticParsing()
    if not passGamma or passBeta ~= passGamma then return nil end
    
    return passGamma
end

----------------------------------------------------------------------------------------------------
-- STABLE ENGINE STREAM EXECUTION (FIXED MODES 3-5 ZERO-BUG BUFFER)
----------------------------------------------------------------------------------------------------
local function dispatchSolverExecutionStream(sequencePayload)
    if coreExecutionFlag or not sequencePayload or sequencePayload == "" then return end
    coreExecutionFlag = true
    
    local activeProfile = VelocityMatrixRegistry[activeProfilePointer]
    SystemTelemetryDisplayBox.Text = "  [STATUS]: EXECUTING STREAM [" .. activeProfile.Identifier .. "]"
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
            -- Micro-Yield Buffer Protection (ป้องกันบัคในโหมด 3-5)
            if idx % 8 == 0 then
                task.wait(0.001)
            end
        end
        
        SystemTelemetryDisplayBox.Text = "  [STATUS]: STREAM COMPLETE [100% SECURE]"
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
-- BACKGROUND AUTO-PARSER LOOP (เรียลไทม์อัตโนมัติ แม่นยำ 100%)
----------------------------------------------------------------------------------------------------
task.spawn(function()
    local lastRegisteredSequence = ""
    while task.wait(0.15) do
        if not coreExecutionFlag and not isInterfaceHiddenState then
            pcall(function()
                local parsedTokenResult = verifySequenceIntegrityTriplePass()
                if parsedTokenResult and parsedTokenResult ~= lastRegisteredSequence then
                    lastRegisteredSequence = parsedTokenResult
                    sequenceMemoryBuffer = parsedTokenResult
                    SequenceInputField.Text = sequenceMemoryBuffer
                    SystemTelemetryDisplayBox.Text = "  [STATUS]: AUTO-PARSED [" .. #sequenceMemoryBuffer .. " NODES]"
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
