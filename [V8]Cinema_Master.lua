local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME สำหรับหน้าคีย์บอส ]] --
local THEME = {
    Main = Color3.fromRGB(15, 15, 15),
    Accent = Color3.fromRGB(89, 31, 154), -- สีม่วง Cinema พรีเมียม
    Secondary = Color3.fromRGB(50, 20, 100),
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
Stroke.Thickness = 2.5

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "CINEMA HUB // ACCESS"
Title.TextColor3 = THEME.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "ENTER CINEMA KEY..."
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyInput.TextColor3 = THEME.Text
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.Text = ""
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", MainFrame)
SubmitBtn.Text = "LOG IN"
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

-- [[ ฟังก์ชั่นโหลดเมนูหลัก CINEMA HUB (Rayfield) ]] --
local function LoadCinemaHub()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Camera = workspace.CurrentCamera
    local Player = Players.LocalPlayer
    local active = false
    local speed = 1.00
    local cameraRot = Vector2.new(0, 0)
    local moveVector = Vector3.new(0, 0, 0)

    -- Window Setup
    local Window = Rayfield:CreateWindow({
        Name = "📽️ CINEMA HUB V8.1 | SPEED EDITION",
        LoadingTitle = "กำลังจัดเตรียมอุปกรณ์กองถ่าย...",
        LoadingSubtitle = "by THE CREATOR",
        KeySystem = false
    })

    -- TAB 1: CAMERA CONTROL
    local Tab1 = Window:CreateTab("🎥 Camera", 4483362458)
    Tab1:CreateSection("Freecam System")

    Tab1:CreateToggle({
        Name = "FREECAM (โหมดอิสระ)",
        CurrentValue = false,
        Callback = function(Value)
            active = Value
            if active then 
                Camera.CameraType = Enum.CameraType.Scriptable
                if Player.Character then Player.Character.PrimaryPart.Anchored = true end
            else 
                Camera.CameraType = Enum.CameraType.Custom
                if Player.Character then Player.Character.PrimaryPart.Anchored = false end
            end
        end,
    })

    Tab1:CreateSlider({
        Name = "Movement Speed (ความเร็วคลาเมร่า)",
        Range = {0.01, 100},
        Increment = 0.05,
        Suffix = " Speed",
        CurrentValue = 1.00,
        Callback = function(Value)
            speed = Value
        end,
    })

    Tab1:CreateSection("Recording Tools")
    Tab1:CreateButton({
        Name = "Hide GUI (Record Mode)",
        Callback = function()
            Rayfield:Notify({Title = "RECORD MODE", Content = "เมนูจะหายไปเพื่อเริ่มการถ่ายทำ", Duration = 3})
            task.wait(1)
            Rayfield:Destroy() -- ลบ UI ทั้งหมดออกเพื่อความคลีน
        end,
    })

    -- TAB 2: GRAPHICS
    local Tab2 = Window:CreateTab("✨ Graphics", 4483362458)
    
    local function ClearEffects()
        for _, v in pairs(Lighting:GetChildren()) do if v:IsA("PostProcessEffect") then v:Destroy() end end
        Lighting.Brightness = 2
    end

    Tab2:CreateButton({
        Name = "SMOOTH (LV 1)",
        Callback = function()
            ClearEffects()
            Lighting.Brightness = 2.5
        end,
    })

    Tab2:CreateButton({
        Name = "ULTRA HD (LV 2)",
        Callback = function()
            ClearEffects()
            local b = Instance.new("BloomEffect", Lighting); b.Intensity = 0.5
            local s = Instance.new("SunRaysEffect", Lighting); s.Intensity = 0.1
        end,
    })

    Tab2:CreateButton({
        Name = "CINEMATIC RT (LV 3)",
        Callback = function()
            ClearEffects()
            Lighting.GlobalShadows = true
            local b = Instance.new("BloomEffect", Lighting); b.Intensity = 1
            local c = Instance.new("ColorCorrectionEffect", Lighting); c.Contrast = 0.25; c.Saturation = 0.2
            local s = Instance.new("SunRaysEffect", Lighting); s.Intensity = 0.2
            if workspace.Terrain then workspace.Terrain.WaterReflection = 1 end
        end,
    })

    Tab2:CreateButton({
        Name = "RESET ALL GRAPHICS",
        Callback = function() ClearEffects() end,
    })

    -- Logic Movement (Freecam)
    RunService.RenderStepped:Connect(function()
        if active then
            -- การหมุนกล้องสำหรับ Mobile/PC
            local rot = CFrame.Angles(0, math.rad(cameraRot.X), 0) * CFrame.Angles(math.rad(cameraRot.Y), 0, 0)
            Camera.CFrame = CFrame.new(Camera.CFrame.Position) * rot
            -- หมายเหตุ: สามารถปรับแต่ง moveVector เพิ่มเติมตามปุ่มกดได้ครับ
        end
    end)

    Rayfield:Notify({Title = "READY", Content = "เริ่มการถ่ายทำได้เลยครับ!", Duration = 5})
end

-- [[ ระบบตรวจสอบคีย์ ]] --
SubmitBtn.MouseButton1Click:Connect(function()
    local cleanKey = KeyInput.Text:gsub("%s+", "")
    if cleanKey == "" then KeyInput.Text = "ใส่คีย์ด้วยครับ!" return end
    SubmitBtn.Text = "CHECKING..."

    local success, response = pcall(function()
        return HttpService:RequestAsync({Url = _URL .. cleanKey .. ".json", Method = "GET"})
    end)

    if success and response.Success then
        if response.Body == "null" then
            KeyInput.Text = "คีย์ผิดครับ!"
            SubmitBtn.Text = "LOG IN"
        else
            local data = HttpService:JSONDecode(response.Body)
            if (os.time() * 1000) < data.expires then
                SubmitBtn.Text = "ผ่านครับ!"
                task.wait(0.5)
                local tw = TweenService:Create(AnimFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), Rotation = 180})
                tw:Play()
                tw.Completed:Connect(function()
                    ScreenGui:Destroy()
                    LoadCinemaHub()
                end)
            else
                KeyInput.Text = "คีย์หมดอายุ!"
            end
        end
    else
        KeyInput.Text = "เน็ตมีปัญหาครับ!"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://hfutposhdhehheh-source.github.io/The-Creator-Key-System/")
    GetKeyBtn.Text = "COPIED!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY FROM WEBSITE"
end)

