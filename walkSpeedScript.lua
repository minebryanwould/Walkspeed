-- Services
local userInput = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables
local jumpCount = 0
local walkSpeedState = 40 -- Default walk speed is 40
local resetTime = 1 -- Time (in seconds) to reset jump count after inactivity
local lastJumpTime = tick()

-- Function to reset jump count after a period of time
local function resetJumpCount()
    if tick() - lastJumpTime > resetTime then
        jumpCount = 0 -- Only reset if the player hasn't jumped in 'resetTime' seconds
    end
end

-- Function to update walk speed after 5 or more jumps
local function updateWalkSpeed()
    if jumpCount >= 5 then
        if walkSpeedState == 40 then
            walkSpeedState = 20
        else
            walkSpeedState = 40
        end

        humanoid.WalkSpeed = walkSpeedState
        jumpCount = 0 -- Reset jump count after toggling walk speed
    end
end

-- Event listener for jump detection
userInput.JumpRequest:Connect(function()
    jumpCount += 1
    lastJumpTime = tick() -- Update the last jump time

    updateWalkSpeed() -- Check if it's time to change walk speed (5 or more jumps)
end)

-- Reassign walk speed on respawn (if the player dies and respawns)
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = walkSpeedState -- Apply the saved walk speed to the new character
end)
