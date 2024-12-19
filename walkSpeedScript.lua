-- Services
local userInput = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Variables
local jumpCount = 0
local walkSpeedState = 20 -- Default walk speed is 20
local resetTime = 0.3 -- Time (in seconds) to reset jump count after inactivity (set to 0.3)
local lastJumpTime = tick() -- Time of the last jump

-- Function to reset jump count if time between jumps is greater than resetTime
local function resetJumpCount()
    if tick() - lastJumpTime > resetTime then
        jumpCount = 0 -- Reset jump count if time between jumps exceeds 0.3 seconds
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

-- Set initial walk speed to 20
humanoid.WalkSpeed = walkSpeedState

-- Event listener for jump detection
userInput.JumpRequest:Connect(function()
    resetJumpCount() -- Reset if the time between jumps is too long

    jumpCount += 1
    lastJumpTime = tick
