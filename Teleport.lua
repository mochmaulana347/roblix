-- Setup GUI Utama
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainGUI"
ScreenGui.Parent = playerGui

-- Frame for Main GUI
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- Styling for Main GUI
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
UIGradient.Parent = Frame

-- Title Label
local Title = Instance.new("TextLabel")
Title.Text = "Main GUI"
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Name Input
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0.2, 0)
NameInput.Position = UDim2.new(0.05, 0, 0.25, 0)
NameInput.PlaceholderText = "Enter username or display name"
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NameInput.BorderSizePixel = 0
NameInput.TextScaled = true
NameInput.Font = Enum.Font.Gotham
NameInput.Parent = Frame

-- Teleport Button
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.9, 0, 0.15, 0)
TeleportButton.Position = UDim2.new(0.05, 0, 0.45, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "Teleport"
TeleportButton.TextScaled = true
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.BorderSizePixel = 0
TeleportButton.Parent = Frame

-- Loop Teleport Button
local LoopButton = Instance.new("TextButton")
LoopButton.Size = UDim2.new(0.9, 0, 0.15, 0)
LoopButton.Position = UDim2.new(0.05, 0, 0.65, 0)
LoopButton.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
LoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoopButton.Text = "Loop Teleport"
LoopButton.TextScaled = true
LoopButton.Font = Enum.Font.Gotham
LoopButton.BorderSizePixel = 0
LoopButton.Parent = Frame

-- Destroy GUI Button
local DestroyButton = Instance.new("TextButton")
DestroyButton.Size = UDim2.new(0.9, 0, 0.15, 0)
DestroyButton.Position = UDim2.new(0.05, 0, 0.85, 0)
DestroyButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
DestroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DestroyButton.Text = "Destroy GUI"
DestroyButton.TextScaled = true
DestroyButton.Font = Enum.Font.Gotham
DestroyButton.BorderSizePixel = 0
DestroyButton.Parent = Frame

-- Create Control GUI
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
ToggleButton.Text = "Toggle Camera Lock"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.BorderSizePixel = 0
ToggleButton.Parent = ControlFrame

-- Variables for GUI Visibility
local isGuiVisible = true

-- Function to Toggle GUI Visibility
local function toggleGuiVisibility()
    if ScreenGui then
        isGuiVisible = not isGuiVisible
        Frame.Visible = isGuiVisible
    end
end

-- Control Button Action
ToggleButton.MouseButton1Click:Connect(function()
    toggleGuiVisibility()
end)

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
    if ScreenGui then
        ScreenGui:Destroy()
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

-- Function to Lock Camera to Target
local function lockCameraToTarget()
    local camera = game.Workspace.CurrentCamera
    game:GetService("RunService").RenderStepped:Connect(function()
        if isCameraLocked and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position)
        end
    end)
end

-- Camera Lock Button Action
ToggleButton.MouseButton1Click:Connect(function()
    isCameraLocked = not isCameraLocked
    if isCameraLocked then
        ToggleButton.Text = "Unlock Camera"
        targetPlayer = findClosestPlayer()
        if targetPlayer then
            lockCameraToTarget()
        else
            print("No player found within radius.")
        end
    else
        ToggleButton.Text = "Lock Camera"
        targetPlayer = nil
    end
end)

-- Dragging GUI
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
