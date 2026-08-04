-- ==============================================
-- ⚠️ CREDIT PROTECTION
-- ==============================================
local SCRIPT_OWNER = "@meridian_tle"
-- ==============================================

local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
local activeCylinders = {}
local isEnabled = false

local cylinderSize = Vector3.new(6, 4, 4)
local cylinderTransparency = 0
local canCollideEnabled = true

-- สร้าง Collision Group เฉพาะตัวละครและทรงกระบอก เพื่อไม่ให้ไปชนกับกำแพง/สิ่งของ
local groupName = "CustomPlayerCylinders"
pcall(function()
    PhysicsService:RegisterCollisionGroup(groupName)
    PhysicsService:CollisionGroupSetCollidable(groupName, "Default", false)
end)

local function removeCylinder(player)
    if activeCylinders[player] then
        if activeCylinders[player].Part then
            activeCylinders[player].Part:Destroy()
        end
        activeCylinders[player] = nil
    end
end

local function createCylinder(player)
    if not isEnabled then return end
    -- 🛑 เช็กถ้ารู้ว่าเป็นตัวเราเอง (เทียบทั้ง Object และชื่อใน Roblox) ให้ข้ามทันทีไม่สร้าง
    if player == localPlayer or player.Name == "DFGHJKL_782" then 
        return 
    end
    
    removeCylinder(player)

    local character = player.Character
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local cylinder = Instance.new("Part")
    cylinder.Name = "GlobalPersistentCylinder"
    cylinder.Shape = Enum.PartType.Cylinder
    cylinder.Size = cylinderSize
    cylinder.BrickColor = BrickColor.new("Bright red")
    cylinder.CanCollide = canCollideEnabled
    cylinder.Transparency = cylinderTransparency
    cylinder.Anchored = false
    
    pcall(function()
        cylinder.CollisionGroup = groupName
    end)

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = root
    weld.Part1 = cylinder
    weld.Parent = cylinder

    cylinder.CFrame = root.CFrame * CFrame.Angles(0, 0, math.rad(90))
    cylinder.Parent = character

    activeCylinders[player] = {
        Part = cylinder,
        Root = root
    }

    character.ChildRemoved:Connect(function(child)
        if child.Name == "HumanoidRootPart" then
            removeCylinder(player)
        end
    end)
end

local function updateAllCylinders()
    for player, data in pairs(activeCylinders) do
        if data.Part and data.Part.Parent then
            data.Part.Size = cylinderSize
            data.Part.Transparency = cylinderTransparency
            data.Part.CanCollide = canCollideEnabled
        end
    end
end

local function createControlGui()
    if CoreGui:FindFirstChild("GlobalCylinderGui") then
        CoreGui.GlobalCylinderGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GlobalCylinderGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = CoreGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 260, 0, 310)
    mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.Font = Enum.Font.SourceSansBold
    title.Text = "Cylinder Control (" .. SCRIPT_OWNER .. ")"
    title.BorderSizePixel = 0
    title.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = title

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
    toggleBtn.Position = UDim2.new(0.05, 0, 0, 45)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 14
    toggleBtn.Font = Enum.Font.SourceSansBold
    toggleBtn.Text = "Status: OFF"
    toggleBtn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = toggleBtn

    local function createInputBox(name, defaultVal, yPos, callback)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, 0, 0, 25)
        label.Position = UDim2.new(0.05, 0, 0, yPos)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.Font = Enum.Font.SourceSans
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Text = name
        label.Parent = mainFrame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.35, 0, 0, 25)
        box.Position = UDim2.new(0.6, 0, 0, yPos)
        box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.TextSize = 14
        box.Font = Enum.Font.SourceSansBold
        box.Text = tostring(defaultVal)
        box.ClearTextOnFocus = false
        box.Parent = mainFrame

        local boxCorner = Instance.new("UICorner")
        boxCorner.CornerRadius = UDim.new(0, 4)
        boxCorner.Parent = box

        box.FocusLost:Connect(function()
            local num = tonumber(box.Text)
            if num then
                callback(num)
            else
                box.Text = tostring(defaultVal)
            end
        end)
    end

    createInputBox("ความยาว (Length):", cylinderSize.X, 90, function(val)
        cylinderSize = Vector3.new(val, cylinderSize.Y, cylinderSize.Z)
        updateAllCylinders()
    end)

    createInputBox("ความกว้าง (Width):", cylinderSize.Y, 125, function(val)
        cylinderSize = Vector3.new(cylinderSize.X, val, cylinderSize.Z)
        updateAllCylinders()
    end)

    createInputBox("ความสูง (Height):", cylinderSize.Z, 160, function(val)
        cylinderSize = Vector3.new(cylinderSize.X, cylinderSize.Y, val)
        updateAllCylinders()
    end)

    createInputBox("ความโปร่งใส (0-1):", cylinderTransparency, 195, function(val)
        cylinderTransparency = math.clamp(val, 0, 1)
        updateAllCylinders()
    end)

    local collideBtn = Instance.new("TextButton")
    collideBtn.Size = UDim2.new(0.9, 0, 0, 30)
    collideBtn.Position = UDim2.new(0.05, 0, 0, 235)
    collideBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    collideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    collideBtn.TextSize = 14
    collideBtn.Font = Enum.Font.SourceSansBold
    collideBtn.Text = "Collide: ON (กันคนทับ)"
    collideBtn.Parent = mainFrame

    local collideCorner = Instance.new("UICorner")
    collideCorner.CornerRadius = UDim.new(0, 6)
    collideCorner.Parent = collideBtn

    collideBtn.MouseButton1Click:Connect(function()
        canCollideEnabled = not canCollideEnabled
        if canCollideEnabled then
            collideBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            collideBtn.Text = "Collide: ON (กันคนทับ)"
        else
            collideBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            collideBtn.Text = "Collide: OFF"
        end
        updateAllCylinders()
    end)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0.9, 0, 0, 25)
    closeBtn.Position = UDim2.new(0.05, 0, 0, 275)
    closeBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 12
    closeBtn.Font = Enum.Font.SourceSans
    closeBtn.Text = "ปิดเมนู UI"
    closeBtn.Parent = mainFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    toggleBtn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        if isEnabled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            toggleBtn.Text = "Status: ON"
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    task.spawn(function() createCylinder(player) end)
                end
            end
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            toggleBtn.Text = "Status: OFF"
            
            for _, player in ipairs(Players:GetPlayers()) do
                removeCylinder(player)
            end
        end
    end)
end

createControlGui()

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if isEnabled then
            task.wait(0.5)
            createCylinder(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeCylinder(player)
end)

for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        if isEnabled then
            task.wait(0.5)
            createCylinder(player)
        end
    end)
end

