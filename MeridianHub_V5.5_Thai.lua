local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME สำหรับหน้าคีย์เดิม ]] --
local THEME = {
    Main = Color3.fromRGB(0, 10, 0),
    Accent = Color3.fromRGB(0, 255, 0),
    Secondary = Color3.fromRGB(0, 80, 0),
    Text = Color3.fromRGB(255, 255, 255)
}

-- [[ UI SYSTEM: KEYBOARD INPUT (Alpha Eclipse) ]] --
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AlphaEclipseKeySystem"
ScreenGui.ResetOnSpawn = false

local AnimFrame = Instance.new("Frame", ScreenGui)
AnimFrame.Size = UDim2.new(0, 300, 0, 220)
AnimFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
AnimFrame.BackgroundTransparency = 1
AnimFrame.Active = true
AnimFrame.Draggable = true

local MainFrame = Instance.new("Frame", AnimFrame)
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = THEME.Main
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", MainFrame).Color = THEME.Accent

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "MERIDIAN // SECURE ACCESS"
Title.TextColor3 = THEME.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "AUTHENTICATION KEY..."
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeyInput.TextColor3 = THEME.Text
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Text = ""
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", MainFrame)
SubmitBtn.Text = "LOG IN"
SubmitBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.BackgroundColor3 = THEME.Accent
SubmitBtn.TextColor3 = THEME.Main
SubmitBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", SubmitBtn)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Text = "GET KEY (WEBSITE)"
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = THEME.Secondary
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 12

-- [[ ฟังก์ชั่นโหลดเมนูหลัก MERIDIAN (Rayfield UI) ]] --
local function LoadMeridianRayfield()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Settings = {
        Aimbot = false, WallCheck = false, TeamCheck = false, 
        ShowFOV = false, FOVSize = 100, 
        ESPEnabled = false, HitboxEnabled = false, HitboxSize = 2
    }

    -- [[ LOGIC CORE ]] --
    local FOVCircle = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local Circle = Instance.new("Frame", FOVCircle)
    Circle.AnchorPoint = Vector2.new(0.5, 0.5); Circle.Position = UDim2.new(0.5, 0, 0.5, 0)
    Circle.BackgroundTransparency = 1; Circle.Visible = false
    Instance.new("UIStroke", Circle).Color = Color3.fromRGB(0, 255, 200)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    RunService.RenderStepped:Connect(function()
        Circle.Visible = Settings.ShowFOV
        Circle.Size = UDim2.new(0, Settings.FOVSize * 2, 0, Settings.FOVSize * 2)

        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    -- Hitbox
                    if Settings.HitboxEnabled then
                        root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        root.Transparency = 0.7; root.CanCollide = false
                    else
                        root.Size = Vector3.new(2, 2, 1); root.Transparency = 1
                    end
                    -- ESP
                    local h = p.Character:FindFirstChild("MH_ESP")
                    if Settings.ESPEnabled then
                        if not h then h = Instance.new("Highlight", p.Character); h.Name = "MH_ESP" end
                        h.Enabled = true; h.FillColor = Color3.fromRGB(0, 255, 200)
                    elseif h then h.Enabled = false end
                end
            end
        end

        if Settings.Aimbot then
            local target = nil; local dist = Settings.FOVSize
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                    if Settings.TeamCheck and p.Team == game.Players.LocalPlayer.Team then continue end
                    local pos, os = workspace.CurrentCamera:WorldToViewportPoint(p.Character.Head.Position)
                    if os then
                        local m = (Vector2.new(pos.X, pos.Y) - Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)).Magnitude
                        if m <= dist then
                            if Settings.WallCheck and #workspace.CurrentCamera:GetPartsObscuringTarget({workspace.CurrentCamera.CFrame.Position, p.Character.Head.Position}, {game.Players.LocalPlayer.Character, p.Character}) > 0 then continue end
                            dist = m; target = p.Character.Head
                        end
                    end
                end
            end
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position) end
        end
    end)

    -- [[ UI CREATION ]] --
    local Window = Rayfield:CreateWindow({
        Name = "⚡ MERIDIAN HUB V5.5 | FIXED",
        LoadingTitle = "กำลังเริ่มระบบ Meridian...",
        LoadingSubtitle = "by THE CREATOR",
        KeySystem = false
    })

    local Tab1 = Window:CreateTab("🎯 Combat", 4483362458)
    Tab1:CreateSection("Aimbot & Assists")
    Tab1:CreateToggle({Name = "ล็อคหัว (Hard Lock)", CurrentValue = false, Callback = function(v) Settings.Aimbot = v end})
    Tab1:CreateToggle({Name = "เช็คกำแพง (Wall Check)", CurrentValue = false, Callback = function(v) Settings.WallCheck = v end})
    Tab1:CreateToggle({Name = "เช็คทีม (Team Check)", CurrentValue = false, Callback = function(v) Settings.TeamCheck = v end})
    
    Tab1:CreateSection("Hitbox Adjustment")
    Tab1:CreateToggle({Name = "เปิดฮิทบ็อกซ์ (Box)", CurrentValue = false, Callback = function(v) Settings.HitboxEnabled = v end})
    Tab1:CreateSlider({Name = "ขนาดฮิทบ็อกซ์", Range = {2, 15}, Increment = 1, Suffix = "Size", CurrentValue = 2, Callback = function(v) Settings.HitboxSize = v end})

    local Tab2 = Window:CreateTab("👁️ Visuals", 4483362458)
    Tab2:CreateSection("ESP Settings")
    Tab2:CreateToggle({Name = "มองศัตรู (ESP)", CurrentValue = false, Callback = function(v) Settings.ESPEnabled = v end})
    
    Tab2:CreateSection("FOV Settings")
    Tab2:CreateToggle({Name = "แสดงวง FOV", CurrentValue = false, Callback = function(v) Settings.ShowFOV = v end})
    Tab2:CreateSlider({Name = "ขนาดวง FOV", Range = {100, 500}, Increment = 10, Suffix = "px", CurrentValue = 100, Callback = function(v) Settings.FOVSize = v end})

    Rayfield:Notify({Title = "MERIDIAN LOADED", Content = "ใช้อย่างระมัดระวังนะครับผม", Duration = 5})
end

-- [[ KEY SYSTEM LOGIC ]] --
SubmitBtn.MouseButton1Click:Connect(function()
    local cleanKey = KeyInput.Text:gsub("%s+", "")
    if cleanKey == "" then KeyInput.Text = "NEED KEY!" return end
    SubmitBtn.Text = "VERIFYING..."

    local success, response = pcall(function()
        return HttpService:RequestAsync({Url = _URL .. cleanKey .. ".json", Method = "GET"})
    end)

    if success and response.Success then
        if response.Body == "null" then
            KeyInput.Text = "INVALID KEY!"
            SubmitBtn.Text = "LOG IN"
        else
            local data = HttpService:JSONDecode(response.Body)
            if (os.time() * 1000) < data.expires then
                SubmitBtn.Text = "GRANTED!"
                task.wait(0.5)
                local twClose = TweenService:Create(AnimFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = 180})
                twClose:Play()
                twClose.Completed:Connect(function()
                    ScreenGui:Destroy()
                    LoadMeridianRayfield()
                end)
            else
                KeyInput.Text = "EXPIRED!"
                SubmitBtn.Text = "LOG IN"
            end
        end
    else
        KeyInput.Text = "NETWORK ERROR!"
        SubmitBtn.Text = "RETRY"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://hfutposhdhehheh-source.github.io/The-Creator-Key-System/")
    GetKeyBtn.Text = "COPIED!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY (WEBSITE)"
end)
