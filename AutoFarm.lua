-- Define the number of loops 
local loopCount = 100000
print("This Script DOES NOT provide an anti disconnect")

local teleportPositions = {
    Vector3.new(-53, 66, 2074), -- Position 1
    Vector3.new(-71, 101, 2739), -- Position 2
    Vector3.new(-54, -355, 9503), -- Position 3
    Vector3.new(-53, 83, 3610), -- Position 4
    Vector3.new(-44, 90, 4356), -- Position 5
    Vector3.new(-47, 82, 4685), -- Position 6
    Vector3.new(-150, 19, 5906), -- Position 7
    Vector3.new(-159, 19, 6019), -- Position 8
    Vector3.new(-172, 42, 7361), -- Position 9
    Vector3.new(-54, 53, 7967), -- Position 10
}

-- Function to create a temporary platform
local function createPlatform(position)
    local platform = Instance.new("Part")
    platform.Size = Vector3.new(1, 0.001, 1) -- Set the size of the platform
    platform.Position = position - Vector3.new(0, 3, 0) -- Place it just below the teleport position
    platform.Anchored = true -- Ensure the platform doesn't fall
    platform.Parent = workspace

    -- Destroy the platform after 1.69 seconds
    game:GetService("Debris"):AddItem(platform, 1.69)
end

-- Function to teleport the player
local function teleportPlayer(position)
    -- Ensure the script is being run in an environment where a player object exists
    local player = game.Players.LocalPlayer
    if not player then
        warn("No local player found. Make sure this script is run in a client environment.")
        return
    end

    -- Get the player's character
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart") -- The main body part for movement

    -- Teleport the character
    humanoidRootPart.CFrame = CFrame.new(position)

    -- Create a platform below the teleport position
    createPlatform(position)
end

-- Function to kill the player
local function killPlayer()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = 0 -- Set health to 0 to kill the player
        end
    end
end

-- Loop through the teleport and kill sequence
for _ = 1, loopCount do
    -- Teleport the player to each position in the list
    for _, position in ipairs(teleportPositions) do
        teleportPlayer(position)
        wait(1.75) -- Wait 1.75 seconds between teleports
    end

    -- Kill the player after completing all teleports
    killPlayer()
    wait(1) -- Wait 1 second after killing
end
