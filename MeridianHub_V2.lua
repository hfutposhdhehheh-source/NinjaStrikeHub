local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME ]] --
local THEME = {
    Main = Color3.fromRGB(0, 10, 0),
    Accent = Color3.fromRGB(0, 255, 0),
    Secondary = Color3.fromRGB(0, 80, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Placeholder = Color3.fromRGB(150, 150, 150)
}

-- [[ UI SYSTEM ]] --
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

-- Scanline
local Scanline = Instance.new("Frame", MainFrame)
Scanline.Size = UDim2.new(1, 0, 0, 2)
Scanline.BackgroundColor3 = THEME.Accent
Scanline.BackgroundTransparency = 0.8
Scanline.ZIndex = 2
local function RunScan()
    Scanline.Position = UDim2.new(0, 0, 0, 0)
    local tw = TweenService:Create(Scanline, TweenInfo.new(3, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 0, 1, 0)})
    tw:Play()
    tw.Completed:Connect(RunScan)
end
RunScan()

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "THE CREATOR // SECURE ACCESS"
Title.TextColor3 = THEME.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.ZIndex = 3

local KeyContainer = Instance.new("Frame", MainFrame)
KeyContainer.Size = UDim2.new(0.85, 0, 0, 40)
KeyContainer.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", KeyContainer).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", KeyContainer).Color = THEME.Secondary

local KeyInput = Instance.new("TextBox", KeyContainer)
KeyInput.PlaceholderText = "AUTHENTICATION KEY..."
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.TextColor3 = THEME.Text
KeyInput.PlaceholderColor3 = THEME.Placeholder
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Text = ""

local SubmitBtn = Instance.new("TextButton", MainFrame)
SubmitBtn.Text = "LOG IN"
SubmitBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.BackgroundColor3 = THEME.Accent
SubmitBtn.TextColor3 = THEME.Main
SubmitBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Text = "REQUEST KEY [WEBSITE]"
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.BackgroundColor3 = THEME.Main
GetKeyBtn.TextColor3 = THEME.Secondary
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 12
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", GetKeyBtn).Color = THEME.Secondary

-- Intro Anim
AnimFrame.Size = UDim2.new(0, 0, 0, 0)
AnimFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
AnimFrame.Rotation = -180
TweenService:Create(AnimFrame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 220), Position = UDim2.new(0.5, -150, 0.5, -110), Rotation = 0}):Play()

-- // MAIN FUNCTION: LOAD MERIDIAN HUB // --
local function LoadMeridianHub()
    -- [ เริ่มโหลดสคริปต์ล่าโจรของบอส ] --
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
       Name = "💎 MERIDIAN HUB | ระบบล่าโจร",
       LoadingTitle = "กำลังค้นหาเป้าหมาย...",
       LoadingSubtitle = "by MERIDIAN TEAM",
       ConfigurationSaving = {Enabled = true, FolderName = "MeridianData", FileName = "OrbitConfig"},
       KeySystem = false 
    })

    local Orbiting = false
    local SelectedTarget = nil
    local Speed, Radius, Height = 10, 8, 0

    local function isCriminal(player)
        if not player.Team then return false end
        local teamName, color = player.Team.Name:lower(), player.TeamColor.Name
        if string.find(teamName, "crim") or string.find(teamName, "robber") or string.find(teamName, "bandit") then return true end
        local redList = {"Bright red", "Really red", "Scarlet", "Persimmon", "Dusty Rose"}
        for _, v in pairs(redList) do if color == v then return true end end
        return false
    end

    local function getCriminalNames()
        local names = {}
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and isCriminal(p) then table.insert(names, p.Name) end
        end
        if #names == 0 then table.insert(names, "ไม่พบโจรในเซิร์ฟ") end
        return names
    end

    local Tab = Window:CreateTab("🚨 ล่าโจร", 4483362458)
    local PlayerDropdown = Tab:CreateDropdown({
       Name = "เลือกเป้าหมาย",
       Options = getCriminalNames(),
       CurrentOption = "",
       Callback = function(Option) SelectedTarget = game.Players:FindFirstChild(type(Option) == "table" and Option[1] or Option) end,
    })

    task.spawn(function() while task.wait(3) do pcall(function() PlayerDropdown:Refresh(getCriminalNames(), true) end) end end)

    Tab:CreateButton({
       Name = "🎲 สุ่มเป้าหมายโจรทันที",
       Callback = function()
           local criminals = {}
           for _, p in pairs(game.Players:GetPlayers()) do if p ~= game.Players.LocalPlayer and isCriminal(p) then table.insert(criminals, p) end end
           if #criminals > 0 then
               SelectedTarget = criminals[math.random(1, #criminals)]
               Rayfield:Notify({Title = "MERIDIAN HUB", Content = "ล็อคเป้าหมาย: "..SelectedTarget.Name, Duration = 3})
           else
               Rayfield:Notify({Title = "MERIDIAN HUB", Content = "ตอนนี้ไม่มีโจรให้ล่าเลย", Duration = 3})
           end
       end,
    })

    Tab:CreateToggle({
       Name = "เริ่มการหมุน (Orbit)",
       CurrentValue = false,
       Callback = function(Value)
           Orbiting = Value
           if Orbiting then
               task.spawn(function()
                   while Orbiting do
                       pcall(function()
                           if SelectedTarget and SelectedTarget.Character then
                               local targetRoot = SelectedTarget.Character:FindFirstChild("HumanoidRootPart")
                               local myRoot = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                               if targetRoot and myRoot then
                                   local targetPos = targetRoot.Position
                                   local hum = SelectedTarget.Character:FindFirstChild("Humanoid")
                                   if hum and hum.SeatPart then targetPos = hum.SeatPart.Position end
                                   local time = tick() * Speed
                                   myRoot.CFrame = CFrame.new(targetPos + Vector3.new(math.cos(time) * Radius, Height, math.sin(time) * Radius), targetPos)
                               end
                           end
                       end)
                       task.wait()
                   end
               end)
           end
       end,
    })

    local ConfigTab = Window:CreateTab("⚙️ ปรับค่า", 4483362458)
    ConfigTab:CreateSlider({Name = "ความเร็วหมุน", Range = {1, 100}, Increment = 1, CurrentValue = 10, Callback = function(V) Speed = V end})
    ConfigTab:CreateSlider({Name = "ระยะห่าง", Range = {0, 50}, Increment = 1, CurrentValue = 8, Callback = function(V) Radius = V end})
    ConfigTab:CreateSlider({Name = "ความสูง (ลอยตัว)", Range = {-20, 20}, Increment = 1, CurrentValue = 0, Callback = function(V) Height = V end})

    Rayfield:Notify({Title = "MERIDIAN HUB", Content = "สคริปต์พร้อมใช้งานแล้ว ลุยเลย!", Duration = 5})
end

-- // KEY SYSTEM LOGIC // --
SubmitBtn.MouseButton1Click:Connect(function()
    local cleanKey = KeyInput.Text:gsub("%s+", "")
    if cleanKey == "" then KeyInput.Text = "NEED KEY!" return end
    SubmitBtn.Text = "AUTHENTICATING..."

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
                    LoadMeridianHub() -- เรียกใช้สคริปต์ล่าโจร
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
    GetKeyBtn.Text = "REQUEST KEY [WEBSITE]"
end)

