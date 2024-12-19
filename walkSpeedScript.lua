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
        jumpCount = 0
    end
end

-- Function to update walk speed after jumping 5 times
local function updateWalkSpeed()
    if jumpCount == 5 then
        if walkSpeedState == 40 then
            walkSpeedState = 20
        else
            walkSpeedState = 40
        end

        humanoid.WalkSpeed = walkSpeedState
        jumpCount = 0 -- Reset jump count after 5 jumps
    end
end

-- Event listener for jump detection
userInput.JumpRequest:Connect(function()
    resetJumpCount() -- Reset jump count if the player hasn't jumped for a while
    jumpCount += 1
    lastJumpTime = tick() -- Update the last jump time

    updateWalkSpeed() -- Check if it's time to change walk speed
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
