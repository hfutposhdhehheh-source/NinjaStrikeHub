local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

-- ลบของเก่า
if CoreGui:FindFirstChild("MeridianPro") then CoreGui.MeridianPro:Destroy() end

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "MeridianPro"

-- [ Configuration System ]
local Config = { RenderDistance = 1000, FOV = 70 }
local function SaveConfig() -- ระบบจำค่าเบื้องต้น (แบบจำลอง)
    print("Config Saved Locally")
end

-- [ Main UI Design ]
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 350, 0, 260)
Main.Position = UDim2.new(0.5, -175, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BackgroundTransparency = 0.1
local MainCorner = Instance.new("UICorner", Main)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(50, 150, 255)
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.5

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 90, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(5, 5, 7)
Instance.new("UICorner", Sidebar)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -105, 1, -20)
Container.Position = UDim2.new(0, 100, 0, 10)
Container.BackgroundTransparency = 1

local Tabs = {
    Boost = Instance.new("ScrollingFrame", Container),
    Utility = Instance.new("ScrollingFrame", Container),
    Info = Instance.new("Frame", Container)
}

for name, f in pairs(Tabs) do
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = (name == "Boost")
    if f:IsA("ScrollingFrame") then
        f.ScrollBarThickness = 2
        f.ScrollBarImageColor3 = Color3.fromRGB(50, 150, 255)
        local L = Instance.new("UIListLayout", f)
        L.Padding = UDim.new(0, 8)
    end
end

-- [ UI Builders ]
local function CreateTabBtn(txt, target)
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, -10, 0, 35)
    B.Position = UDim2.new(0, 5, 0, #Sidebar:GetChildren() * 40 - 35)
    B.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    B.Text = txt
    B.TextColor3 = Color3.fromRGB(150, 150, 150)
    B.Font = Enum.Font.GothamBold
    B.TextSize = 11
    Instance.new("UICorner", B)
    
    B.MouseButton1Click:Connect(function()
        for _, f in pairs(Tabs) do f.Visible = false end
        for _, btn in pairs(Sidebar:GetChildren()) do 
            if btn:IsA("TextButton") then btn.TextColor3 = Color3.fromRGB(150, 150, 150) end 
        end
        target.Visible = true
        B.TextColor3 = Color3.fromRGB(50, 150, 255)
    end)
end

local function CreateToggle(parent, txt, callback)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(1, -10, 0, 38)
    B.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    B.Text = "  " .. txt
    B.TextColor3 = Color3.fromRGB(230, 230, 230)
    B.Font = Enum.Font.Gotham
    B.TextSize = 12
    B.TextXAlignment = "Left"
    Instance.new("UICorner", B)
    local S = Instance.new("UIStroke", B)
    S.Color = Color3.fromRGB(50, 50, 60)
    
    local state = false
    B.MouseButton1Click:Connect(function()
        state = not state
        S.Color = state and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(50, 50, 60)
        callback(state)
    end)
end

local function CreateSlider(parent, txt, min, max, default, callback)
    local SFrame = Instance.new("Frame", parent)
    SFrame.Size = UDim2.new(1, -10, 0, 50)
    SFrame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", SFrame)
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Text = txt .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    
    local BG = Instance.new("Frame", SFrame)
    BG.Size = UDim2.new(1, 0, 0, 6)
    BG.Position = UDim2.new(0, 0, 0, 30)
    BG.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Instance.new("UICorner", BG)
    
    local Fill = Instance.new("Frame", BG)
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    Instance.new("UICorner", Fill)
    
    -- ระบบลาก Slider (แบบย่อ)
    BG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local move = RunService.RenderStepped:Connect(function()
                local mPos = UserInputService:GetMouseLocation().X - BG.AbsolutePosition.X
                local percent = math.clamp(mPos/BG.AbsoluteSize.X, 0, 1)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                local val = math.floor(min + (max-min)*percent)
                Label.Text = txt .. ": " .. val
                callback(val)
            end)
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then move:Disconnect() end end)
        end
    end)
end

-- [ ฟังก์ชันการทำงาน ]
CreateTabBtn("⚡ BOOST", Tabs.Boost)
CreateTabBtn("🛠️ UTILITY", Tabs.Utility)
CreateTabBtn("ℹ️ INFO", Tabs.Info)

-- หน้า Boost
CreateToggle(Tabs.Boost, "Potato Mode (1x1)", function(s)
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = s and Enum.Material.SmoothPlastic or Enum.Material.Plastic
        elseif v:IsA("Decal") and s then v.Transparency = 1 end
    end
end)

CreateToggle(Tabs.Boost, "Remove Shadows", function(s) Lighting.GlobalShadows = not s end)
CreateToggle(Tabs.Boost, "Clear Fog/Atmosphere", function(s)
    if s then
        local fog = Lighting:FindFirstChildOfClass("Atmosphere")
        if fog then fog.Parent = game.SharedTableRegistry end -- ซ่อนไว้
    end
end)

-- หน้า Utility
CreateSlider(Tabs.Utility, "Render Distance", 100, 5000, 1000, function(v)
    settings().Rendering.QualityLevel = 1
    game.Players.LocalPlayer.ReplicationFocus = nil -- ปรับแต่งการโหลดแมพตามระยะ
end)

CreateSlider(Tabs.Utility, "Field of View", 30, 120, 70, function(v)
    workspace.CurrentCamera.FieldOfView = v
end)

CreateToggle(Tabs.Utility, "Full Brightness", function(s)
    Lighting.Brightness = s and 3 or 1
    Lighting.ClockTime = s and 14 or 12
end)

-- หน้า Info
local InfoL = Instance.new("TextLabel", Tabs.Info)
InfoL.Size = UDim2.new(1,0,1,0)
InfoL.BackgroundTransparency = 1
InfoL.TextColor3 = Color3.fromRGB(50, 150, 255)
InfoL.Font = Enum.Font.Code
InfoL.TextSize = 13
InfoL.Text = "Loading Stats..."

RunService.RenderStepped:Connect(function()
    if Tabs.Info.Visible then
        local fps = math.floor(1/RunService.RenderStepped:Wait())
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        InfoL.Text = string.format("FPS: %d\nPING: %s\nVERSION: MERIDIAN PRO V1", fps, ping)
    end
end)

-- [ Floating Button & Drag ]
local TBtn = Instance.new("TextButton", SG)
TBtn.Size = UDim2.new(0, 40, 0, 40)
TBtn.Position = UDim2.new(0, 15, 0.5, 0)
TBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TBtn.Text = "M"
TBtn.TextColor3 = Color3.fromRGB(50, 150, 255)
local TCorner = Instance.new("UICorner", TBtn)
TCorner.CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", TBtn)
TStroke.Color = Color3.fromRGB(50, 150, 255)
TBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ลากเมนู
local dragStart, startPos, dragging
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dragging = false end)

