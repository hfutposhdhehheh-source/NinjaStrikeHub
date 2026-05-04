local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local _URL = "https://thecreatorkey-32aaf-default-rtdb.firebaseio.com/keys/"

-- [[ CONFIG THEME สำหรับหน้าคีย์บอส ]] --
local THEME = {
    Main = Color3.fromRGB(10, 10, 12),
    Accent = Color3.fromRGB(255, 100, 255), -- สีชมพูม่วงตามสไตล์ Meridian V3
    Secondary = Color3.fromRGB(100, 50, 255),
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
Title.Text = "MERIDIAN V3 // SECURE LOGIN"
Title.TextColor3 = THEME.Accent
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "ใส่คีย์ของเฮียที่นี่..."
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
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
GetKeyBtn.Text = "GET KEY (ของดีต้องของเฮีย)"
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.78, 0)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 35)
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = THEME.Secondary
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 11

-- [[ ฟังก์ชั่นโหลดเมนูหลัก MERIDIAN V3 (Rayfield) ]] --
local function LoadMeridianV3()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "💎 MERIDIAN V3 [ULTIMATE]",
        LoadingTitle = "กำลังโหลดของดี...",
        LoadingSubtitle = "by Meridian_Tle",
        KeySystem = false 
    })

    -- TAB 1: FPS OPTIMIZER
    local Tab1 = Window:CreateTab("⚡ FPS Boost", 4483362458)
    Tab1:CreateSection("V3 Extreme Optimizers")
    
    Tab1:CreateButton({
        Name = "Extreme Low Graphics (V3)",
        Callback = function()
            settings().Rendering.QualityLevel = 1
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") and not v:IsDescendantOf(Players.LocalPlayer.Character) then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                    v.CastShadow = false
                elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v:Destroy()
                end
            end
            Rayfield:Notify({Title = "V3 Status", Content = "ปรับกราฟิกพลาสติกเรียบร้อย!", Duration = 3})
        end,
    })

    Tab1:CreateButton({
        Name = "Remove Clothes (ลด RAM)",
        Callback = function()
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= Players.LocalPlayer and pl.Character then
                    for _, item in pairs(pl.Character:GetChildren()) do
                        if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then item:Destroy() end
                    end
                end
            end
            Rayfield:Notify({Title = "V3 Status", Content = "ลบเสื้อผ้าผู้เล่นอื่นแล้ว!", Duration = 3})
        end,
    })

    Tab1:CreateButton({
        Name = "Extreme FPS Optimizer (Compatibility)",
        Callback = function()
            pcall(function()
                sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
            end)
        end,
    })

    -- TAB 2: CLEANING
    local Tab2 = Window:CreateTab("🧹 Cleaning", 4483362458)
    Tab2:CreateSection("Map Clears")

    Tab2:CreateButton({
        Name = "Extreme Clear (ลบไฟ/น้ำ/หิน)",
        Callback = function()
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then v.Enabled = false end
                if v:IsA("BasePart") and (v.Name:lower():find("water") or v.Name:lower():find("river") or v.Name:lower():find("rock") or v.Name:lower():find("stone") or v.Material == Enum.Material.Slate) then v:Destroy() end
            end
        end,
    })

    Tab2:CreateButton({
        Name = "ล้างหน่วยความจำ (Clean RAM)",
        Callback = function()
            collectgarbage("collect")
            Rayfield:Notify({Title = "System", Content = "ล้าง RAM สำเร็จ!", Duration = 3})
        end,
    })

    -- TAB 3: UTILITY
    local Tab3 = Window:CreateTab("🛠️ Utility", 4483362458)
    
    Tab3:CreateButton({
        Name = "ลบระบบสั่น 100% (Fixed Cam)",
        Callback = function()
            RunService:BindToRenderStep("FixedCam", 201, function()
                if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new(0,0,0)
                end
            end)
        end,
    })

    Tab3:CreateButton({
        Name = "เปิดไฟส่องทาง (FullBright)",
        Callback = function()
            game.Lighting.Brightness = 2
            game.Lighting.ClockTime = 14
            game.Lighting.GlobalShadows = false
            game.Lighting.FogEnd = 9e9
        end,
    })

    -- TAB 4: CREDITS
    local Tab4 = Window:CreateTab("ℹ️ Credits", 4483362458)
    Tab4:CreateParagraph({Title = "Developed by Meridian_Tle", Content = "ของดีต้องของเฮีย!\nTikTok: @meridian_tle"})
    Tab4:CreateButton({
        Name = "คัดลอกลิงก์ TikTok",
        Callback = function()
            setclipboard("https://www.tiktok.com/@meridian_tle")
            Rayfield:Notify({Title = "Copied", Content = "คัดลอกลิงก์ TikTok แล้ว!", Duration = 3})
        end,
    })

    Rayfield:Notify({Title = "MERIDIAN V3", Content = "ยินดีต้อนรับครับ", Duration = 5})
end

-- [[ ระบบตรวจสอบคีย์ Alpha Eclipse ]] --
SubmitBtn.MouseButton1Click:Connect(function()
    local cleanKey = KeyInput.Text:gsub("%s+", "")
    if cleanKey == "" then KeyInput.Text = "ใส่คีย์ด้วยครับ" return end
    SubmitBtn.Text = "กำลังเช็คคีย์"

    local success, response = pcall(function()
        return HttpService:RequestAsync({Url = _URL .. cleanKey .. ".json", Method = "GET"})
    end)

    if success and response.Success then
        if response.Body == "null" then
            KeyInput.Text = "คีย์ผิดนะครับ"
            SubmitBtn.Text = "AUTHENTICATE"
        else
            local data = HttpService:JSONDecode(response.Body)
            if (os.time() * 1000) < data.expires then
                SubmitBtn.Text = "ผ่านแล้วครับ"
                task.wait(0.5)
                local tw = TweenService:Create(AnimFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0), Rotation = 180})
                tw:Play()
                tw.Completed:Connect(function()
                    ScreenGui:Destroy()
                    LoadMeridianV3()
                end)
            else
                KeyInput.Text = "คีย์หมดอายุ!"
            end
        end
    else
        KeyInput.Text = "เน็ตมีปัญหานะครับ"
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://hfutposhdhehheh-source.github.io/The-Creator-Key-System/")
    GetKeyBtn.Text = "ก๊อปลิงก์แล้ว!"
    task.wait(2)
    GetKeyBtn.Text = "GET KEY"
end)
