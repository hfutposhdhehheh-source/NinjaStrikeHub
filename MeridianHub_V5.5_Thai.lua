local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME ]] --
local THEME = {
    Main = Color3.fromRGB(0, 10, 0),
    Accent = Color3.fromRGB(0, 255, 0),
    Secondary = Color3.fromRGB(0, 80, 0),
    Text = Color3.fromRGB(255, 255, 255)
}

-- [[ UI SYSTEM: KEYBOARD INPUT ]] --
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
Title.Text = "THE CREATOR // SECURE ACCESS"
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

-- [[ MAIN SCRIPT LOADING FUNCTION ]] --
local function LoadMeridianV5()
    -- [[ 1. MODERN PRE-LOADER ]]
    local LoaderGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
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
    local MainGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui); MainGui.ResetOnSpawn = false
    local ToggleBtn = Instance.new("TextButton", MainGui)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 50); ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25); ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20); ToggleBtn.Text = "M"; ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 200); ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.Visible = false
    Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 255, 200); Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local MainF = Instance.new("Frame", MainGui)
    MainF.Size = UDim2.new(0, 260, 0, 300); MainF.Position = UDim2.new(0.5, -130, 0.5, -150); MainF.BackgroundColor3 = Color3.fromRGB(10, 10, 14); MainF.Visible = false
    Instance.new("UICorner", MainF); Instance.new("UIStroke", MainF).Color = Color3.fromRGB(0, 255, 200)

    local Container = Instance.new("ScrollingFrame", MainF)
    Container.Size = UDim2.new(1, -20, 1, -55); Container.Position = UDim2.new(0, 10, 0, 45); Container.BackgroundTransparency = 1; Container.ScrollBarThickness = 0
    Instance.new("UIListLayout", Container).Padding = UDim.new(0, 7)

    local Settings = {Aimbot = false, WallCheck = false, TeamCheck = false, ShowFOV = false, FOVSize = 100, ESPEnabled = false, HitboxEnabled = false, HitboxSize = 2}

    -- UI Helpers (Thai)
    local function NewToggle(txt, cb)
        local b = Instance.new("TextButton", Container); b.Size = UDim2.new(1, 0, 0, 34); b.BackgroundColor3 = Color3.fromRGB(20, 20, 25); b.Text = "  "..txt; b.TextColor3 = Color3.fromRGB(180, 180, 180); b.TextXAlignment = Enum.TextXAlignment.Left; b.Font = Enum.Font.GothamSemibold; Instance.new("UICorner", b)
        local a = false; b.MouseButton1Click:Connect(function() a = not a; cb(a); b.TextColor3 = a and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(180, 180, 180) end)
    end

    local function NewSlider(txt, s, m, cb)
        local f = Instance.new("Frame", Container); f.Size = UDim2.new(1, 0, 0, 44); f.BackgroundColor3 = Color3.fromRGB(18, 18, 22); Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f); l.Size = UDim2.new(1, 0, 0, 20); l.Text = txt..": "..s; l.TextColor3 = Color3.new(0.9,0.9,0.9); l.BackgroundTransparency = 1
        local bar = Instance.new("TextButton", f); bar.Size = UDim2.new(0.85, 0, 0, 3); bar.Position = UDim2.new(0.075, 0, 0.75, 0); bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50); bar.Text = ""
        local fill = Instance.new("Frame", bar); fill.Size = UDim2.new(s/m, 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
        local drg = false
        local function Upd(i) local p = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1); fill.Size = UDim2.new(p, 0, 1, 0); local v = math.floor(p*m); l.Text = txt..": "..v; cb(v) end
        bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drg = true; Upd(i) end end)
        UserInputService.InputChanged:Connect(function(i) if drg and i.UserInputType == Enum.UserInputType.MouseMovement then Upd(i) end end)
        UserInputService.InputEnded:Connect(function() drg = false end)
    end

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
        FOVCircle.Visible = Settings.ShowFOV; FOVCircle.Size = UDim2.new(0, Settings.FOVSize * 2, 0, Settings.FOVSize * 2)
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                if root and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    if Settings.HitboxEnabled then root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize); root.Transparency = 0.7; root.CanCollide = false else root.Size = Vector3.new(2, 2, 1); root.Transparency = 1 end
                    local h = p.Character:FindFirstChild("MH_ESP")
                    if Settings.ESPEnabled then if not h then h = Instance.new("Highlight", p.Character); h.Name = "MH_ESP" end; h.Enabled = true else if h then h.Enabled = false end end
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

    -- Loader Finish
    task.spawn(function()
        for i = 0, 1, 0.1 do BarFill.Size = UDim2.new(i, 0, 1, 0); task.wait(0.12) end
        LoaderGui:Destroy(); MainF.Visible = true; ToggleBtn.Visible = true
    end)
    ToggleBtn.MouseButton1Click:Connect(function() MainF.Visible = not MainF.Visible end)
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
                    LoadMeridianV5()
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
