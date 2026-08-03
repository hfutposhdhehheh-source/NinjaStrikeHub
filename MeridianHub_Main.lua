-- ============================================================
-- ===== Meridian Hub - Ultimate Full Version (Rayfield UI) ===
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ===== SETTINGS =====
local Settings = {
    Aimbot = false,
    TeamCheck = true,
    WallCheck = true,
    FOVCircle = false,
    LockFOV = true,
    EnableHitbox = false,
    TargetPart = "Head",
    FOVRadius = 100,
    Smoothness = 0.15,
    HitboxSize = 10,
    HitboxTransparency = 0.4,
    
    ESPEnabled = false,
    ESPName = true,
    ESPDistance = true,
    SkeletonESP = false,
    RainbowESP = false,
    RainbowSpeed = 1,
    
    NoClip = false,
    InfJump = false,
    WalkSpeed = 16,
    
    Spectate = false,
    SelectedPlayer = "",
}

local rainbowHue = 0
local stored = {}
local espData = {}
local skeletonData = {}

-- ===== FOV CIRCLE =====
local fovCircle = Drawing.new("Circle")
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 2
fovCircle.NumSides = 100
fovCircle.Radius = Settings.FOVRadius
fovCircle.Filled = false
fovCircle.Visible = false

-- สร้าง Window หลัก
local Window = Rayfield:CreateWindow({
   Name = "Meridian Hub 🌌",
   LoadingTitle = "Meridian Hub is Loading...",
   LoadingSubtitle = "The most handsome man",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MeridianHub",
      FileName = "MainConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "dJJ3psbAxw",
      RememberJoins = true
   },
   KeySystem = false,
})

-- ============================================================
-- ===== TABS =================================================
-- ============================================================

local CombatTab = Window:CreateTab("Combat", "sword")
local VisualsTab = Window:CreateTab("Visuals", "eye")
local PlayerTab = Window:CreateTab("Player", "user")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- ============================================================
-- ===== COMBAT TAB ===========================================
-- ============================================================

CombatTab:CreateToggle({
   Name = "Aimbot",
   CurrentValue = Settings.Aimbot,
   Flag = "Aimbot",
   Callback = function(Value) Settings.Aimbot = Value end,
})

CombatTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = Settings.TeamCheck,
   Flag = "TeamCheck",
   Callback = function(Value) Settings.TeamCheck = Value end,
})

CombatTab:CreateToggle({
   Name = "Wall Check",
   CurrentValue = Settings.WallCheck,
   Flag = "WallCheck",
   Callback = function(Value) Settings.WallCheck = Value end,
})

CombatTab:CreateToggle({
   Name = "FOV Circle",
   CurrentValue = Settings.FOVCircle,
   Flag = "FOVCircle",
   Callback = function(Value) Settings.FOVCircle = Value end,
})

CombatTab:CreateToggle({
   Name = "Lock FOV To Center",
   CurrentValue = Settings.LockFOV,
   Flag = "LockFOV",
   Callback = function(Value) Settings.LockFOV = Value end,
})

CombatTab:CreateToggle({
   Name = "Hitbox Expander",
   CurrentValue = Settings.EnableHitbox,
   Flag = "EnableHitbox",
   Callback = function(Value) Settings.EnableHitbox = Value end,
})

CombatTab:CreateDropdown({
   Name = "Target Part",
   Options = {"Head", "HumanoidRootPart", "Left Arm", "Right Arm"},
   CurrentOption = Settings.TargetPart,
   Flag = "TargetPart",
   Callback = function(Option) Settings.TargetPart = Option[1] end,
})

CombatTab:CreateSlider({
   Name = "FOV Radius",
   Range = {0, 300},
   Increment = 1,
   CurrentValue = Settings.FOVRadius,
   Flag = "FOVRadius",
   Callback = function(Value)
      Settings.FOVRadius = Value
      fovCircle.Radius = Value
   end,
})

CombatTab:CreateSlider({
   Name = "Smoothness",
   Range = {0, 1},
   Increment = 0.05,
   CurrentValue = Settings.Smoothness,
   Flag = "Smoothness",
   Callback = function(Value) Settings.Smoothness = Value end,
})

CombatTab:CreateSlider({
   Name = "Hitbox Size",
   Range = {2, 50},
   Increment = 1,
   CurrentValue = Settings.HitboxSize,
   Flag = "HitboxSize",
   Callback = function(Value) Settings.HitboxSize = Value end,
})

CombatTab:CreateSlider({
   Name = "Hitbox Transparency",
   Range = {0, 1},
   Increment = 0.05,
   CurrentValue = Settings.HitboxTransparency,
   Flag = "HitboxTransparency",
   Callback = function(Value) Settings.HitboxTransparency = Value end,
})

-- ============================================================
-- ===== VISUALS TAB ==========================================
-- ============================================================

VisualsTab:CreateToggle({
   Name = "ESP",
   CurrentValue = Settings.ESPEnabled,
   Flag = "ESPEnabled",
   Callback = function(Value) Settings.ESPEnabled = Value end,
})

VisualsTab:CreateToggle({
   Name = "Show Name",
   CurrentValue = Settings.ESPName,
   Flag = "ESPName",
   Callback = function(Value) Settings.ESPName = Value end,
})

VisualsTab:CreateToggle({
   Name = "Show Distance",
   CurrentValue = Settings.ESPDistance,
   Flag = "ESPDistance",
   Callback = function(Value) Settings.ESPDistance = Value end,
})

VisualsTab:CreateToggle({
   Name = "Skeleton ESP",
   CurrentValue = Settings.SkeletonESP,
   Flag = "SkeletonESP",
   Callback = function(Value) Settings.SkeletonESP = Value end,
})

VisualsTab:CreateToggle({
   Name = "Rainbow ESP",
   CurrentValue = Settings.RainbowESP,
   Flag = "RainbowESP",
   Callback = function(Value) Settings.RainbowESP = Value end,
})

VisualsTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = Settings.WalkSpeed,
   Flag = "WalkSpeed",
   Callback = function(Value) Settings.WalkSpeed = Value end,
})

VisualsTab:CreateSlider({
   Name = "Rainbow Speed",
   Range = {0.1, 3},
   Increment = 0.1,
   CurrentValue = Settings.RainbowSpeed,
   Flag = "RainbowSpeed",
   Callback = function(Value) Settings.RainbowSpeed = Value end,
})

-- ============================================================
-- ===== PLAYER TAB ===========================================
-- ============================================================

local playerNames = {}
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then table.insert(playerNames, p.Name) end
end

local playerDropdown = PlayerTab:CreateDropdown({
   Name = "Select Player",
   Options = playerNames,
   CurrentOption = playerNames[1] or "",
   Flag = "SelectedPlayer",
   Callback = function(Option) Settings.SelectedPlayer = Option[1] end,
})

PlayerTab:CreateButton({
   Name = "🔄 Refresh Player List",
   Callback = function()
      playerNames = {}
      for _, p in pairs(Players:GetPlayers()) do
          if p ~= LocalPlayer then table.insert(playerNames, p.Name) end
      end
      playerDropdown:Refresh(playerNames, true)
   end,
})

PlayerTab:CreateToggle({
   Name = "Spectate Player",
   CurrentValue = Settings.Spectate,
   Flag = "Spectate",
   Callback = function(Value) Settings.Spectate = Value end,
})

PlayerTab:CreateButton({
   Name = "🚀 Teleport to Player",
   Callback = function()
      local target = Players:FindFirstChild(Settings.SelectedPlayer)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
          local char = LocalPlayer.Character
          if char then char:SetPrimaryPartCFrame(target.Character.HumanoidRootPart.CFrame) end
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "NoClip",
   CurrentValue = Settings.NoClip,
   Flag = "NoClip",
   Callback = function(Value) Settings.NoClip = Value end,
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = Settings.InfJump,
   Flag = "InfJump",
   Callback = function(Value) Settings.InfJump = Value end,
})

-- ============================================================
-- ===== SETTINGS TAB =========================================
-- ============================================================

SettingsTab:CreateButton({
   Name = "📋 Copy Discord Invite",
   Callback = function()
      pcall(function() setclipboard("https://discord.gg/8WYzM2TZ8K") end)
      Rayfield:Notify({ Title = "Meridian Hub", Content = "Discord link copied!", Duration = 3, Image = 4483362458 })
   end,
})

-- ============================================================
-- ===== BACKEND LOGIC (FULL SOURCE TRANSFER) =================
-- ============================================================

-- Bones Mapping
local bonesR15 = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}

local bonesR6 = {
    {"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"},
    {"Torso", "Left Leg"}, {"Torso", "Right Leg"},
}

local function createSkeletonLines()
    local lines = {}
    for i = 1, 14 do
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Color = Color3.fromRGB(255, 255, 255)
        line.Transparency = 1
        line.Visible = false
        table.insert(lines, line)
    end
    return lines
end

local function createSkeleton(player)
    if player == LocalPlayer or skeletonData[player] then return end
    skeletonData[player] = createSkeletonLines()
end

local function removeSkeleton(player)
    if skeletonData[player] then
        for _, line in pairs(skeletonData[player]) do line:Remove() end
        skeletonData[player] = nil
    end
end

local function createESP(player)
    if player == LocalPlayer or espData[player] then return end
    local text = Drawing.new("Text")
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Visible = false
    espData[player] = text
end

local function removeESP(player)
    if espData[player] then
        espData[player]:Remove()
        espData[player] = nil
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
        createSkeleton(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    createESP(player)
    createSkeleton(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        removeESP(player)
        removeSkeleton(player)
        createESP(player)
        createSkeleton(player)
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
    removeSkeleton(player)
end)

-- FOV Circle Position & Update
RunService.RenderStepped:Connect(function()
    fovCircle.Visible = Settings.FOVCircle
    if Settings.LockFOV then
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        fovCircle.Position = UserInputService:GetMouseLocation()
    end
end)

local function GetPart(char, name)
    if name == "Left Arm" then
        return char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftHand") or char:FindFirstChild("LeftUpperArm")
    elseif name == "Right Arm" then
        return char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand") or char:FindFirstChild("RightUpperArm")
    else
        return char:FindFirstChild(name)
    end
end

local function IsVisible(part)
    if not Settings.WallCheck then return true end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = {LocalPlayer.Character, part.Parent}
    params.IgnoreWater = true
    return not workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
end

-- Aimbot Execution
RunService.RenderStepped:Connect(function()
    if not Settings.Aimbot then return end
    local closest, dist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if Settings.TeamCheck and plr.Team == LocalPlayer.Team then continue end
            local part = GetPart(plr.Character, Settings.TargetPart)
            if part and IsVisible(part) then
                local pos, vis = Camera:WorldToViewportPoint(part.Position)
                local diff = (Vector2.new(pos.X, pos.Y) - fovCircle.Position).Magnitude
                if vis and diff < fovCircle.Radius and diff < dist then
                    closest, dist = plr, diff
                end
            end
        end
    end
    if closest and closest.Character then
        local part = GetPart(closest.Character, Settings.TargetPart)
        if part then
            local dir = (part.Position - Camera.CFrame.Position).Unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Camera.CFrame.LookVector:Lerp(dir, Settings.Smoothness))
        end
    end
end)

-- Hitbox Expander Logic
RunService.Heartbeat:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if Settings.EnableHitbox then
                    if not stored[plr] then
                        stored[plr] = { Size = root.Size, Transparency = root.Transparency, Material = root.Material, Color = root.Color }
                    end
                    root.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    root.Transparency = Settings.HitboxTransparency
                    root.Material = Enum.Material.Neon
                    root.Color = Color3.fromRGB(255, 0, 0)
                    root.CanCollide = false
                else
                    if stored[plr] then
                        root.Size = stored[plr].Size
                        root.Transparency = stored[plr].Transparency
                        root.Material = stored[plr].Material
                        root.Color = stored[plr].Color
                        stored[plr] = nil
                    end
                end
            end
        end
    end
end)

-- Standard ESP & Skeleton & Rainbow Rendering
RunService.RenderStepped:Connect(function()
    -- ESP Text
    for player, text in pairs(espData) do
        if not Settings.ESPEnabled then
            text.Visible = false
            continue
        end
        local char = player.Character
        if not char then text.Visible = false continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then text.Visible = false continue end
        local pos, vis = Camera:WorldToViewportPoint(root.Position)
        if not vis then text.Visible = false continue end
        
        local label = ""
        if Settings.ESPName then label = player.Name .. " " end
        if Settings.ESPDistance and LocalPlayer.Character then
            local lroot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if lroot then
                local dist = (lroot.Position - root.Position).Magnitude
                label = label .. "[" .. math.floor(dist) .. "m]"
            end
        end
        text.Text = label
        text.Position = Vector2.new(pos.X, pos.Y - 30)
        text.Visible = true
    end

    -- Skeleton ESP
    for player, lines in pairs(skeletonData) do
        if not Settings.SkeletonESP then
            for _, line in pairs(lines) do line.Visible = false end
            continue
        end
        local char = player.Character
        if not char then
            for _, line in pairs(lines) do line.Visible = false end
            continue
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            for _, line in pairs(lines) do line.Visible = false end
            continue
        end

        local color = Settings.RainbowESP and Color3.fromHSV(rainbowHue, 1, 1) or Color3.fromRGB(255, 0, 0)
        local useBones = (char:FindFirstChild("Torso") and not char:FindFirstChild("UpperTorso")) and bonesR6 or bonesR15

        for i, bone in pairs(useBones) do
            local p1 = char:FindFirstChild(bone[1])
            local p2 = char:FindFirstChild(bone[2])
            if p1 and p2 and lines[i] then
                local pos1, on1 = Camera:WorldToViewportPoint(p1.Position)
                local pos2, on2 = Camera:WorldToViewportPoint(p2.Position)
                if on1 and on2 then
                    lines[i].From = Vector2.new(pos1.X, pos1.Y)
                    lines[i].To = Vector2.new(pos2.X, pos2.Y)
                    lines[i].Color = color
                    lines[i].Visible = true
                else
                    lines[i].Visible = false
                end
            else
                if lines[i] then lines[i].Visible = false end
            end
        end
    end
end)

-- Rainbow Hue Loop
RunService.Heartbeat:Connect(function()
    if Settings.RainbowESP then
        rainbowHue = (rainbowHue + (RunService.Heartbeat:Wait() * Settings.RainbowSpeed * 0.5)) % 1
    end
end)

-- WalkSpeed, NoClip & InfJump
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Settings.WalkSpeed end
    end
end)

RunService.Stepped:Connect(function()
    if Settings.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState("Jumping") end
    end
end)

-- Spectate Logic
RunService.RenderStepped:Connect(function()
    if Settings.Spectate then
        local target = Players:FindFirstChild(Settings.SelectedPlayer)
        if target and target.Character then
            local hum = target.Character:FindFirstChildOfClass("Humanoid")
            if hum then Camera.CameraSubject = hum end
        end
    else
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and Camera.CameraSubject ~= hum then Camera.CameraSubject = hum end
        end
    end
end)

Rayfield:Notify({ Title = "Meridian Hub Loaded", Content = "Full features transferred & ready!", Duration = 5, Image = 4483362458 })

