local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME สำหรับหน้าคีย์บอส ]] --
local THEME = {
    Main = Color3.fromRGB(0, 10, 0),
    Accent = Color3.fromRGB(50, 150, 255), -- ปรับเป็นโทนฟ้าให้เข้ากับ Meridian Pro
    Secondary = Color3.fromRGB(0, 50, 100),
    Text = Color3.fromRGB(255, 255, 255)
}

-- [[ UI SYSTEM: KEY SYSTEM (Alpha Eclipse) ]] --
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
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = THEME.Accent
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "MERIDIAN PRO // SECURE LOGIN"
Title.TextColor3 = THEME.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "ENTER ACCESS KEY..."
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(0, 15, 30)
KeyInput.TextColor3 = THEME.Text
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Text = ""
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", MainFrame)
SubmitBtn.Text = "AUTHENTICATE"
SubmitBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.BackgroundColor3 = THEME.Accent
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
SubmitBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", SubmitBtn)

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Text = "GET KEY FROM WEBSITE"
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = THEME.Secondary
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 11

-- [[ ฟังก์ชั่นโหลดเมนูหลัก MERIDIAN PRO (Rayfield) ]] --
local function LoadMeridianPro()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "🚀 MERIDIAN PRO V1 | OPTIMIZER",
        LoadingTitle = "Starting Meridian Systems...",
        LoadingSubtitle = "by THE CREATOR",
        KeySystem = false 
    })

    -- TAB 1: FPS BOOST
    local Tab1 = Window:CreateTab("⚡ Boost", 4483362458)
    Tab1:CreateSection("Performance Fixes")
    
    Tab1:CreateToggle({
        Name = "Potato Mode (ลบ Texture)",
        CurrentValue = false,
        Callback = function(Value)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Value and Enum.Material.SmoothPlastic or Enum.Material.Plastic
                elseif v:IsA("Decal") then v.Transparency = Value and 1 or 0 end
            end
        end,
    })

    Tab1:CreateToggle({
        Name = "Remove Shadows (ลบเงา)",
        CurrentValue = false,
        Callback = function(Value) Lighting.GlobalShadows = not Value end,
    })

    -- TAB 2: UTILITY
    local Tab2 = Window:CreateTab("🛠️ Utility", 4483362458)
    Tab2:CreateSlider({
        Name = "Field of View",
        Range = {30, 120},
        Increment = 1,
        CurrentValue = 70,
        Callback = function(Value) workspace.CurrentCamera.FieldOfView = Value end,
    })

    Tab2:CreateToggle({
        Name = "Full Brightness",
        CurrentValue = false,
        Callback = function(Value)
            Lighting.Brightness = Value and 3 or 1
            Lighting.ClockTime = Value and 14 or 12
        end,
    })

    -- TAB 3: INFO
    local Tab3 = Window:CreateTab("ℹ️ Info", 4483362458)
    local InfoParagraph = Tab3:CreateParagraph({Title = "System Stats", Content = "Calculating..."})

    task.spawn(function()
        while task.wait(0.5) do
            local fps = math.floor(1/RunService.RenderStepped:Wait())
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            InfoParagraph:Set({
                Title = "💻 System Stats",
                Content = string.format("FPS: %d\nPING: %s\nVERSION: MERIDIAN PRO V1", fps, ping)
            })
        end
    end)

    Rayfield:Notify({Title = "MERIDIAN PRO", Content = "ระบบโหลดเสร็จสมบูรณ์!", Duration = 5})
end

-- [[ ระบบตรวจสอบคีย์ ]] --
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
            SubmitBtn.Text = "AUTHENTICATE"
        else
            local data = HttpService:JSONDecode(response.Body)
            if (os.time() * 1000) < data.expires then
                SubmitBtn.Text = "SUCCESS"
                task.wait(0.5)
                local tw = TweenService:Create(AnimFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), Rotation = 180})
                tw:Play()
                tw.Completed:Connect(function()
                    ScreenGui:Destroy()
                    LoadMeridianPro()
                end)
            else
                KeyInput.Text = "KEY EXPIRED!"
            end
        end
    else
        KeyInput.Text = "ERROR!"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://hfutposhdhehheh-source.github.io/The-Creator-Key-System/")
    GetKeyBtn.Text = "COPIED!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY FROM WEBSITE"
end)

