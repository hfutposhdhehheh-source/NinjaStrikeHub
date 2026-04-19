her-- [[ MERIDIAN HUB V5.5 - COMPACT THAI EDITION (RE-MOD) ]] --

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ CONFIGURATION ]]
local Settings = {
    Aimbot = false,
    WallCheck = false,
    TeamCheck = false,
    ShowFOV = false,
    FOVSize = 100,
    ESPEnabled = false,
    HitboxEnabled = false,
    HitboxSize = 2
    -- NoClip Removed to prevent bugs
}

-- [[ 1. MODERN PRE-LOADER ]]
local LoaderGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
local LoadBack = Instance.new("Frame", LoaderGui)
LoadBack.Size = UDim2.new(0, 240, 0, 80); LoadBack.Position = UDim2.new(0.5, -120, 0.5, -40); LoadBack.BackgroundColor3 = Color3.fromRGB(10, 10, 15); LoadBack.BorderSizePixel = 0
Instance.new("UICorner", LoadBack).CornerRadius = UDim.new(0, 12)

local LoadTitle = Instance.new("TextLabel", LoadBack)
LoadTitle.Size = UDim2.new(1, 0, 0, 40); LoadTitle.Text = "กำลังโหลด MERIDIAN..."; LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 200); LoadTitle.Font = Enum.Font.GothamBold; LoadTitle.BackgroundTransparency = 1; LoadTitle.TextSize = 14

local BarBack = Instance.new("Frame", LoadBack)
BarBack.Size = UDim2.new(0.8, 0, 0, 3); BarBack.Position = UDim2.new(0.1, 0, 0, 55); BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 35); BarBack.BorderSizePixel = 0

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0, 0, 1, 0); BarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 200); BarFill.BorderSizePixel = 0

-- [[ 2. COMPACT UI SETUP ]]
local MainGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
MainGui.ResetOnSpawn = false

-- ปุ่มเปิด/ปิดแบบวงกลมเล็ก (Minimalist)
local ToggleBtn = Instance.new("TextButton", MainGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25); ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ToggleBtn.Text = "M"; ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 200); ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 18; ToggleBtn.Visible = false
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 255, 200); Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 260, 0, 300); MainFrame.Position = UDim2.new(0.5, -130, 0.5, -150); MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14); MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12); 
local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Color3.fromRGB(0, 255, 200); MainStroke.Thickness = 1.5

local TitleHeader = Instance.new("TextLabel", MainFrame)
TitleHeader.Size = UDim2.new(1, 0, 0, 40); TitleHeader.Text = "MERIDIAN V5.5 [FIXED]"; TitleHeader.TextColor3 = Color3.fromRGB(255, 255, 255); TitleHeader.Font = Enum.Font.GothamBold; TitleHeader.BackgroundTransparency = 1; TitleHeader.TextSize = 13

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -55); Container.Position = UDim2.new(0, 10, 0, 45); Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 0
local UIListLayout = Instance.new("UIListLayout", Container); UIListLayout.Padding = UDim.new(0, 7)

-- UI Helper Functions
local function NewToggle(text, callback)
    local btn = Instance.new("TextButton", Container); btn.Size = UDim2.new(1, 0, 0, 34); btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Text = "  " .. text; btn.TextColor3 = Color3.fromRGB(180, 180, 180); btn.TextXAlignment = Enum.TextXAlignment.Left; btn.Font = Enum.Font.GothamSemibold; btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local act = false
    btn.MouseButton1Click:Connect(function() act = not act; callback(act); btn.TextColor3 = act and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(180, 180, 180) end)
end

local function NewSlider(text, startVal, maxVal, callback)
    local SFrame = Instance.new("Frame", Container); SFrame.Size = UDim2.new(1, 0, 0, 44); SFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22); Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", SFrame); Lbl.Size = UDim2.new(1, 0, 0, 20); Lbl.Text = text .. ": " .. startVal; Lbl.TextColor3 = Color3.new(0.9,0.9,0.9); Lbl.Font = Enum.Font.Gotham; Lbl.BackgroundTransparency = 1; Lbl.TextSize = 10
    local Bar = Instance.new("TextButton", SFrame); Bar.Size = UDim2.new(0.85, 0, 0, 3); Bar.Position = UDim2.new(0.075, 0, 0.75, 0); Bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50); Bar.Text = ""; Instance.new("UICorner", Bar)
    local Fill = Instance.new("Frame", Bar); Fill.Size = UDim2.new(startVal/maxVal, 0, 1, 0); Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 200); Instance.new("UICorner", Fill)
    
    local function Update(input)
        local per = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(per, 0, 1, 0)
        local val = math.floor(per * maxVal); Lbl.Text = text .. ": " .. val; callback(val)
    end
    local drag = false
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; Update(i) end end)
    UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
    UserInputService.InputEnded:Connect(function() drag = false end)
end

-- เพิ่มฟังก์ชัน (ภาษาไทย)
NewToggle("ล็อคหัว (Hard Lock)", function(v) Settings.Aimbot = v end)
NewToggle("เช็คกำแพง (Wall Check)", function(v) Settings.WallCheck = v end)
NewToggle("เช็คทีม (Team Check)", function(v) Settings.TeamCheck = v end)
NewToggle("แสดงวง FOV", function(v) Settings.ShowFOV = v end)
NewSlider("ขนาดวง FOV", 100, 500, function(v) Settings.FOVSize = v end)
NewToggle("เปิดฮิทบ็อกซ์ (Box)", function(v) Settings.HitboxEnabled = v end)
NewSlider("ขนาดฮิทบ็อกซ์", 2, 15, function(v) Settings.HitboxSize = v end)
NewToggle("มองศัตรู (ESP)", function(v) Settings.ESPEnabled = v end)

-- [[ 3. LOGIC CORE ]]
local FOVCircle = Instance.new("Frame", MainGui); FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0); FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5); FOVCircle.BackgroundTransparency = 1; FOVCircle.Visible = false
Instance.new("UIStroke", FOVCircle).Color = Color3.fromRGB(0, 255, 200); Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)

RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = Settings.ShowFOV
    FOVCircle.Size = UDim2.new(0, Settings.FOVSize * 2, 0, Settings.FOVSize * 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                -- Hitbox System
                if Settings.HitboxEnabled then
                    root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    root.Transparency = 0.7; root.CanCollide = false; root.Color = Color3.fromRGB(0, 255, 200)
                else
                    root.Size = Vector3.new(2, 2, 1); root.Transparency = 1
                end
                
                -- ESP
                local h = p.Character:FindFirstChild("MH_ESP")
                if Settings.ESPEnabled then
                    if not h then h = Instance.new("Highlight", p.Character); h.Name = "MH_ESP" end
                    h.Enabled = true; h.FillColor = Color3.fromRGB(0, 255, 200); h.OutlineColor = Color3.new(1,1,1)
                elseif h then h.Enabled = false end
            end
        end
    end

    -- Hard Aimbot
    if Settings.Aimbot then
        local target = nil; local dist = Settings.FOVSize
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                if Settings.TeamCheck and p.Team == LocalPlayer.Team then continue end
                local pos, os = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if os then
                    local m = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if m <= dist then
                        if Settings.WallCheck and #Camera:GetPartsObscuringTarget({Camera.CFrame.Position, p.Character.Head.Position}, {LocalPlayer.Character, p.Character}) > 0 then continue end
                        dist = m; target = p.Character.Head
                    end
                end
            end
        end
        if target then Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position) end
    end
end)

-- Draggable Function
local function Drag(f)
    local d, s, p; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true; s = i.Position; p = f.Position end end)
    UserInputService.InputChanged:Connect(function(i) if d and (i.Position and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch)) then
        local delta = i.Position - s; f.Position = UDim2.new(p.X.Scale, p.X.Offset + delta.X, p.Y.Scale, p.Y.Offset + delta.Y)
    end end)
    UserInputService.InputEnded:Connect(function() d = false end)
end
Drag(MainFrame); Drag(ToggleBtn)

-- Finish Loader
task.spawn(function()
    for i = 0, 1, 0.1 do BarFill.Size = UDim2.new(i, 0, 1, 0); task.wait(0.12) end
    LoaderGui:Destroy(); MainFrame.Visible = true; ToggleBtn.Visible = true
end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
