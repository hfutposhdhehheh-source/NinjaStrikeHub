--[[
    ╔══════════════════════════════════════════════════════╗
       MERIDIAN V2.5 [EXTREME] - OFFICIAL RELEASE
       Developed by: Meridian_Tle
       TikTok: @meridian_tle
       "ของดีต้องของเฮีย"
    ╚══════════════════════════════════════════════════════╝
]]

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- ลบของเก่าถ้ามีการรันซ้ำ
if CoreGui:FindFirstChild("MeridianTikTok") then
    CoreGui.MeridianTikTok:Destroy()
end

-- ระบบแจ้งเตือนต้อนรับ (Splash Notification)
StarterGui:SetCore("SendNotification", {
	Title = "Meridian_Tle",
	Text = "ของดีต้องของเฮีย! กำลังโหลด...",
	Duration = 4
})

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local FrameCorner = Instance.new("UICorner")
local Header = Instance.new("Frame")
local HeaderCorner = Instance.new("UICorner")
local HeaderGradient = Instance.new("UIGradient")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local ToggleBtn = Instance.new("TextButton")
local ToggleCorner = Instance.new("UICorner")
local ToggleStroke = Instance.new("UIStroke")

-- Setup GUI Core
ScreenGui.Name = "MeridianTikTok"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- [[ ปุ่มเปิด/ปิด - วงกลมนีออน ]]
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -15)
ToggleBtn.Size = UDim2.new(0, 35, 0, 35)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16

ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

ToggleStroke.Color = Color3.fromRGB(255, 100, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- [[ หน้าจอหลัก - Modern Dark ]]
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -200)
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.BorderSizePixel = 0

FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

-- [[ หัวข้อ - Gradient Style ]]
Header.Name = "Header"
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.BorderSizePixel = 0

HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 150))
}
HeaderGradient.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Parent = Header
HeaderFix.Size = UDim2.new(1, 0, 0, 10)
HeaderFix.Position = UDim2.new(0, 0, 1, -10)
HeaderFix.BackgroundColor3 = Color3.fromRGB(100, 50, 255)
HeaderFix.BorderSizePixel = 0
local FixGradient = HeaderGradient:Clone()
FixGradient.Parent = HeaderFix

Title.Name = "Title"
Title.Parent = Header
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "MERIDIAN BY TLE" 
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.ZIndex = 2

-- [[ ส่วนรายการฟังก์ชั่น ]]
ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 2
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 255)

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UIPadding.Parent = ScrollFrame
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 10)
UIPadding.PaddingBottom = UDim.new(0, 10)

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    local targetColor = MainFrame.Visible and Color3.fromRGB(255, 100, 255) or Color3.fromRGB(150, 150, 150)
    TweenService:Create(ToggleBtn, TweenInfo.new(0.3), {TextColor3 = targetColor}):Play()
    TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {Color = targetColor}):Play()
end)

local function CreateButton(name, desc, callback)
    local ButtonFrame = Instance.new("Frame")
    local BtnCorner = Instance.new("UICorner")
    local BtnStroke = Instance.new("UIStroke")
    local TextBtn = Instance.new("TextButton")
    local DescLabel = Instance.new("TextLabel")

    ButtonFrame.Name = name .. "_Frame"
    ButtonFrame.Parent = ScrollFrame
    ButtonFrame.Size = UDim2.new(1, 0, 0, 50)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = ButtonFrame
    
    BtnStroke.Color = Color3.fromRGB(40, 40, 50)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = ButtonFrame

    TextBtn.Parent = ButtonFrame
    TextBtn.Size = UDim2.new(1, 0, 0, 30)
    TextBtn.BackgroundTransparency = 1
    TextBtn.Text = name
    TextBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
    TextBtn.Font = Enum.Font.GothamMedium
    TextBtn.TextSize = 13
    TextBtn.TextXAlignment = Enum.TextXAlignment.Left
    local TextPadding = Instance.new("UIPadding")
    TextPadding.Parent = TextBtn
    TextPadding.PaddingLeft = UDim.new(0, 10)

    DescLabel.Parent = ButtonFrame
    DescLabel.Size = UDim2.new(1, 0, 0, 20)
    DescLabel.Position = UDim2.new(0, 0, 0, 28)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 9
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    local DescPadding = TextPadding:Clone()
    DescPadding.Parent = DescLabel

    TextBtn.MouseButton1Click:Connect(function()
        callback()
        local info = TweenInfo.new(0.2)
        TweenService:Create(ButtonFrame, info, {BackgroundColor3 = Color3.fromRGB(50, 20, 50)}):Play()
        TweenService:Create(BtnStroke, info, {Color = Color3.fromRGB(255, 100, 255)}):Play()
        wait(0.2)
        TweenService:Create(ButtonFrame, info, {BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
        TweenService:Create(BtnStroke, info, {Color = Color3.fromRGB(40, 40, 50)}):Play()
    end)
end

-- --- [[ ปุ่มฟังก์ชั่น ]] ---

CreateButton("ลบทุกอย่าง (Extreme Clear)", "ลบไฟ, น้ำ, หิน, เอฟเฟกต์ทั้งหมดในแมพ", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false end
        if v:IsA("BasePart") and (v.Name:lower():find("water") or v.Name:lower():find("river")) then v:Destroy() end
        if v:IsA("BasePart") and (v.Name:lower():find("rock") or v.Name:lower():find("stone") or v.Material == Enum.Material.Slate) then v:Destroy() end
        if v:IsA("SpecialMesh") and v.MeshType == Enum.MeshType.FileMesh and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then v:Destroy() end
    end
end)

CreateButton("ลบระบบสั่น 100%", "ล็อคกล้องให้นิ่งสนิท ไม่ส่ายตามแมพ", function()
    RunService:BindToRenderStep("FixedCam", 201, function()
        workspace.CurrentCamera.FieldOfView = 70
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new(0,0,0)
        end
    end)
end)

CreateButton("โหมดลื่นพิเศษ (No Shadows)", "ปิดเงา ปรับกราฟิกต่ำสุด Force FPS", function()
    game.Lighting.GlobalShadows = false
    settings().Rendering.QualityLevel = 1
end)

CreateButton("ลบพื้นผิวทั้งหมด (No Texture)", "เปลี่ยนแมพเป็นสีพื้น ช่วยลด RAM", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
    end
end)

CreateButton("เปิดไฟส่องทาง (FullBright)", "สว่างทั่วแมพ มองเห็นชัดในที่มืด", function()
    game.Lighting.Brightness = 2
    game.Lighting.ClockTime = 14
    game.Lighting.GlobalShadows = false
end)

CreateButton("เปลี่ยนทุกอย่างเป็นพลาสติก", "ลดการเรนเดอร์วัสดุ เปลี่ยนเป็นพลาสติกเรียบ", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then v.Material = Enum.Material.Plastic end
    end
end)

CreateButton("Extreme FPS Optimizer", "บังคับใช้ระบบ Compatibility (ลื่นที่สุด)", function()
    sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
end)

CreateButton("ล้างหน่วยความจำ (Clean RAM)", "ช่วยให้เครื่องลื่นขึ้นชั่วคราว", function()
    collectgarbage("collect")
end)

CreateButton("Developer Credit", "ของดีต้องของเฮีย! TikTok: @meridian_tle", function()
    StarterGui:SetCore("SendNotification", {
        Title = "Meridian_Tle",
        Text = "ติดตามผลงานได้ที่ TikTok: @meridian_tle",
        Duration = 5
    })
end)

print("Meridian Official Loaded - Created by Meridian_Tle")
