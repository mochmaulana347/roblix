-- Setup GUI Utama
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportGUI"
ScreenGui.Parent = playerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Warna gelap yang elegan
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")  -- Membuat sudut membulat
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),  -- Gradasi halus
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
UIGradient.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Text = "Teleport"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold  -- Menggunakan font yang lebih modern
Title.Parent = Frame

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0.2, 0)
NameInput.Position = UDim2.new(0.05, 0, 0.25, 0)  -- Menyesuaikan posisi agar lebih rapi
NameInput.PlaceholderText = "Enter username or display name"
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Background input yang lebih gelap
NameInput.BorderSizePixel = 0
NameInput.TextScaled = true
NameInput.Font = Enum.Font.Gotham  -- Konsisten dengan font yang digunakan
NameInput.Parent = Frame

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.9, 0, 0.15, 0)  -- Mengurangi ukuran tombol untuk proporsi yang lebih baik
TeleportButton.Position = UDim2.new(0.05, 0, 0.45, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)  -- Warna biru yang lebih lembut
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "Teleport"
TeleportButton.TextScaled = true
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.BorderSizePixel = 0
TeleportButton.Parent = Frame

local LoopButton = Instance.new("TextButton")
LoopButton.Size = UDim2.new(0.9, 0, 0.15, 0)
LoopButton.Position = UDim2.new(0.05, 0, 0.65, 0)
LoopButton.BackgroundColor3 = Color3.fromRGB(241, 196, 15)  -- Warna kuning yang lebih lembut
LoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopButton.Text = "Loop Teleport"
LoopButton.TextScaled = true
LoopButton.Font = Enum.Font.Gotham
LoopButton.BorderSizePixel = 0
LoopButton.Parent = Frame

local DestroyButton = Instance.new("TextButton")
DestroyButton.Size = UDim2.new(0.9, 0, 0.15, 0)
DestroyButton.Position = UDim2.new(0.05, 0, 0.85, 0)
DestroyButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)  -- Warna merah yang lebih lembut
DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyButton.Text = "Destroy GUI"
DestroyButton.TextScaled = true
DestroyButton.Font = Enum.Font.Gotham
DestroyButton.BorderSizePixel = 0
DestroyButton.Parent = Frame

-- GUI Kontrol
local ControlGui = Instance.new("ScreenGui")
ControlGui.Name = "ControlGUI"
ControlGui.Parent = playerGui

local ControlFrame = Instance.new("Frame")
ControlFrame.Size = UDim2.new(0.1, 0, 0.1, 0)
ControlFrame.Position = UDim2.new(0.85, 0, 0.85, 0)
ControlFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ControlFrame.BorderSizePixel = 0
ControlFrame.Parent = ControlGui

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = ControlFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Toggle GUI"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = ControlFrame

-- Variabel untuk Mengontrol Visibilitas
local isGuiVisible = true

-- Fungsi untuk Mengontrol Visibilitas GUI
local function toggleGuiVisibility()
    if ScreenGui then
        isGuiVisible = not isGuiVisible
        Frame.Visible = isGuiVisible
    end
end

-- Aksi Tombol Kontrol
ToggleButton.MouseButton1Click:Connect(function()
    toggleGuiVisibility()
end)

-- Fungsi untuk Teleportasi
local function teleportToPlayer(playerName)
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Name:lower():find(playerName:lower()) or player.DisplayName:lower():find(playerName:lower()) then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame
                return
            end
        end
    end
    print("Player not found.")
end

-- Variabel untuk Loop Teleport
local isLooping = false
local teleportInterval = 1  -- waktu dalam detik untuk loop teleport

-- Fungsi Loop Teleport
local function startLoopTeleport(playerName)
    while isLooping do
        teleportToPlayer(playerName)
        wait(teleportInterval)
    end
end

-- Aksi Tombol Teleport
TeleportButton.MouseButton1Click:Connect(function()
    local name = NameInput.Text
    if name and name ~= "" then
        isLooping = false  -- Hentikan loop jika ada
        teleportToPlayer(name)
    else
        print("Please enter a player name.")
    end
end)

-- Aksi Tombol Loop Teleport
LoopButton.MouseButton1Click:Connect(function()
    local name = NameInput.Text
    if name and name ~= "" then
        isLooping = not isLooping
        if isLooping then
            LoopButton.Text = "Stop Loop Teleport"
            startLoopTeleport(name)
        else
            LoopButton.Text = "Loop Teleport"
        end
    else
        print("Please enter a player name.")
    end
end)

-- Aksi Tombol Destroy
DestroyButton.MouseButton1Click:Connect(function()
    if ScreenGui then
        ScreenGui:Destroy()
        print("GUI Destroyed")
    end
end)

-- Fitur Geser GUI
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if dragging and dragInput then
        updateInput(dragInput)
    end
end)
