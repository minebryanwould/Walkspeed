local player = game.Players.LocalPlayer
local button = script.Parent
local walkSpeedState = 20

button.Image = "rbxassetid://78883039855625"
button.Position = UDim2.new(0, 590, 0, 5)
button.Size = UDim2.new(0, 90, 0, 90)
button.ImageTransparency = 0.5

button.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        walkSpeedState = (walkSpeedState == 20) and 40 or 20
        humanoid.WalkSpeed = walkSpeedState
    end
end)

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = walkSpeedState
end)
