-- Services
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local button = script.Parent -- This assumes the script is inside an ImageButton

-- Variables
local walkSpeedState = 20 -- Default walk speed is 20

-- Set the image for the button to the uploaded asset with Asset ID
button.Image = "rbxassetid://78883039855625"

-- Set the button's position
button.Position = UDim2.new(0, 590, 0, 5)

-- Set the button's size to 90 pixels width and height
button.Size = UDim2.new(0, 90, 0, 90)

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

-- Ensure walk speed is updated continuously during gameplay
game:GetService("RunService").Heartbeat:Connect(function()
    humanoid.WalkSpeed = walkSpeedState -- Continuously apply walk speed while in-game
end)
