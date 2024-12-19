-- Services
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local button = script.Parent -- This assumes the script is inside an ImageButton

-- Ensure the button is parented to a ScreenGui inside the PlayerGui
local screenGui = player.PlayerGui:FindFirstChildOfClass("ScreenGui")
if not screenGui then
    -- Create a ScreenGui if it doesn't exist
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
end
button.Parent = screenGui

-- Set button image and size
button.Image = "rbxassetid://78883039855625"
button.Position = UDim2.new(0, 590, 0, 5)  -- Position as per your request
button.Size = UDim2.new(0, 90, 0, 90)  -- Set size to 90x90 pixels

-- Default walk speed and variable to track current speed state
local walkSpeedState = 20
humanoid.WalkSpeed = walkSpeedState -- Apply the initial walk speed

-- Function to toggle walk speed when the button is clicked
local function toggleWalkSpeed()
    if walkSpeedState == 20 then
        walkSpeedState = 40
    else
        walkSpeedState = 20
    end
    humanoid.WalkSpeed = walkSpeedState -- Apply the new walk speed
end

-- Function to ensure the walk speed stays constant, even if slowed down
local function maintainWalkSpeed()
    humanoid.WalkSpeed = walkSpeedState -- Continuously apply the walk speed
end

-- Button click event to toggle walk speed
button.MouseButton1Click:Connect(function()
    toggleWalkSpeed() -- Toggle walk speed between 20 and 40
end)

-- Reassign walk speed on respawn (if the player dies and respawns)
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = walkSpeedState -- Apply the saved walk speed to the new character
end)

-- Continuously ensure the walk speed is maintained during gameplay
game:GetService("RunService").Heartbeat:Connect(function()
    maintainWalkSpeed() -- Ensure the walk speed is kept constant
end)
