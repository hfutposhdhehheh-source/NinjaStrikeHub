----------------------------------------------------------------------------------------------------
-- SCRIPT MAINTENANCE & UPDATE NOTICE CONTAINER
----------------------------------------------------------------------------------------------------
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- ลบ UI เก่าออกก่อนป้องกันการรันซ้อน
if CoreGui:FindFirstChild("ScriptUpdateNoticeGui") then
    CoreGui.ScriptUpdateNoticeGui:Destroy()
end

-- สร้าง ScreenGui
local NoticeGui = Instance.new("ScreenGui")
NoticeGui.Name = "ScriptUpdateNoticeGui"
NoticeGui.Parent = CoreGui
NoticeGui.IgnoreGuiInset = true
NoticeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- หน้าต่างหลัก
local MainFrame = Instance.new("Frame")
MainFrame.Parent = NoticeGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
MainFrame.Size = UDim2.new(0, 340, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = MainFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(239, 68, 68) -- สีแดงเตือนภัย
FrameStroke.Thickness = 1.5
FrameStroke.Parent = MainFrame

-- ไอคอน/หัวข้อ
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 16, 0, 16)
TitleLabel.Size = UDim2.new(1, -32, 0, 24)
TitleLabel.Font = Enum.Font.Code
TitleLabel.Text = "🛠️ SYSTEM MAINTENANCE / ปิดปรับปรุง"
TitleLabel.TextColor3 = Color3.fromRGB(248, 113, 113)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ข้อความรายละเอียดภาษาไทย
local MessageThai = Instance.new("TextLabel")
MessageThai.Parent = MainFrame
MessageThai.BackgroundTransparency = 1
MessageThai.Position = UDim2.new(0, 16, 0, 50)
MessageThai.Size = UDim2.new(1, -32, 0, 55)
MessageThai.Font = Enum.Font.Code
MessageThai.Text = "ขณะนี้สคริปต์อยู่ระหว่างการปิดปรับปรุงระบบความปลอดภัย (ระยะเวลา 1 เดือน) กรุณาหยุดใช้งานชั่วคราวเพื่อความปลอดภัยของไอดี"
MessageThai.TextColor3 = Color3.fromRGB(226, 232, 240)
MessageThai.TextSize = 10
MessageThai.TextWrapped = true
MessageThai.TextXAlignment = Enum.TextXAlignment.Left

-- ข้อความรายละเอียดภาษาอังกฤษ
local MessageEng = Instance.new("TextLabel")
MessageEng.Parent = MainFrame
MessageEng.BackgroundTransparency = 1
MessageEng.Position = UDim2.new(0, 16, 0, 110)
MessageEng.Size = UDim2.new(1, -32, 0, 45)
MessageEng.Font = Enum.Font.Code
MessageEng.Text = "[EN] Script is currently under maintenance for safety updates (1 Month). Operations are temporarily suspended."
MessageEng.TextColor3 = Color3.fromRGB(148, 163, 184)
MessageEng.TextSize = 9
MessageEng.TextWrapped = true
MessageEng.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มปิด / ยืนยัน
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseButton.Position = UDim2.new(0, 16, 1, -48)
CloseButton.Size = UDim2.new(1, -32, 0, 32)
CloseButton.Font = Enum.Font.Code
CloseButton.Text = "รับทราบ (Acknowledge & Exit)"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 11

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    NoticeGui:Destroy()
end)
