-- [[ ULTIMATE CINEMA HUB V8.1 - STABLE SPEED EDITION ]] --
-- ฐาน V8 ที่เสถียรที่สุด | ปรับลิมิตความเร็ว 0.01 - 100 | GUI สวยพรีเมียม

local Player = game:GetService("Players").LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CinemaHubV8_Stable"
ScreenGui.ResetOnSpawn = false

-- [ Function: Tween ] --
local function tween(obj, info, goal)
    TweenService:Create(obj, TweenInfo.new(info, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), goal):Play()
end

-- [ Main Window ] --
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(89, 31, 154)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.5

-- [ Sidebar ] --
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 100, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
SideBar.BackgroundTransparency = 0.2
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 12)

-- [ Tab Buttons ] --
local function createTab(name, pos, activeColor)
    local btn = Instance.new("TextButton", SideBar)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, pos)
    btn.BackgroundColor3 = activeColor or Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn)
    return btn
end

local CamTabBtn = createTab("CAMERA", 10, Color3.fromRGB(89, 31, 154))
local GfxTabBtn = createTab("GRAPHIC", 55, Color3.fromRGB(30, 30, 30))

-- [ Container & Pages ] --
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -110, 1, -20)
Container.Position = UDim2.new(0, 105, 0, 10)
Container.BackgroundTransparency = 1

local CamPage = Instance.new("Frame", Container)
CamPage.Size = UDim2.new(1, 0, 1, 0)
CamPage.BackgroundTransparency = 1

local GfxPage = Instance.new("Frame", Container)
GfxPage.Size = UDim2.new(1, 0, 1, 0)
GfxPage.BackgroundTransparency = 1
GfxPage.Visible = false

-- [ Button Creator ] --
local function createActionBtn(text, pos, parent, color)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- [ Camera UI Elements ] --
local FreecamBtn = createActionBtn("FREECAM: OFF", UDim2.new(0,0,0,0), CamPage)
local HideBtn = createActionBtn("HIDE GUI (RECORD)", UDim2.new(0,0,0,45), CamPage, Color3.fromRGB(150, 50, 50))
local SpeedInfo = Instance.new("TextLabel", CamPage)
SpeedInfo.Size = UDim2.new(1,0,0,20); SpeedInfo.Position = UDim2.new(0,0,0,90)
SpeedInfo.Text = "SPEED: 1.00"; SpeedInfo.TextColor3 = Color3.new(0.8,0.8,0.8); SpeedInfo.BackgroundTransparency = 1; SpeedInfo.Font = Enum.Font.Gotham

local SpdUp = createActionBtn("SPEED +", UDim2.new(0,0,0,115), CamPage)
local SpdDown = createActionBtn("SPEED -", UDim2.new(0,0,0,160), CamPage)

-- [ Graphic UI Elements ] --
local G1 = createActionBtn("SMOOTH (LV 1)", UDim2.new(0,0,0,0), GfxPage)
local G2 = createActionBtn("ULTRA HD (LV 2)", UDim2.new(0,0,0,45), GfxPage)
local G3 = createActionBtn("CINEMATIC RT (LV 3)", UDim2.new(0,0,0,90), GfxPage, Color3.fromRGB(89, 31, 154))
local GReset = createActionBtn("RESET GRAPHICS", UDim2.new(0,0,0,160), GfxPage, Color3.fromRGB(70, 70, 70))

-- [ Toggle Button ] --
local ToggleMain = Instance.new("TextButton", ScreenGui)
ToggleMain.Size = UDim2.new(0, 50, 0, 50)
ToggleMain.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleMain.BackgroundColor3 = Color3.fromRGB(89, 31, 154)
ToggleMain.Text = "C"
ToggleMain.TextColor3 = Color3.new(1,1,1)
ToggleMain.Font = Enum.Font.GothamBold
ToggleMain.TextSize = 18
Instance.new("UICorner", ToggleMain).CornerRadius = UDim.new(1, 0)
ToggleMain.Draggable = true

-- [ LOGIC: Movement & Control ] --
local active = false
local speed = 1.00
local cameraRot = Vector2.new(0, 0)
local moveVector = Vector3.new(0, 0, 0)
local FakeJoystick = Instance.new("Frame", ScreenGui)
FakeJoystick.Size = UDim2.new(0, 200, 0, 200); FakeJoystick.Position = UDim2.new(0, 20, 1, -220); FakeJoystick.BackgroundTransparency = 1; FakeJoystick.Visible = false

ToggleMain.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- สลับหน้า Tab
CamTabBtn.MouseButton1Click:Connect(function()
    CamPage.Visible = true; GfxPage.Visible = false
    CamTabBtn.BackgroundColor3 = Color3.fromRGB(89, 31, 154); GfxTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
GfxTabBtn.MouseButton1Click:Connect(function()
    CamPage.Visible = false; GfxPage.Visible = true
    GfxTabBtn.BackgroundColor3 = Color3.fromRGB(89, 31, 154); CamTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- ปุ่ม Speed (0.01 - 100)
SpdUp.MouseButton1Click:Connect(function()
    speed = math.min(100, speed + (speed < 1 and 0.05 or 1)) 
    SpeedInfo.Text = "SPEED: "..string.format("%.2f", speed)
end)
SpdDown.MouseButton1Click:Connect(function()
    speed = math.max(0.01, speed - (speed <= 1 and 0.05 or 1))
    SpeedInfo.Text = "SPEED: "..string.format("%.2f", speed)
end)

FreecamBtn.MouseButton1Click:Connect(function()
    active = not active
    FreecamBtn.Text = active and "FREECAM: ON" or "FREECAM: OFF"
    FreecamBtn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(40, 40, 40)
    FakeJoystick.Visible = active
    if active then 
        Camera.CameraType = Enum.CameraType.Scriptable
        if Player.Character then Player.Character.PrimaryPart.Anchored = true end
    else 
        Camera.CameraType = Enum.CameraType.Custom
        if Player.Character then Player.Character.PrimaryPart.Anchored = false end
    end
end)

-- Joystick & Mouse Logic
FakeJoystick.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        local startPos = input.Position
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then moveVector = Vector3.new(0,0,0) connection:Disconnect() else
                local diff = (input.Position - startPos)
                moveVector = Vector3.new(diff.X, 0, diff.Y).Unit
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if active and input.UserInputType == Enum.UserInputType.Touch and input.Position.X > 250 then
        cameraRot = cameraRot - Vector2.new(input.Delta.X, input.Delta.Y) * 0.4
    end
end)

RunService.RenderStepped:Connect(function()
    if active then
        local rot = CFrame.Angles(0, math.rad(cameraRot.X), 0) * CFrame.Angles(math.rad(cameraRot.Y), 0, 0)
        Camera.CFrame = CFrame.new(Camera.CFrame.Position) * rot
        if moveVector.Magnitude > 0 then
            Camera.CFrame = Camera.CFrame + ((rot.LookVector * -moveVector.Z) + (rot.RightVector * moveVector.X)) * speed
        end
    end
end)

-- [ Graphic Logic ] --
local function ClearEffects()
    for _, v in pairs(Lighting:GetChildren()) do if v:IsA("PostProcessEffect") then v:Destroy() end end
    Lighting.Brightness = 2
end
G1.MouseButton1Click:Connect(function() ClearEffects(); Lighting.Brightness = 2.5 end)
G2.MouseButton1Click:Connect(function()
    ClearEffects(); local b = Instance.new("BloomEffect", Lighting); b.Intensity = 0.5
    local s = Instance.new("SunRaysEffect", Lighting); s.Intensity = 0.1
end)
G3.MouseButton1Click:Connect(function()
    ClearEffects(); Lighting.GlobalShadows = true; local b = Instance.new("BloomEffect", Lighting); b.Intensity = 1
    local c = Instance.new("ColorCorrectionEffect", Lighting); c.Contrast = 0.25; c.Saturation = 0.2
    local s = Instance.new("SunRaysEffect", Lighting); s.Intensity = 0.2
    if workspace.Terrain then workspace.Terrain.WaterReflection = 1 end
end)
GReset.MouseButton1Click:Connect(ClearEffects)

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    tween(ToggleMain, 0.5, {BackgroundTransparency = 0.98, TextTransparency = 0.98})
end)
ToggleMain.MouseButton1Down:Connect(function()
    wait(2)
    tween(ToggleMain, 0.2, {BackgroundTransparency = 0, TextTransparency = 0})
end)

