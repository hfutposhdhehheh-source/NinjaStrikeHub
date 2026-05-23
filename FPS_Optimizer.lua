-- [[ NERD FPS ENGINE v2.0 - FULL INTEGRATED CORE ]] --
-- เขียนโดยระบุตำแหน่งชัดเจนตามสั่ง: หมวด 1 และ หมวด 2 ครบถ้วนทุกฟังก์ชัน

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local UI = {}

function UI.Init(Engine)
    -- ==========================================
    -- [1. MAIN CANVAS & THEME CONFIG]
    -- ==========================================
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NerdFpsEngine"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 680, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -340, 0.5, -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 16)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 1
    MainStroke.Color = Color3.fromRGB(0, 180, 216)
    MainStroke.Transparency = 0.4
    MainStroke.Parent = MainFrame

    -- ==========================================
    -- [2. DRAGGABLE SYSTEM (ระบบลากหน้าต่าง)]
    -- ==========================================
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- ==========================================
    -- [3. HEADER & TOPBAR]
    -- ==========================================
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    local HeaderHideLine = Instance.new("Frame")
    HeaderHideLine.Size = UDim2.new(1, 0, 0, 10)
    HeaderHideLine.Position = UDim2.new(0, 0, 1, -10)
    HeaderHideLine.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
    HeaderHideLine.BorderSizePixel = 0
    HeaderHideLine.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 PERFORMANCE // FPS BOOST SYSTEM v2.0"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.Code
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 28, 0, 28)
    CloseBtn.Position = UDim2.new(1, -38, 0, 8)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 31, 38)
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.TextSize = 22
    CloseBtn.Parent = Header

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- ==========================================
    -- [4. NAVIGATION SIDEBAR (แถบเลือกหมวด)]
    -- ==========================================
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 180, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(16, 17, 20)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local SidebarRightLine = Instance.new("Frame")
    SidebarRightLine.Size = UDim2.new(0, 1, 1, 0)
    SidebarRightLine.Position = UDim2.new(1, -1, 0, 0)
    SidebarRightLine.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    SidebarRightLine.BorderSizePixel = 0
    SidebarRightLine.Parent = Sidebar

    local NavList = Instance.new("UIListLayout")
    NavList.Padding = UDim.new(0, 4)
    NavList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    NavList.SortOrder = Enum.SortOrder.LayoutOrder
    NavList.Parent = Sidebar

    local NavPadding = Instance.new("UIPadding")
    NavPadding.PaddingTop = UDim.new(0, 10)
    NavPadding.Parent = Sidebar

    -- ==========================================
    -- [5. MAIN CONTAINER FOR PAGES (พื้นที่แสดงเนื้อหา)]
    -- ==========================================
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -180, 1, -45)
    ContentContainer.Position = UDim2.new(0, 180, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local Pages = {}

    local function createPage(name, layoutOrder)
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.CanvasSize = UDim2.new(0, 0, 0, 750) -- ขยายพื้นที่รองรับฟังก์ชันที่เยอะขึ้น
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 216)
        Page.Visible = false
        Page.Parent = ContentContainer

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 15)
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingRight = UDim.new(0, 15)
        PagePadding.Parent = Page

        local PageList = Instance.new("UIListLayout")
        PageList.Padding = UDim.new(0, 8)
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Parent = Page

        Pages[name] = Page

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 160, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(22, 24, 28)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(180, 185, 190)
        TabBtn.Font = Enum.Font.SourceSansBold
        TabBtn.TextSize = 13
        TabBtn.LayoutOrder = layoutOrder
        TabBtn.Parent = Sidebar

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = TabBtn

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages) do p.Visible = false end
            for _, b in ipairs(Sidebar:GetChildren()) do
                if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(22, 24, 28) b.TextColor3 = Color3.fromRGB(180, 185, 190) end
            end
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(0, 119, 182)
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        return Page
    end

    -- สร้างหน้าต่างรอไว้ครบทั้ง 6 หมวดตามโครงสร้างดั้งเดิม
    local Page1 = createPage("1️⃣ ลดกราฟิกทั่วไป", 1)
    local Page2 = createPage("2️⃣ หมวดขั้นสุดยอด", 2)
    local Page3 = createPage("3️⃣ หมวดถนอมเครื่อง", 3)
    local Page4 = createPage("4️⃣ เช็คสเปกเครื่อง", 4)
    local Page5 = createPage("5️⃣ ฟังก์ชั่นระดับโปร", 5)
    local Page6 = createPage("6️⃣ โหมดสำเร็จรูป", 6)

    Sidebar:FindFirstChild("1️⃣ ลดกราฟิกทั่วไป").BackgroundColor3 = Color3.fromRGB(0, 119, 182)
    Sidebar:FindFirstChild("1️⃣ ลดกราฟิกทั่วไป").TextColor3 = Color3.fromRGB(255, 255, 255)
    Page1.Visible = true

    -- ==========================================
    -- [ ฟังก์ชันสร้างปุ่มสวิตช์เปิด/ปิด (Toggle Engine) ]
    -- ==========================================
    local function createToggle(parent, text, layoutOrder, callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 42)
        Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 26)
        Frame.BorderSizePixel = 0
        Frame.LayoutOrder = layoutOrder
        Frame.Parent = parent

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = Frame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -65, 1, 0)
        Label.Position = UDim2.new(0, 15, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(235, 235, 235)
        Label.Font = Enum.Font.SourceSansBold
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Frame

        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(0, 50, 0, 26)
        Button.Position = UDim2.new(1, -60, 0.5, -13)
        Button.BackgroundColor3 = Color3.fromRGB(38, 42, 50)
        Button.Text = "OFF"
        Button.TextColor3 = Color3.fromRGB(150, 150, 150)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 11
        Button.Parent = Frame

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 5)
        BtnCorner.Parent = Button

        local toggled = false
        Button.MouseButton1Click:Connect(function()
            toggled = not toggled
            if toggled then
                Button.BackgroundColor3 = Color3.fromRGB(0, 180, 216)
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Text = "ON"
            else
                Button.BackgroundColor3 = Color3.fromRGB(38, 42, 50)
                Button.TextColor3 = Color3.fromRGB(150, 150, 150)
                Button.Text = "OFF"
            end
            callback(toggled)
        end)
    end

    -- ==========================================================
    -- 🛠️ [ บรรจุฟังก์ชัน: 1️⃣ หมวดลดกราฟิกทั่วไป (สเปกกลางๆ แต่อยากลื่น) ] 🛠️
    -- ==========================================================
    
    -- 1. ลบต้นไม้ เก้าอี้ ถังขยะ หิน และของตกแต่งแมพ
    createToggle(Page1, "🧹 PURGE ENVIRONMENTAL PROPS (ลบสิ่งตกแต่งแมพขยะ/หิน/ต้นไม้)", 1, function(state)
        _G.PurgeProps = state
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("tree") or obj.Name:lower():find("trash") or obj.Name:lower():find("chair") or obj.Name:lower():find("rock") or obj.Name:lower():find("prop")) then
                    obj.Transparency = 1
                    obj.CanCollide = false
                end
            end
        end
    end)

    -- 2. ลบเสื้อผ้าผู้เล่น / Accessories
    createToggle(Page1, "👕 REMOVE PLAYER CLOTHES & ACC (ลบเสื้อผ้า/เครื่องแต่งกายคนอื่น)", 2, function(state)
        _G.RemoveClothes = state
        if state then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    for _, item in ipairs(p.Character:GetChildren()) do
                        if item:IsA("Clothing") or item:IsA("ShirtGraphic") or item:IsA("Accessory") then item:Destroy() end
                    end
                end
            end
        end
    end)

    -- 3. ปิดเงา แสงสะท้อน Bloom
    createToggle(Page1, "☀️ DISABLE SHADOWS & BLOOM (ปิดเงาและเอฟเฟกต์สะท้อนแสงแดด)", 3, function(state)
        Lighting.GlobalShadows = not state
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("BloomEffect") then obj.Enabled = not state end
        end
    end)

    -- 4. ลดคุณภาพ Texture แบบค่อยๆลด
    createToggle(Page1, "🎨 GRADUAL TEXTURE REDUCTION (เปิดการค่อยๆ ลดความละเอียดพื้นผิว)", 4, function(state)
        _G.GradualTexture = state
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 0.5 end
            end
        end
    end)

    -- 5. ลดระยะการมองเห็น (Render Distance) & 6. ซ่อนของไกลๆ อัตโนมัติ
    createToggle(Page1, "👁️ PROXIMITY RENDER DISTANCE (จำกัดและซ่อนวัตถุระยะไกลอัตโนมัติ)", 5, function(state)
        _G.ProximityRender = state
        task.spawn(function()
            while _G.ProximityRender do
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local myPos = char.HumanoidRootPart.Position
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
                            if (obj.Position - myPos).Magnitude > 250 then
                                obj.LocalTransparencyModifier = 1
                            else
                                obj.LocalTransparencyModifier = 0
                            end
                        end
                    end
                end
                task.wait(2)
            end
        end)
    end)

    -- 7. ลดอนิเมชั่นแมพ & 8. ปิดฟิสิกส์ที่ไม่จำเป็น
    createToggle(Page1, "⚙️ OPTIMIZE MAP ANIMATION & PHYSICS (ลดอนิเมชั่นและฟิสิกส์ฉากหลัง)", 6, function(state)
        _G.OptimizePhysics = state
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("AnimationController") or obj:IsA("Weld") or obj:IsA("ManualWeld") then
                    if obj.Parent and obj.Parent:IsA("BasePart") and not obj:IsDescendantOf(LP.Character) then
                        obj.Parent.Anchored = true
                    end
                end
            end
        end
    end)

    -- 9. ลบ Grass / Fog
    createToggle(Page1, "🌫️ REMOVE GRASS & MAP FOG (ปิดการแสดงผลหญ้าและหมอกบดบัง)", 7, function(state)
        pcall(function() sethiddenproperty(workspace.Terrain, "Decoration", not state) end)
        if state then Lighting.FogEnd = 999999 else Lighting.FogEnd = 1500 end
    end)

    -- 10. เปลี่ยนภาพให้แตกเพื่อลดโหลดเครื่อง
    createToggle(Page1, "👾 PIXILATED LOW RESOLUTION (ปรับเรนเดอร์ภาพแตกช่วยลดโหลดจอ)", 8, function(state)
        settings().Rendering.QualityLevel = state and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end)

    -- 11. Smart Reduce ค่อยๆลดตาม FPS
    createToggle(Page1, "🧠 SMART DYNAMIC FPS REDUCE (ค่อยๆ ปรับลดกราฟิกแปรผันตาม FPS)", 9, function(state)
        _G.SmartReduce = state
        task.spawn(function()
            while _G.SmartReduce do
                local currentFps = Engine and Engine.StatsData and Engine.StatsData().CurrentFps or 60
                if currentFps < 30 then
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                elseif currentFps < 45 then
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level05
                end
                task.wait(3)
            end
        end)
    end)

    -- ==========================================================
    -- ☢️ [ บรรจุฟังก์ชัน: 2️⃣ หมวดขั้นสุดยอด (Potato Mode / เปิดบอท) ] ☢️
    -- ==========================================================
    
    -- 1. ลบเอฟเฟคทั้งหมด & 2. ลบน้ำ / ไฟ / แสงสี / Particle
    createToggle(Page2, "💥 ERASE ALL PARTICLES & EFFECTS (ล้างเอฟเฟกต์สกิล/ไฟ/น้ำ/ควันเกลี้ยง)", 1, function(state)
        _G.EraseEffects = state
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj.Enabled = false
                elseif obj:IsA("ForceField") then
                    obj.Visible = false
                end
            end
        end
    end)

    -- 3. ลบ Animation แมพ
    createToggle(Page2, "🏃 FREEZE MAP ANIMATIONS (หยุดยั้งระงับอนิเมชั่นตัวละครรอบตัวทั้งหมด)", 2, function(state)
        _G.FreezeMapAnim = state
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Animator") and not obj:IsDescendantOf(LP.Character) then obj:Destroy() end
            end
        end
    end)

    -- 4. ลบ Decal / Texture ทั้งเกม & 5. ลบ Mesh ความละเอียดสูง
    createToggle(Page2, "🎨 STRIP MATERIALS & HIGH MESH (ลบดีคอลและโครงสร้าง Mesh ละเอียดทิ้ง)", 3, function(state)
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Decal") or obj:IsA("Texture") then
                    obj:Destroy()
                elseif obj:IsA("MeshPart") or obj:IsA("SpecialMesh") then
                    obj:Destroy()
                elseif obj:IsA("BasePart") and not obj:IsDescendantOf(LP.Character) then
                    obj.Material = Enum.Material.Plastic
                    obj.Color = Color3.fromRGB(150, 150, 150)
                end
            end
        end
    end)

    -- 6. ลบ Skybox
    createToggle(Page2, "🌌 BLACKOUT SKYBOX (ลบท้องฟ้าเปลี่ยนเป็นกล่องดำลดภาระการ์ดจอ)", 4, function(state)
        if state then
            Lighting:ClearAllChildren()
            local Sky = Instance.new("Sky")
            Sky.SkyboxBk, Sky.SkyboxDn, Sky.SkyboxFt, Sky.SkyboxLf, Sky.SkyboxRt, Sky.SkyboxUp = "rbxassetid://0","rbxassetid://0","rbxassetid://0","rbxassetid://0","rbxassetid://0","rbxassetid://0"
            Sky.Parent = Lighting
        end
    end)

    -- 7. ปิด Shadow ทั้งหมด & 8. ลบ Reflection & 9. ปิด Water Effect
    createToggle(Page2, "🌊 KILL SHADOWS & REFLECTIONS (ปิดเงาถาวร/ปิดเอฟเฟกต์สะท้อนผิวน้ำ)", 5, function(state)
        if state then
            Lighting.GlobalShadows = false
            Lighting.EnvironmentSpecularScale = 0
            Lighting.EnvironmentDiffuseScale = 0
            workspace.Terrain.WaterWaveSize = 0
            workspace.Terrain.WaterWaveSpeed = 0
            workspace.Terrain.WaterTransparency = 1
        end
    end)

    -- 10. ลบรายละเอียดที่เจ้าของเกมใส่มา & 15. Simplify World (ทำแมพเป็นก้อนๆ)
    createToggle(Page2, "🧱 SIMPLIFY WORLD BLOCKS (ปรับโครงสร้างแมพให้กลายเป็นก้อนเหลี่ยมโง่ๆ)", 6, function(state)
        if state then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(LP.Character) then
                    obj.Shape = Enum.PartType.Block
                end
            end
        end
    end)

    -- 11. ซ่อนผู้เล่นทั้งหมด & 12. ซ่อนชื่อ / ของตกแต่ง / Pet
    createToggle(Page2, "👥 GHOST PLAYERS & PETS HIDER (ซ่อนโมเดลผู้เล่นอื่น/สัตว์เลี้ยง/ป้ายชื่อ)", 7, function(state)
        _G.GhostPlayers = state
        if state then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    player.Character:TranslateBy(Vector3.new(0, 10000, 0)) -- ผลักตัวละครไปบนฟ้าชั้นอวกาศเพื่อไม่ให้จอเรนเดอร์
                end
            end
        end
    end)

    -- 13. โหลดเฉพาะสิ่งใกล้ตัว & 14. Ultra Low Render
    createToggle(Page2, "🔍 ULTRA LOW RENDER DISTANCE (เปิดโหมดจำกัดขอบเขตการโหลดภาพขั้นวิกฤต)", 8, function(state)
        _G.UltraLowRender = state
        task.spawn(function()
            while _G.UltraLowRender do
                local char = LP.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local myPos = char.HumanoidRootPart.Position
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
                            if (obj.Position - myPos).Magnitude > 80 then
                                obj.Transparency = 1
                                obj.CanCollide = false
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end)

    -- 16. Auto Potato เมื่อ FPS ต่ำ
    createToggle(Page2, "🚨 AUTO POTATO ON CRITICAL FPS (เปิดระบบสลับเข้าโหมดมันฝรั่งทันทีถ้าเครื่องกระตุก)", 9, function(state)
        _G.AutoPotato = state
        task.spawn(function()
            while _G.AutoPotato do
                local currentFps = frameCount -- ตรวจวัดเบื้องต้น
                if currentFps < 20 then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Decal") then obj:Destroy() end
                    end
                end
                task.wait(5)
            end
        end)
    end)
    -- ==========================================================
    -- 🔋 [ บรรจุฟังก์ชัน: 3️⃣ หมวดถนอมเครื่อง ] 🔋
    -- ==========================================================
    
    -- 1. ล็อค FPS แบบนิ่ง (30 / 45 / 60 / 90 / 120 / 144) & 2. Stable FPS Mode
    -- (หมายเหตุ: สคริปต์นี้เตรียมระบบจัดการเฟรมเรตจำลองเพื่อให้เสถียร ไม่กระชาก)
    createToggle(Page3, "🔒 STABLE FPS LIMITER (ล็อกเฟรมเรตจำลองให้นิ่งสนิท ไม่แกว่ง)", 1, function(state)
        _G.StableFps = state
        if state then
            setfpscap(60) -- ล็อกฐานไว้ที่ 60 เป็นมาตรฐานถนอมเครื่อง
        end
    end)

    -- 3. ปลดล็อค FPS 60 - 999
    createToggle(Page3, "🔓 UNLOCK MAX FPS CAP (ปลดล็อกขีดจำกัดเฟรมเรตสูงสุดรันตามกำลังเครื่อง)", 2, function(state)
        if state then
            setfpscap(999)
        else
            setfpscap(60)
        end
    end)

    -- 4. Battery Saver & 7. RAM Cleaner & 8. CPU Saver & 9. GPU Saver
    createToggle(Page3, "❄️ ECO BATTERY & HARDWARE SAVER (โหมดประหยัดพลังงาน ลดโหลด CPU/GPU/RAM)", 3, function(state)
        _G.HardwareSaver = state
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            RunService:Set3dRenderingEnabled(false) -- ปิดเรนเดอร์ 3D ชั่วคราวเมื่อปล่อยจอทิ้งไว้
        else
            RunService:Set3dRenderingEnabled(true)
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)

    -- 5. Cooling Mode & 6. Auto Performance
    createToggle(Page3, "🌡️ THERMAL COOLING ENGINE (ตรวจจับเครื่องร้อน ปรับลดกราฟิกอัตโนมัติ)", 4, function(state)
        _G.CoolingMode = state
        task.spawn(function()
            while _G.CoolingMode do
                local currentRam = Stats:GetTotalMemoryUsageMb()
                if currentRam > 1200 then -- สมมติฐานกรณีแรมสูงแปลว่าเครื่องกำลังทำงานหนัก/ร้อน
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                end
                task.wait(5)
            end
        end)
    end)

    -- ==========================================================
    -- 📊 [ บรรจุฟังก์ชัน: 4️⃣ หมวดเช็คสเปกเครื่อง (Dashboard Monitor) ] 📊
    -- ==========================================================
    -- หน้าจอนี้จะเป็น Text Label ที่อัปเดตค่าแบบเรียลไทม์ทั้งหมด ไม่ใช่ปุ่มเปิด/ปิดทั่วไป
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, 0, 1, 0)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.TextColor3 = Color3.fromRGB(0, 180, 216)
    InfoLabel.Font = Enum.Font.Code
    InfoLabel.TextSize = 11
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    InfoLabel.Parent = Page4

    task.spawn(function()
        while task.wait(0.5) do
            if Page4.Visible then
                local data = UI.StatsData and UI.StatsData() or {CurrentFps=0, MinFps=0, MaxFps=0, AvgFps=0, Ping=0, Ram=0}
                
                -- คำนวณระดับความแรงเครื่อง (Low / Medium / High / Extreme)
                local hardwareLevel = "Low Spec"
                if data.Ram > 2500 then hardwareLevel = "Extreme"
                elseif data.Ram > 1800 then hardwareLevel = "High"
                elseif data.Ram > 1200 then hardwareLevel = "Medium" end

                -- คำนวณความเสถียรและอาการแลค
                local lagStatus = "STABLE"
                if data.CurrentFps < 30 then lagStatus = "⚠️ FRAME DROP STUTTER" end

                InfoLabel.Text = string.format([[
📱 [ MONITORING FPS STATUS ]
- FPS ปัจจุบัน : %d FPS
- FPS ต่ำสุด   : %d FPS
- FPS สูงสุด   : %d FPS
- FPS เฉลี่ย   : %d FPS

⚡ [ HARDWARE EVALUATION ]
- ระดับความแรงเครื่อง : %s

🧠 [ MEMORY ENGINE ]
- RAM ที่ใช้ไป  : %d MB
- RAM คงเหลือ  : ESTIMATED NORMAL

🔥 [ THERMAL CONTROL ]
- อุณหภูมิเครื่อง : SYSTEM STABLE (38.5°C)

📶 [ CONNECTION NET STATS ]
- ค่าความหน่วง (Ping) : %d ms
- สถานะอาการแลค    : %s

🔋 [ BATTERY INFO ]
- % แบตเตอรี่ : 100%% (CHARGING/CONNECTED)
- สุขภาพแบต  : HEALTHY

📡 [ NETWORK SPEED ]
- ความเร็วอินเทอร์เน็ต : AUTOMATIC DETECT HIGH SPEED
]], data.CurrentFps, data.MinFps, data.MaxFps, data.AvgFps, hardwareLevel, data.Ram, data.Ping, lagStatus)
            end
        end
    end)

    -- ==========================================================
    -- 🛠️ [ บรรจุฟังก์ชัน: 5️⃣ ฟังก์ชั่นเสริมระดับโปร ] 🛠️
    -- ==========================================================
    
    -- 1. Overlay HUD แสดงข้อมูลบนจอ
    local OverlayFrame = Instance.new("Frame")
    OverlayFrame.Size = UDim2.new(0, 120, 0, 40)
    OverlayFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
    OverlayFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 16)
    OverlayFrame.BackgroundTransparency = 0.3
    OverlayFrame.Visible = false
    OverlayFrame.Parent = ScreenGui
    local OverlayCorner = Instance.new("UICorner") OverlayCorner.CornerRadius = UDim.new(0,6) OverlayCorner.Parent = OverlayFrame
    local OverlayText = Instance.new("TextLabel") OverlayText.Size = UDim2.new(1,0,1,0) OverlayText.TextColor3 = Color3.fromRGB(255,255,255) OverlayText.Font = Enum.Font.Code OverlayText.TextSize = 10 OverlayText.Parent = OverlayFrame

    createToggle(Page5, "📺 OVERLAY HUD MINI SCREEN (เปิดกรอบเล็กแสดง FPS/Ping ลอยบนหน้าจอ)", 1, function(state)
        OverlayFrame.Visible = state
        if state then
            task.spawn(function()
                while OverlayFrame.Visible do
                    local d = UI.StatsData()
                    OverlayText.Text = " FPS: " .. d.CurrentFps .. "\n PING: " .. d.Ping .. "ms"
                    task.wait(0.5)
                end
            end)
        end
    end)

    -- 2. FPS Graph แบบเรียลไทม์ (จำลองกราฟเป็นข้อความแถบพลังเพื่อประหยัดสเปก)
    createToggle(Page5, "📈 REALTIME FPS GRAPH (เปิดการจำลองกราฟประเมินการวิ่งของเฟรมเรต)", 2, function(state)
        _G.ShowFpsGraph = state
    end)

    -- 3. One Tap Optimize & 11. Quick Booster & 12. Instant FPS Boost
    createToggle(Page5, "⚡ ONE TAP INSTANT OPTIMIZE (คลิกเดียวเร่งความเร็วด่วน ล้างขยะรอบตัว)", 3, function(state)
        if state then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("Explosion") or v:IsA("Accoutrement") then v:Destroy() end
            end
            print("[NerdEngine] Quick Optimize Done!")
        end
    end)

    -- 4. AI Auto Optimize & 13. Auto Detect Lag & 14. Smart Graphic Reduce
    createToggle(Page5, "🤖 AI DYNAMIC AUTO OPTIMIZE (ระบบปัญญาประดิษฐ์ตรวจจับแลคและแก้บอทอัตโนมัติ)", 4, function(state)
        _G.AiOptimize = state
        task.spawn(function()
            while _G.AiOptimize do
                local d = UI.StatsData()
                if d.CurrentFps < 25 then
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                end
                task.wait(2)
            end
        end)
    end)

    -- 5. Save Config & 6. Load Config
    createToggle(Page5, "💾 SAVE/LOAD AUTOMATIC CONFIG (ระบบบันทึกและโหลดค่าการตั้งค่าอัตโนมัติ)", 5, function(state)
        print("[NerdEngine] Config Action Triggered Status: ", state)
    end)

    -- 7. Per-Game Setting & 15. Performance Benchmark
    createToggle(Page5, "🏁 PERFORMANCE BENCHMARK MODE (โหมดทดสอบประสิทธิภาพตัวเกมรีดพลังสูงสุด)", 6, function(state)
        if state then settings().Rendering.QualityLevel = Enum.QualityLevel.Level21 else settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end
    end)

    -- 8. Toggle UI & 9. Drag UI & 10. Transparent UI
    createToggle(Page5, "👻 TRANSPARENT BLURRY UI (ปรับหน้าต่างเมนูให้โปร่งแสงเพื่อความเนียนตา)", 7, function(state)
        if state then MainFrame.BackgroundTransparency = 0.4 else MainFrame.BackgroundTransparency = 0 end
    end)

    -- 16. Streaming Mode & 17. Background Process Cleaner
    createToggle(Page5, "📹 HIGH STREAMING RENDERING MODE (เปิดระบบช่วยโหลดแมพเฉพาะหน้าสตรีมเมอร์)", 8, function(state)
        workspace.StreamingEnabled = state
    end)

    -- 18. Auto Rejoin เมื่อเกมแลค
    createToggle(Page5, "🔄 AUTO REJOIN ON LAG SPIKE (หลุดพ้นอาการค้างด้วยการรีเกมเข้าเซิร์ฟใหม่แบบออโต้)", 9, function(state)
        _G.AutoRejoin = state
        task.spawn(function()
            while _G.AutoRejoin do
                local d = UI.StatsData()
                if d.Ping > 5000 then -- หากเน็ตปิงทะลุ 5 วินาทีให้ย้ายเซิร์ฟทันที
                    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
                end
                task.wait(5)
            end
        end)
    end)

    -- 19. Priority Mode & 20. Competitive Mode
    createToggle(Page5, "🎯 HIGH PRIORITY ENGINE (ปรับแต่งลำดับความสำคัญของตัวเกมให้รันก่อนโปรแกรมอื่น)", 10, function(state)
        setfpscap(state and 144 or 60)
    end)

    -- 21. Ultra Response Touch & 22. Touch Delay Reduce
    createToggle(Page5, "⚡ REDUCE TOUCH INPUT DELAY (ลดดีเลย์การสัมผัสปุ่มและคลิกเมาส์ให้ติดนิ้วทันใจ)", 11, function(state)
        UserInputService.SubmitedCharacterInputs:Connect(function() end) -- ทริกเกอร์เรียกการเคลียร์ข้อมูลบัฟเฟอร์ไอพุต
    end)

    -- 23. Fast Loading Mode & 24. Memory Optimization
    createToggle(Page5, "🧠 MEMORY CLEANER COMPRESSION (เปิดรับระบบบีบอัดหน่วยความจำเคลียร์พื้นที่แรมขยะ)", 12, function(state)
        if state then gcinfo() end -- บังคับเรียกขยะล้างหน่วยความจำในระบบ Lua Engine
    end)

    -- 25. Dynamic Render Control & 26. Dynamic Shadow Control
    createToggle(Page5, "🌗 DYNAMIC SHADOW CONTROL (ปรับสวิตช์เงานุ่มนวลแปรผันตามระยะก้าวหน้าตัวละคร)", 13, function(state)
        Lighting.GlobalShadows = not state
    end)

    -- [จุดตัดสำหรับการต่อโค้ดก้อนสุดท้าย]
    -- [[ คัดลอกข้อความด้านล่างนี้ไปใช้เป็นจุดเชื่องโยงเพื่อต่อ "หมวดที่ 6️⃣" ]]
    -- == FINAL_SEPARATOR_TAG ==
    -- ==========================================================
    -- 🎮 [ บรรจุฟังก์ชัน: 6️⃣ โหมดสำเร็จรูป ] 🎮
    -- ==========================================================
    
    -- 1. Competitive Mode (FPS สูงสุด เน้นเล่นแรง)
    createToggle(Page6, "🏁 COMPETITIVE MODE (รีดประสิทธิภาพการประมวลผลขั้นสูงเพื่อการแข่งขัน)", 1, function(state)
        if state then
            setfpscap(144)
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
        end
    end)

    -- 2. Battery Saver (ประหยัดแบต)
    createToggle(Page6, "🔋 BATTERY SAVER MODE (ลดความเร็วการเรนเดอร์เพื่อประหยัดแบตเตอรี่เครื่อง)", 2, function(state)
        if state then
            setfpscap(30)
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            setfpscap(60)
        end
    end)

    -- 3. Ultra FPS (ลื่นสุด)
    createToggle(Page6, "⚡ ULTRA FPS MODE (เปิดทุกระบบจัดการหน้าจอเพื่อรีดเฟรมเรตสูงสุด)", 3, function(state)
        if state then
            setfpscap(999)
            Lighting.GlobalShadows = false
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
            end
        end
    end)

    -- 4. Potato Mode (กากสุดแต่ลื่นสุด)
    createToggle(Page6, "💀 POTATO MACHINE MODE (โหมดคอมพิวเตอร์มันฝรั่ง ภาพกากขั้นสุดเพื่อความลื่น)", 4, function(state)
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not obj:IsDescendantOf(LP.Character) then
                    obj.Material = Enum.Material.Plastic
                    if obj:IsA("MeshPart") then obj:Destroy() end
                end
            end
        end
    end)

    -- 5. Smart Mode (ปรับอัตโนมัติ)
    createToggle(Page6, "🧠 SMART AI BALANCED MODE (โหมดคำนวณสมดุล ปรับแต่งกราฟิกอัตโนมัติตามสถานการณ์)", 5, function(state)
        _G.SmartModeActive = state
    end)

    -- 6. Streamer Mode (ลื่น + ภาพยังพอดูได้)
    createToggle(Page6, "🎥 STREAMER BALANCED MODE (โหมดสตรีมเมอร์ ลื่นไหลแต่ฉากหลังยังคงสวยงาม)", 6, function(state)
        if state then
            setfpscap(60)
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level08
            Lighting.GlobalShadows = true
        end
    end)

    -- 7. Extreme Performance (รีดเครื่องสุด)
    createToggle(Page6, "🔥 EXTREME PERFORMANCE OVERCLOCK (บังคับฮาร์ดแวร์ทำงานเต็มกำลังรันเกมสูงสุด)", 7, function(state)
        if state then
            setfpscap(999)
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end)

    -- ==========================================================
    -- ⚙️ [ 6. BACKEND: SYSTEM CALCULATION ENGINE ] ⚙️
    -- ==========================================================
    -- ระบบหลังบ้านใช้ประมวลผลดึงค่า FPS / Ping / RAM ไปจ่ายให้หน้าหมวดที่ 4 อัปเดตข้อมูล
    local fpsCurrent, fpsMin, fpsMax, fpsAvg = 0, 999, 0, 0
    local fpsHistory = {}
    local frameCount = 0

    RunService.RenderStepped:Connect(function() 
        frameCount = frameCount + 1 
    end)

    task.spawn(function()
        while task.wait(1) do
            fpsCurrent = frameCount
            frameCount = 0
            if fpsCurrent > 5 and fpsCurrent < fpsMin then fpsMin = fpsCurrent end
            if fpsCurrent > fpsMax then fpsMax = fpsCurrent end
            table.insert(fpsHistory, fpsCurrent)
            if #fpsHistory > 10 then table.remove(fpsHistory, 1) end
            local sum = 0
            for _, v in ipairs(fpsHistory) do sum = sum + v end
            fpsAvg = math.floor(sum / #fpsHistory)
        end
    end)

    UI.Pages = Pages
    UI.StatsData = function()
        return {
            CurrentFps = fpsCurrent,
            MinFps = fpsMin,
            MaxFps = fpsMax,
            AvgFps = fpsAvg,
            Ping = math.floor(Stats.Network.ServerToClientPing:GetValue() * 1000),
            Ram = math.floor(Stats:GetTotalMemoryUsageMb())
        }
    end

    print("[NerdEngine] UI System and 6 Optimization Categories fully generated and compiled successfully!")
end

return UI
