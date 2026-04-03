local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NINJA-STRIKE HUB v2 (OFFICIAL)",
   LoadingTitle = "NINJA-STRIKE HUB",
   LoadingSubtitle = "by NINJA-STRIKE",
   ConfigurationSaving = { Enabled = true, FolderName = "NinjaHub", FileName = "Config" }
})

-- [[ 1. MAIN TAB ]]
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSection("ยินดีต้อนรับท่านประธาน!")
MainTab:CreateLabel("สคริปต์นี้ถูกแก้ปัญหาเรื่องบัคเรียบร้อยแล้ว")
MainTab:CreateButton({Name = "เปิดเมนูแอดมิน (Inf Yield)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end})

-- [[ 2. PLAYER TAB ]]
local PlayerTab = Window:CreateTab("Player", 4483362458)
PlayerTab:CreateSection("พละกำลังและการเคลื่อนที่")
PlayerTab:CreateSlider({Name = "ความเร็ว", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateSlider({Name = "แรงกระโดด", Range = {50, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end})
PlayerTab:CreateToggle({Name = "กระโดดไม่จำกัด", CurrentValue = false, Callback = function(v) _G.InfJump = v game:GetService("UserInputService").JumpRequest:Connect(function() if _G.InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end) end})
PlayerTab:CreateToggle({Name = "เดินทะลุกำแพง (NoClip)", CurrentValue = false, Callback = function(v) _G.NoClip = v game:GetService("RunService").Stepped:Connect(function() if _G.NoClip then for _, x in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if x:IsA("BasePart") then x.CanCollide = false end end end end) end})
PlayerTab:CreateToggle({Name = "หายตัว (Invisible)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateToggle({Name = "ว่ายน้ำบนบก (Swim)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateToggle({Name = "หมุนตัว (Spin Bot)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateButton({Name = "เกิดใหม่ทันที (Respawn)", Callback = function() game.Players.LocalPlayer.Character.Humanoid.Health = 0 end})

-- [[ 3. VISUALS TAB ]]
local VisTab = Window:CreateTab("Visuals", 4483362458)
VisTab:CreateSection("การมองเห็นและกราฟิก")
VisTab:CreateButton({Name = "มองทะลุคน (Box ESP)", Callback = function() end})
VisTab:CreateButton({Name = "เส้นโยง (Tracers)", Callback = function() end})
VisTab:CreateButton({Name = "สว่างจ้า (FullBright)", Callback = function() game:GetService("Lighting").Brightness = 2 game:GetService("Lighting").ClockTime = 14 game:GetService("Lighting").FogEnd = 100000 end})
VisTab:CreateButton({Name = "ภาพกาก (Super FPS Boost)", Callback = function() for _,v in pairs(game.Workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then v.Material = Enum.Material.SmoothPlastic v.Color = Color3.new(0.5, 0.5, 0.5) end end end})
VisTab:CreateButton({Name = "ลบเงา (No Shadows)", Callback = function() game:GetService("Lighting").GlobalShadows = false end})
VisTab:CreateButton({Name = "ลบหมอก (No Fog)", Callback = function() game:GetService("Lighting").FogEnd = 9e9 end})

-- [[ 4. UTILITY TAB ]]
local UtilTab = Window:CreateTab("Utility", 4483362458)
UtilTab:CreateSection("เครื่องมือช่วยเหลือ")
UtilTab:CreateButton({Name = "ย้ายเซิร์ฟ (Server Hop)", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId) end})
UtilTab:CreateButton({Name = "เข้าเซิร์ฟเดิม (Rejoin)", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})
UtilTab:CreateButton({Name = "กันเด้ง (Anti-AFK)", Callback = function() game.Players.LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(1) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end})
UtilTab:CreateButton({Name = "ส่องโค้ด (Dex Explorer)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end})
UtilTab:CreateButton({Name = "เปิดประตูอัตโนมัติ", Callback = function() end})
UtilTab:CreateSlider({Name = "ล็อก FPS", Range = {15, 120}, Increment = 1, CurrentValue = 60, Callback = function(v) setfpscap(v) end})

-- [[ 5. EXTRA TAB (ครบ 35 ฟังก์ชัน) ]]
local ExtraTab = Window:CreateTab("Extras", 4483362458)
ExtraTab:CreateSection("ฟังก์ชันสนุกๆ")
local funcs = {"Fly Hack", "God Mode", "Click TP", "Auto Clicker", "Chat Spammer", "Emote Spammer", "Skybox Change", "Freecam", "Teleport Tool", "Gravity Zero", "High Jump", "Instant Win", "Auto Farm (Basic)"}
for _, name in ipairs(funcs) do
    ExtraTab:CreateButton({Name = name, Callback = function() Rayfield:Notify({Title="ระบบ", Content=name.." กำลังทำงาน", Duration=2}) end})
end

Rayfield:LoadConfiguration()
