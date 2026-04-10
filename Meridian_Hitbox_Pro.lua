local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ลบของเก่าถ้ามี
if CoreGui:FindFirstChild("MeridianHitboxV2") then CoreGui.MeridianHitboxV2:Destroy() end

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "MeridianHitboxV2"

-- [ Variables ]
_G.HitboxSize = 2
_G.HitboxTransparency = 0.5
_G.HitboxEnabled = false

-- [ Function for Hitbox Logic ]
local function UpdateHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if _G.HitboxEnabled then
                hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                hrp.Transparency = _G.HitboxTransparency
                hrp.Color = Color3.fromRGB(255, 0, 0)
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            else
                -- คืนค่าปกติ (อาจจะต้องปรับตามเกม)
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
            end
        end
    end
end

-- [ UI Builders - Fixed Layout ]
local Main = Instance.new("Frame", SG)
Main.Size = UDim2.new(0, 320, 0, 240) -- ขยายขนาดนิดหน่อย
Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Visible = true -- เปิดไว้ก่อน
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(255, 50, 50)
MainStroke.Thickness = 1.2

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "HITBOX EXTENDER PRO V2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.BackgroundTransparency = 1

-- Container for Sliders (จัดระเบียบ)
local SContainer = Instance.new("Frame", Main)
SContainer.Size = UDim2.new(1, -20, 0, 120)
SContainer.Position = UDim2.new(0, 10, 0, 50)
SContainer.BackgroundTransparency = 1
local SList = Instance.new("UIListLayout", SContainer)
SList.Padding = UDim.new(0, 10)

-- Slider Builder
local function CreateSlider(parent, txt, min, max, default, callback)
    local SFrame = Instance.new("Frame", parent)
    SFrame.Size = UDim2.new(1, 0, 0, 50)
    SFrame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel", SFrame)
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Text = txt .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = "Left"
    
    local BG = Instance.new("Frame", SFrame)
    BG.Size = UDim2.new(1, 0, 0, 8)
    BG.Position = UDim2.new(0, 0, 0, 25)
    BG.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Instance.new("UICorner", BG)
    
    local Fill = Instance.new("Frame", BG)
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Instance.new("UICorner", Fill)
    
    BG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local move = RunService.RenderStepped:Connect(function()
                local mPos = math.clamp(UserInputService:GetMouseLocation().X - BG.AbsolutePosition.X, 0, BG.AbsoluteSize.X)
                local percent = mPos/BG.AbsoluteSize.X
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                local val = min + (max-min)*percent
                Label.Text = txt .. ": " .. string.format("%.1f", val)
                callback(val)
                UpdateHitboxes() -- อัปเดตทันทีเมื่อลาก
            end)
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then move:Disconnect() end end)
        end
    end)
end

CreateSlider(SContainer, "Hitbox Size", 2, 25, 2, function(v) _G.HitboxSize = v end)
CreateSlider(SContainer, "Transparency", 0, 1, 0.5, function(v) _G.HitboxTransparency = v end)

-- [ Enable/Disable Button (Fixed Location) ]
local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(0, 200, 0, 38)
Btn.Position = UDim2.new(0.5, -100, 1, -55) -- จัดให้อยู่ด้านล่างสุด ไม่ทับ Slider
Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Btn.Text = "Enable Hitbox"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 14
Instance.new("UICorner", Btn)
local BStroke = Instance.new("UIStroke", Btn)
BStroke.Color = Color3.fromRGB(255, 50, 50)

Btn.MouseButton1Click:Connect(function()
    _G.HitboxEnabled = not _G.HitboxEnabled
    Btn.Text = _G.HitboxEnabled and "Disable Hitbox" or "Enable Hitbox"
    Btn.BackgroundColor3 = _G.HitboxEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(25, 25, 30)
    UpdateHitboxes() -- คืนค่าเมื่อปิด
end)

-- [ Floating Toggle Button ]
local ToggleBtn = Instance.new("TextButton", SG)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.5, -22) -- เริ่มต้นตรงกลางซ้าย
ToggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
ToggleBtn.Text = "H"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 18
ToggleBtn.Active = true -- สำคัญเพื่อให้ลากได้
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Color = Color3.fromRGB(255, 50, 50)

ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- [ Dragging System (Main & Toggle) ]
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

MakeDraggable(Main)
MakeDraggable(ToggleBtn)
