-- Setup GUI Utama
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Main GUI
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "MainGUI"
MainGui.Parent = playerGui

-- Frame for Main GUI
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainGui

-- Styling for Main GUI
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
UIGradient.Parent = MainFrame

-- Title Label
local Title = Instance.new("TextLabel")
Title.Text = "Main GUI"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Name Input
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0.15, 0)
NameInput.Position = UDim2.new(0.05, 0, 0.25, 0)
NameInput.PlaceholderText = "Enter username or display name"
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameInput.BorderSizePixel = 0
NameInput.TextScaled = true
NameInput.Font = Enum.Font.Gotham
NameInput.Parent = MainFrame

-- Teleport Button
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.9, 0, 0.15, 0)
TeleportButton.Position = UDim2.new(0.05, 0, 0.4, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "Teleport"
TeleportButton.TextScaled = true
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.BorderSizePixel = 0
TeleportButton.Parent = MainFrame

-- Loop Teleport Button
local LoopButton = Instance.new("TextButton")
LoopButton.Size = UDim2.new(0.9, 0, 0.15, 0)
LoopButton.Position = UDim2.new(0.05, 0, 0.55, 0)
LoopButton.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
LoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopButton.Text = "Loop Teleport"
LoopButton.TextScaled = true
LoopButton.Font = Enum.Font.Gotham
LoopButton.BorderSizePixel = 0
LoopButton.Parent = MainFrame

-- Camera Lock Button
local CameraLockButton = Instance.new("TextButton")
CameraLockButton.Size = UDim2.new(0.9, 0, 0.15, 0)
CameraLockButton.Position = UDim2.new(0.05, 0, 0.7, 0)
CameraLockButton.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
CameraLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CameraLockButton.Text = "Lock Camera"
CameraLockButton.TextScaled = true
CameraLockButton.Font = Enum.Font.Gotham
CameraLockButton.BorderSizePixel = 0
CameraLockButton.Parent = MainFrame

-- Create Control GUI
local ControlGui = Instance.new("ScreenGui")
ControlGui.Name = "ControlGUI"
ControlGui.Parent = playerGui

-- Hide/Show Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Position = UDim2.new(0.45, 0, 0.05, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "Hide GUI"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = ControlGui

-- Variables for GUI Visibility
local isGuiVisible = true

-- Function to Toggle GUI Visibility
local function toggleGuiVisibility()
    isGuiVisible = not isGuiVisible
    MainFrame.Visible = isGuiVisible
    ToggleButton.Text = isGuiVisible and "Hide GUI" or "Show GUI"
end

-- Toggle Button Action
ToggleButton.MouseButton1Click:Connect(toggleGuiVisibility)

-- Function to Teleport to Player
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

-- Variables for Loop Teleport
local isLooping = false
local teleportInterval = 1  -- Interval in seconds for loop teleport

-- Function for Loop Teleport
local function startLoopTeleport(playerName)
    while isLooping do
        teleportToPlayer(playerName)
        wait(teleportInterval)
    end
end

-- Teleport Button Action
TeleportButton.MouseButton1Click:Connect(function()
    local name = NameInput.Text
    if name and name ~= "" then
        isLooping = false  -- Stop loop if any
        teleportToPlayer(name)
    else
        print("Please enter a player name.")
    end
end)

-- Loop Teleport Button Action
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

-- Destroy Button Action
DestroyButton.MouseButton1Click:Connect(function()
    if MainGui then
        MainGui:Destroy()
        print("GUI Destroyed")
    end
end)

-- Camera Lock Variables
local isCameraLocked = false
local lockRadius = 50  -- Radius to find target players
local targetPlayer = nil

-- Function to Find Closest Player within Radius
local function findClosestPlayer()
    local closestDistance = lockRadius
    local closestPlayer = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (p.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance <= closestDistance then
                closestDistance = distance
                closestPlayer = p
            end
        end
    end
    return closestPlayer
end

-- Lock Camera Button Action
CameraLockButton.MouseButton1Click:Connect(function()
    isCameraLocked = not isCameraLocked
    CameraLockButton.Text = isCameraLocked and "Unlock Camera" or "Lock Camera"
    if isCameraLocked then
        local closestPlayer = findClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local camera = game.Workspace.CurrentCamera
            camera.CameraSubject = closestPlayer.Character.Humanoid
            camera.CameraType = Enum.CameraType.Attach
        end
    else
        local camera = game.Workspace.CurrentCamera
        camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid") or camera.CameraSubject
        camera.CameraType = Enum.CameraType.Custom
    end
end)
