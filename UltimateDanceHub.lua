-- [[ ⚡ ULTIMATE MUSIC HUB - SLIM & FIXED EDITION 2026 ⚡ ]] --
-- แก้ไข: ขนาดเล็กลง, บั๊กตอนซ่อนหาย 100%, ดีไซน์เนียนกว่าเดิม

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SetClipboard = setclipboard or function(txt) print("Copied: "..txt) end

-- [[ 💾 DATA: เพลงแดนซ์ / เพลงเพราะ / ต่างชาติ (ครบถ้วน) ]] --
local Playlist = {
    Dance = {
        {Name = "ยาวไปๆ", ID = "104528386279346"}, {Name = "รำตึงๆ", ID = "134935289024622"}, {Name = "เทสระบบ", ID = "106368573241167"}, {Name = "Shuuu", ID = "128898571937686"}, {Name = "BREAK MIX OF CAMBODIA", ID = "134668380697300"}, {Name = "FUNKY OF CAMBODIA", ID = "87741002754499"}, {Name = "ฟริตฟรอมดีไซน์", ID = "119702026594709"}, {Name = "ป้าจิ๊ก • TEAM MPB", ID = "119037495327681"}, {Name = "อาจีโลยๆ", ID = "138832055693646"}, {Name = "ซึ่งๆDDE", ID = "135282750884361"}, {Name = "เดอะแก๊ง", ID = "70664764327260"}, {Name = "รู้พิกัด2", ID = "115957293934252"}, {Name = "อย่าตีกันเด้อ", ID = "106427700620281"}, {Name = "ชิกเก้น", ID = "104079603511923"}, {Name = "ไปละมาดกัน", ID = "88404154262740"}, {Name = "ขอนไม้ของพี่", ID = "87827942442562"}, {Name = "วันเลิฟ แดนซ์ๆ", ID = "78424397783913"}, {Name = "เป็นแฟนคนจน", ID = "80257250302898"}, {Name = "กินกันเสร็จก็กลับๆๆ", ID = "71746449065680"}, {Name = "มึงไม่บวช", ID = "89107787132559"}, {Name = "ยาย้าฝั่งธน", ID = "140168985629311"}, {Name = "ล้างไข่รอเธอ", ID = "75575940953909"}, {Name = "ความรักหายใจ", ID = "135217873447796"}, {Name = "แม่กวนอิมซ่า", ID = "80795041302103"}, {Name = "แม่จ๋า ไอซ์ตีหนู", ID = "76147013236626"}, {Name = "เบสดาไอซ์ภูมิ", ID = "136209869613095"}, {Name = "ดาโปร๊กบาชาล่า", ID = "116353720515544"}, {Name = "ละหมาดอารมณ์", ID = "121586320453098"}, {Name = "เธอก็ไม่มาสักที", ID = "74180212649765"}, {Name = "อีกฝั่งพระจันทร์", ID = "92539330883705"}, {Name = "ผิดตรงไหน", ID = "126473328069537"}, {Name = "เนาะสู้แบต", ID = "85699116970961"}, {Name = "เพลง", ID = "83919005919466"}, {Name = "มองฟ้าค่ำคืนนี้", ID = "79538551420484"}, {Name = "aunwarpinthemix_800", ID = "75939658512385"}, {Name = "50/100", ID = "125356270448095"}, {Name = "ปรับ20", ID = "82475562998551"}, {Name = "ผู้หญิงคนไหน", ID = "130065665706680"}, {Name = "T DED Taj Mahal", ID = "73989721978244"}, {Name = "1216", ID = "120876234312672"}, {Name = "LAZZER", ID = "104473870156356"}, {Name = "3rd_part", ID = "96046650797488"}, {Name = "2nd_part", ID = "99234295745057"}, {Name = "ทุกระบบจบที่ผม", ID = "132460502830436"}, {Name = "ธรรมชาติ", ID = "117565816328446"}, {Name = "ชิบูย่า", ID = "78870133899454"}, {Name = "หนมคกนันเปด", ID = "71305893329994"}, {Name = "ไก่เถื่อนเหอ", ID = "107249069416114"}
    },
    Mellow = {
        {Name = "Yungtarr - มนต์ใด", ID = "114248800788467"}, {Name = "Yungtarr - ทองแดง", ID = "83271233590423"}, {Name = "Yungtarr - ให้ตายเถอะ", ID = "114874341935795"}, {Name = "Yungtarr - เด็กอินเตอร์", ID = "99634905807786"}, {Name = "Yungtarr - ซาติน (ปรับเสียง)", ID = "130478926378862"}, {Name = "Yungtarr - ซาติน (ต้นฉบับ)", ID = "80512451099660"}, {Name = "Yungtarr - Resetment", ID = "103949886400704"}, {Name = "SARAN - อยู่กับฉันก่อน", ID = "106307030467672"}, {Name = "SARAN - PROMETHAZINE", ID = "97804354799131"}, {Name = "SARAN - มากกว่ารัก", ID = "101340281241795"}, {Name = "P6ICK - Winter Flower", ID = "83492245009591"}, {Name = "P6ICK - แสงจันทร์", ID = "80577921133010"}, {Name = "P6ICK - ตอนนี้เธออยู่บนฟ้าใด", ID = "73832204011731"}, {Name = "P6ICK - ดอกหญ้า", ID = "96620948788714"}, {Name = "P6ICK - ธรรมชาติ", ID = "117565816328446"}, {Name = "P6ICK - 1of1", ID = "105201227602807"}, {Name = "YOUNGGU - เงิน 50,000", ID = "135918232406180"}, {Name = "YOUNGGU - UTHAITIPBOY", ID = "78447026517636"}, {Name = "YOUNG J - เจ้าหญิง", ID = "125570800248263"}, {Name = "P$L & YOUNG J - SPACE TIME", ID = "107467028901469"}, {Name = "YOUNGJ - ผู้พัน", ID = "99512073225966"}, {Name = "Big แบงค์พัน - 412", ID = "138203974147840"}, {Name = "Pondering - Daydream", ID = "75923946469071"}, {Name = "Pondering - เพลงนี้เขียนให้เธอ", ID = "112453710105774"}, {Name = "Diamond MQT - คนธรรมดา", ID = "129513958237400"}, {Name = "Diamond MQT - เทสดี", ID = "90395651800162"}, {Name = "Only Monday - ทุกความทรงจำ", ID = "109906833143323"}, {Name = "Only Monday - ไม่เป็นไร", ID = "81290679697617"}, {Name = "ILLSLICK - ถ้าเธอต้องเลือก", ID = "129087259637558"}, {Name = "ILLSLICK - SLO SLOW", ID = "114078156952054"}, {Name = "ILLSLICK - เสาร์อาทิตย์", ID = "109249460275896"}, {Name = "ILLSLICK - Move That", ID = "139344869252915"}
    },
    Inter = {
        {Name = "ละครใบ้สยองขวัญ", ID = "1836272467"}, {Name = "Bach - Toccata & Fugue", ID = "564238335"}, {Name = "24kGoldn - Mood", ID = "5519565135"}, {Name = "AC/DC - Highway to Hell", ID = "4728058875"}, {Name = "A-ha - Take On Me", ID = "4606705490"}, {Name = "Ariana Grande - 34+35", ID = "588219957"}, {Name = "Ariana Grande - God Is a Woman", ID = "2071829884"}, {Name = "Anime Girl - Lofi Chill", ID = "9043887091"}, {Name = "Anime Girl - Study Lofi", ID = "74137426221090"}, {Name = "Amaarae - Sad Girl Luv Money", ID = "8026236684"}, {Name = "Andrew Gold - Spooky Skeletons", ID = "138081566"}, {Name = "APM - Seek & Destroy", ID = "1845149698"}, {Name = "Ashnikko - Daisy", ID = "5321298199"}, {Name = "Ava Max - My Head & My Heart", ID = "6032653117"}, {Name = "Beastie Boys - Intergalactic", ID = "131603357"}, {Name = "Belly Dancer x Temperature", ID = "8055519816"}, {Name = "Beethoven - Fur Elise", ID = "450051032"}, {Name = "Beethoven - Moonlight Sonata", ID = "445023353"}, {Name = "Better Call Saul Theme", ID = "2801308469"}, {Name = "Billie Eilish - NDA", ID = "7079888477"}, {Name = "Billie Eilish - Everything Wanted", ID = "4380429016"}, {Name = "Black Eyed Peas - Lets Get Started", ID = "138134680"}, {Name = "Boney M - Rasputin", ID = "5512350519"}, {Name = "Britney Spears - Till World Ends", ID = "6973084731"}, {Name = "BTS - Butter", ID = "6844912719"}, {Name = "BTS - Dynamite", ID = "6257627378"}, {Name = "Claude Debussy - Clair de Lune", ID = "1838457617"}, {Name = "Clean Bandit - Solo", ID = "2106186490"}, {Name = "Charli XCX - Boom Clap", ID = "189739789"}, {Name = "Childish Gambino - This is America", ID = "2062482384"}, {Name = "Coolio - Gangsta's Paradise", ID = "6070263388"}, {Name = "Darude - Sandstorm", ID = "166562385"}, {Name = "DJ Khaled - I'm the One", ID = "97188886257764"}, {Name = "Doja Cat - Like That", ID = "4656290260"}, {Name = "Doja Cat - Say So", ID = "521116871"}, {Name = "Doom Eternal - Slayer Gates", ID = "4812865231"}, {Name = "Droideka - Get Hyper", ID = "138855854"}, {Name = "Dua Lipa - Levitating", ID = "6606223785"}, {Name = "Drake - God's Plan", ID = "2201067635"}, {Name = "Drake - Hotline Bling", ID = "306352667"}, {Name = "Ed Sheeran - Bad Habits", ID = "7202579511"}, {Name = "Eminem - Without Me", ID = "6689996382"}, {Name = "Fetty Wap - Trap Queen", ID = "210783060"}, {Name = "Frozen - Let It Go", ID = "189105508"}, {Name = "Foster People - Pumped Up Kicks", ID = "2694148776"}, {Name = "Glass Animals - Heat Waves", ID = "6432181830"}
    }
}

-- [[ ⚙️ SETUP ]] --
local Sound = Instance.new("Sound", workspace)
Sound.Volume = 5
local CurrentTab = "Dance"

-- [[ 🎨 GUI UI ]] --
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "SlimMusicHub"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 480)
Main.Position = UDim2.new(0.5, -160, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
local Glow = Instance.new("Frame", Main)
Glow.Size = UDim2.new(1, 0, 0, 2)
Glow.BackgroundColor3 = Color3.fromRGB(0, 255, 160)
Glow.BorderSizePixel = 0

-- [[ Title & Hide System ]] --
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "⚡ CYBER MUSIC HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0.5, -15)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

-- Content Frame (แยกส่วนเพื่อกันบั๊กตอนย่อ)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1
Content.ClipsDescendants = true

local IsMin = false
MinBtn.MouseButton1Click:Connect(function()
    IsMin = not IsMin
    Main:TweenSize(IsMin and UDim2.new(0, 320, 0, 40) or UDim2.new(0, 320, 0, 480), "Out", "Quart", 0.3, true)
    MinBtn.Text = IsMin and "+" or "-"
    Content.Visible = not IsMin
end)

-- Search & Tabs
local TabF = Instance.new("Frame", Content)
TabF.Size = UDim2.new(1, -20, 0, 30)
TabF.Position = UDim2.new(0, 10, 0, 5)
TabF.BackgroundTransparency = 1

local function CreateTab(txt, pos, tab)
    local b = Instance.new("TextButton", TabF)
    b.Size = UDim2.new(0.32, 0, 1, 0)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() CurrentTab = tab _G.Refresh() end)
    return b
end

CreateTab("แดนซ์", UDim2.new(0, 0, 0, 0), "Dance")
CreateTab("เพลงเพราะ", UDim2.new(0.34, 0, 0, 0), "Mellow")
CreateTab("ต่างชาติ", UDim2.new(0.68, 0, 0, 0), "Inter")

local Search = Instance.new("TextBox", Content)
Search.Size = UDim2.new(1, -20, 0, 35)
Search.Position = UDim2.new(0, 10, 0, 40)
Search.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Search.PlaceholderText = "🔍 ค้นหาเพลง..."
Search.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Search)

-- List
local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.new(1, -10, 0, 220)
Scroll.Position = UDim2.new(0, 5, 0, 80)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 160)
local ListL = Instance.new("UIListLayout", Scroll)
ListL.Padding = UDim.new(0, 4)

-- Player Section
local PlayF = Instance.new("Frame", Content)
PlayF.Size = UDim2.new(1, -20, 0, 115)
PlayF.Position = UDim2.new(0, 10, 1, -125)
PlayF.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", PlayF)

local IDShow = Instance.new("TextBox", PlayF)
IDShow.Size = UDim2.new(0.9, 0, 0, 25)
IDShow.Position = UDim2.new(0.05, 0, 0.1, 0)
IDShow.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
IDShow.Text = "----- ใส่ไอดี -----"
IDShow.TextColor3 = Color3.fromRGB(0, 255, 160)
IDShow.TextEditable = false
Instance.new("UICorner", IDShow)

local PBtn = Instance.new("TextButton", PlayF)
PBtn.Size = UDim2.new(0.43, 0, 0, 35)
PBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
PBtn.Text = "เปิด"
PBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 60)
PBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", PBtn)

local SBtn = Instance.new("TextButton", PlayF)
SBtn.Size = UDim2.new(0.43, 0, 0, 35)
SBtn.Position = UDim2.new(0.52, 0, 0.38, 0)
SBtn.Text = "ปิด"
SBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
SBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SBtn)

local VLabel = Instance.new("TextLabel", PlayF)
VLabel.Size = UDim2.new(1, 0, 0, 20)
VLabel.Position = UDim2.new(0, 0, 0.75, 0)
VLabel.Text = "เสียง: 5 / 10"
VLabel.TextColor3 = Color3.new(0.6, 0.6, 0.6)
VLabel.BackgroundTransparency = 1

local VUp = Instance.new("TextButton", PlayF)
VUp.Size = UDim2.new(0, 28, 0, 28)
VUp.Position = UDim2.new(0.8, 0, 0.72, 0)
VUp.Text = "+"
VUp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
VUp.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", VUp)

local VDown = Instance.new("TextButton", PlayF)
VDown.Size = UDim2.new(0, 28, 0, 28)
VDown.Position = UDim2.new(0.12, 0, 0.72, 0)
VDown.Text = "-"
VDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
VDown.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", VDown)

local Note = Instance.new("TextLabel", Content)
Note.Size = UDim2.new(1, 0, 0, 15)
Note.Position = UDim2.new(0, 0, 1, -10)
Note.Text = "* บางไอดีอาจใช้ไม่ได้เนื่องจากลิขสิทธิ์"
Note.TextColor3 = Color3.new(0.4, 0.4, 0.4)
Note.TextSize = 9
Note.BackgroundTransparency = 1

-- [[ ⚙️ LOGIC ]] --
_G.Refresh = function()
    local filter = Search.Text:lower()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, s in pairs(Playlist[CurrentTab]) do
        if filter == "" or s.Name:lower():find(filter) then
            local b = Instance.new("TextButton", Scroll)
            b.Size = UDim2.new(0.96, 0, 0, 40)
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.Text = "  " .. s.Name
            b.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            b.Font = Enum.Font.Gotham
            b.TextSize = 12
            b.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", b)
            
            local il = Instance.new("TextLabel", b)
            il.Size = UDim2.new(0, 80, 1, 0)
            il.Position = UDim2.new(1, -85, 0, 0)
            il.Text = s.ID
            il.TextColor3 = Color3.fromRGB(0, 255, 160)
            il.BackgroundTransparency = 1
            il.TextSize = 10

            b.MouseButton1Click:Connect(function()
                IDShow.Text = s.ID
                SetClipboard(s.ID)
                b.Text = "✅ คัดลอกแล้ว!"
                task.wait(0.5)
                b.Text = "  " .. s.Name
            end)
        end
    end
    Scroll.CanvasSize = UDim2.new(0,0,0, ListL.AbsoluteContentSize.Y)
end

Search:GetPropertyChangedSignal("Text"):Connect(_G.Refresh)
PBtn.MouseButton1Click:Connect(function()
    if IDShow.Text ~= "----- ใส่ไอดี -----" then Sound.SoundId = "rbxassetid://"..IDShow.Text Sound:Play() end
end)
SBtn.MouseButton1Click:Connect(function() Sound:Stop() end)
VUp.MouseButton1Click:Connect(function() if Sound.Volume < 10 then Sound.Volume = Sound.Volume + 1 VLabel.Text = "เสียง: "..Sound.Volume.." / 10" end end)
VDown.MouseButton1Click:Connect(function() if Sound.Volume > 0 then Sound.Volume = Sound.Volume - 1 VLabel.Text = "เสียง: "..Sound.Volume.." / 10" end end)

_G.Refresh()

