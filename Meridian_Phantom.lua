-- [[ MERIDIAN MINI HUB : KORBLOX & HEADLESS ]] --
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ToggleHeadless = Instance.new("TextButton")
local ToggleKorblox = Instance.new("TextButton")
local HideButton = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

-- ตั้งค่า GUI (เล็กๆ น่ารัก)
ScreenGui.Name = "MeridianMini"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true -- ลากไปวางที่ไหนก็ได้

UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Meridian Mini"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ฟังก์ชัน หัวหาย (Headless)
local headlessEnabled = false
local function applyHeadless()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        char.Head.Transparency = headlessEnabled and 1 or 0
        if char.Head:FindFirstChild("face") then
            char.Head.face.Transparency = headlessEnabled and 1 or 0
        end
    end
end

-- ฟังก์ชัน ขากุด (Korblox)
local korbloxEnabled = false
local function applyKorblox()
    local char = game.Players.LocalPlayer.Character
    if not char or not korbloxEnabled then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if hum.RigType == Enum.HumanoidRigType.R15 then
        if char:FindFirstChild("RightLowerLeg") and char:FindFirstChild("RightFoot") then
            char.RightLowerLeg.Transparency = 1
            char.RightFoot.Transparency = 1
            char.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
            char.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
        end
    elseif hum.RigType == Enum.HumanoidRigType.R6 then
        local rl = char:FindFirstChild("Right Leg")
        if rl then
            local m = rl:FindFirstChildOfClass("SpecialMesh") or Instance.new("SpecialMesh", rl)
            m.MeshType = Enum.MeshType.FileMesh
            m.MeshId = "rbxassetid://101851696"
            m.TextureId = "rbxassetid://101851254"
            rl.Color = Color3.fromRGB(64, 64, 64)
        end
    end
end

-- ระบบ Loop ให้มันติดตลอดเวลา
task.spawn(function()
    while task.wait(0.5) do
        if headlessEnabled then applyHeadless() end
        if korbloxEnabled then applyKorblox() end
    end
end)

-- ปุ่มสร้าง (สร้างแบบสวยๆ)
local function createBtn(btn, txt, color)
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.BackgroundColor3 = color
    btn.Text = txt
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    Instance.new("UICorner", btn)
end

createBtn(ToggleHeadless, "Headless: OFF", Color3.fromRGB(80, 80, 80))
createBtn(ToggleKorblox, "Korblox: OFF", Color3.fromRGB(80, 80, 80))
createBtn(HideButton, "Close / Hide", Color3.fromRGB(150, 50, 50))

-- กดยังไงให้ทำงาน
ToggleHeadless.MouseButton1Click:Connect(function()
    headlessEnabled = not headlessEnabled
    ToggleHeadless.Text = "Headless: " .. (headlessEnabled and "ON" or "OFF")
    ToggleHeadless.BackgroundColor3 = headlessEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80)
    applyHeadless()
end)

ToggleKorblox.MouseButton1Click:Connect(function()
    korbloxEnabled = not korbloxEnabled
    ToggleKorblox.Text = "Korblox: " .. (korbloxEnabled and "ON" or "OFF")
    ToggleKorblox.BackgroundColor3 = korbloxEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(80, 80, 80)
end)

-- ปุ่มซ่อน/ปิด
local hidden = false
HideButton.MouseButton1Click:Connect(function()
    hidden = not hidden
    if hidden then
        MainFrame:TweenSize(UDim2.new(0, 150, 0, 30), "Out", "Quart", 0.3, true)
        ToggleHeadless.Visible = false
        ToggleKorblox.Visible = false
        HideButton.Text = "Open"
    else
        MainFrame:TweenSize(UDim2.new(0, 150, 0, 160), "Out", "Quart", 0.3, true)
        task.wait(0.2)
        ToggleHeadless.Visible = true
        ToggleKorblox.Visible = true
        HideButton.Text = "Close / Hide"
    end
end)

