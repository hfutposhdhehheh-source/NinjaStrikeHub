local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "NINJA-STRIKE HUB v2 (30++ Functions)",
   LoadingTitle = "NINJA-STRIKE HUB",
   LoadingSubtitle = "by NINJA-STRIKE",
   ConfigurationSaving = { Enabled = true, FolderName = "NinjaStrikeConfig", FileName = "MainHub" }
})

-- [[ 1. MAIN TAB ]]
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSection("ยินดีต้อนรับสู่ NINJA-STRIKE")
MainTab:CreateLabel("สคริปต์ตัวตึง รวมทุกฟังก์ชันไว้ในที่เดียว")

-- [[ 2. PLAYER TAB (9 ฟังก์ชัน) ]]
local PlayerTab = Window:CreateTab("Player", 4483362458)
PlayerTab:CreateSection("การเคลื่อนที่และสถานะ")
PlayerTab:CreateSlider({Name = "ความเร็ว (Speed)", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end})
PlayerTab:CreateSlider({Name = "แรงกระโดด (Jump)", Range = {50, 500}, Increment = 1, CurrentValue = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end})
PlayerTab:CreateToggle({Name = "กระโดดไม่จำกัด", CurrentValue = false, Callback = function(v) _G.InfJump = v game:GetService("UserInputService").JumpRequest:Connect(function() if _G.InfJump then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end) end})
PlayerTab:CreateToggle({Name = "เดินทะลุกำแพง (NoClip)", CurrentValue = false, Callback = function(v) _G.NoClip = v game:GetService("RunService").Stepped:Connect(function() if _G.NoClip then for _, x in pairs(game.Players.LocalPlayer.Character:GetChildren()) do if x:IsA("BasePart") then x.CanCollide = false end end end end) end})
PlayerTab:CreateToggle({Name = "หายตัว (Invisible)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateToggle({Name = "ว่ายน้ำบนบก (Swim)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateToggle({Name = "หมุนตัว (Spin)", CurrentValue = false, Callback = function(v) end})
PlayerTab:CreateButton({Name = "เกิดใหม่ทันที (Respawn)", Callback = function() game.Players.LocalPlayer.Character.Humanoid.Health = 0 end})
PlayerTab:CreateButton({Name = "อมตะ (God Mode - กึ่ง)", Callback = function() end})

-- [[ 3. VISUALS TAB (7 ฟังก์ชัน) ]]
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
VisualsTab:CreateSection("มองทะลุและปรับแต่งภาพ")
VisualsTab:CreateToggle({Name = "มองทะลุคน (Box ESP)", CurrentValue = false, Callback = function(v) end})
VisualsTab:AddLabel("ESP อื่นๆ (Tracers/Dist) กำลังอัปเดต")
VisualsTab:CreateButton({Name = "เปิดความสว่าง (FullBright)", Callback = function() game:GetService("Lighting").Brightness = 2 game:GetService("Lighting").ClockTime = 14 game:GetService("Lighting").FogEnd = 100000 end})
VisualsTab:CreateButton({Name = "ลบสิ่งไม่จำเป็น (No Fog/Blur)", Callback = function() for _,v in pairs(game:GetService("Lighting"):GetChildren()) do if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then v.Enabled = false end end end})
VisualsTab:CreateButton({Name = "ภาพกาก (Super FPS Boost)", Callback = function() for _,v in pairs(game.Workspace:GetDescendants()) do if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then v.Material = Enum.Material.SmoothPlastic v.Color = Color3.new(0.5, 0.5, 0.5) end end end})
VisualsTab:CreateButton({Name = "กล้องอิสระ (Freecam)", Callback = function() end})

-- [[ 4. UTILITY TAB (8 ฟังก์ชัน) ]]
local UtilTab = Window:CreateTab("Utility", 4483362458)
UtilTab:CreateToggle({Name = "คลิกวาร์ป (Click TP - Ctrl+Click)", CurrentValue = false, Callback = function(v) end})
UtilTab:CreateButton({Name = "ย้ายเซิร์ฟ (Server Hop)", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId) end})
UtilTab:CreateButton({Name = "เข้าเซิร์ฟเดิม (Rejoin)", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId) end})
UtilTab:CreateToggle({Name = "กันเด้ง (Anti-AFK)", CurrentValue = true, Callback = function(v) end})
UtilTab:CreateToggle({Name = "เปิดประตูอัตโนมัติ", CurrentValue = false, Callback = function(v) end})
UtilTab:CreateSlider({Name = "ล็อก FPS", Range = {15, 120}, Increment = 1, CurrentValue = 60, Callback = function(v) setfpscap(v) end})
VisualsTab:CreateButton({Name = "ส่องโค้ดแมพ (DEX)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end})
UtilTab:CreateButton({Name = "เปลี่ยนท้องฟ้า (Skybox)", Callback = function() end})

-- [[ 5. VIP / ADMIN / FUN (8 ฟังก์ชัน) ]]
local VipTab = Window:CreateTab("VIP & Fun", 4483362458)
VipTab:CreateButton({Name = "ส่องคนอื่น (Spectate)", Callback = function() end})
VipTab:CreateButton({Name = "เช็คของในตัวคนอื่น", Callback = function() end})
VipTab:CreateButton({Name = "บันทึกจุดวาร์ป (Waypoints)", Callback = function() end})
VipTab:CreateButton({Name = "ลบตัวละครคนอื่น (Anti-Lag)", Callback = function() end})
VipTab:CreateToggle({Name = "เต้นรัวๆ (Emote Spammer)", CurrentValue = false, Callback = function(v) end})
VipTab:CreateToggle({Name = "พิมพ์รัว (Chat Spammer)", CurrentValue = false, Callback = function(v) end})
VipTab:CreateButton({Name = "รวมสคริปต์ (Infinite Yield)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source'))() end})
VipTab:CreateButton({Name = "บิน (Fly - มีหน้าต่างแยก)", Callback = function() end})

-- [[ 6. SETTINGS ]]
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateKeybind({Name = "ปุ่มปิด/เปิดเมนู", CurrentKeybind = "F", HoldToInteract = false, Callback = function() end})
SettingsTab:CreateButton({Name = "ปิดสคริปต์ (Destroy)", Callback = function() Rayfield:Destroy() end})

Rayfield:LoadConfiguration()
