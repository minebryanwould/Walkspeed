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

-- Set a background color to make sure the button is visible
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red background

-- Set the image for the button to the uploaded asset with Asset ID
button.Image = "rbxassetid://78883039855625"

-- Set the button's position to the center of the screen and size to 200x200
button.Position = UDim2.new(0.5, -100, 0.5, -100)  -- Center the button
button.Size = UDim2.new(0, 200, 0, 200)  -- Set size to 200x200 pixels

-- Variables
local walkSpeedState = 20 -- Default walk speed is 20

-- Function to toggle walk speed
local function toggleWalkSpeed()
    if walkSpeedState == 20 then
        walkSpeedState = 40
    else
        walkSpeedState = 20
    end

    humanoid.WalkSpeed = walkSpeedState -- Apply the new walk speed
end

-- When the button is clicked, toggle the walk speed
button.MouseButton1Click:Connect(function()
    toggleWalkSpeed()
end)

-- Reassign walk speed on respawn (if the player dies and respawns)
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = walkSpeedState -- Apply the saved walk speed to the new character
end)

-- Ensure walk speed is updated continuously during gameplay (check if humanoid exists)
game:GetService("RunService").Heartbeat:Connect(function()
    if humanoid then
        humanoid.WalkSpeed = walkSpeedState -- Continuously apply walk speed while in-game
    end
end)
