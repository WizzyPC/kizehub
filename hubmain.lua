local World1, World2, World3, TestWorld = false, false, false, false

if game.PlaceId == 2753915549 then
    World1 = true
elseif game.PlaceId == 4442272183 then
    World2 = true
elseif game.PlaceId == 7449423635 then
    World3 = true
elseif game.PlaceId == 89819745167383 then
    TestWorld = true
else
    game:GetService("Players").LocalPlayer:Kick("Do not Support, Please wait...")
end

-- Serviços
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Tela principal
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "Kize Hub | v0.1"
screenGui.ResetOnSpawn = false

-- Tema
local theme = {
    background = Color3.fromRGB(20, 20, 20),
    accent = Color3.fromRGB(255, 165, 80), -- Laranja suave
    text = Color3.fromRGB(255, 255, 255),
    textSecondary = Color3.fromRGB(200, 200, 200),
    border = 5
}

-- Função para criar frames com UIBorder
local function createFrame(parent, size, position)
    local frame = Instance.new("Frame", parent)
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = theme.background
    frame.BorderSizePixel = 0 -- desativa borda padrão

    -- Borda visual moderna
    local border = Instance.new("UIStroke", frame)
    border.Thickness = 2
    border.Color = theme.accent
    border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    return frame
end


-- Hub principal
local mainFrame = createFrame(screenGui, UDim2.new(0, 800, 0, 500), UDim2.new(0.5, -400, 0.5, -250))
mainFrame.Name = "MainFrame"

local dragging = false
local dragInput, dragStart, startPos

mainFrame.Active = true
mainFrame.Draggable = true -- Ativa movimentação
mainFrame.Selectable = true

-- Alternativa com controle manual (caso queira mais precisão)
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Sidebar
local sidebar = createFrame(mainFrame, UDim2.new(0, 140, 1, 0), UDim2.new(0, 0, 0, 0))
sidebar.Name = "Sidebar"

-- Título
local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Kize Hub | v0.1"
title.TextColor3 = theme.text
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Abas
local tabs = {"Farming", "Player", "Teleport", "Raids", "Configs"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 20, 0, 70 + (i - 1) * 55) button.Size = UDim2.new(1, -40, 0, 45)
    button.Text = tabName
    button.TextColor3 = theme.text
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.BorderColor3 = theme.accent
    button.Font = Enum.Font.Gotham
    button.TextScaled = true

    local tabFrame = createFrame(mainFrame, UDim2.new(1, -150, 1, -20), UDim2.new(0, 150, 0, 10))
    tabFrame.Visible = i == 1
    tabFrames[tabName] = tabFrame

    button.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do frame.Visible = false end
        tabFrame.Visible = true
    end)
end

local farmingFrame = tabFrames["Farming"]

local bonesButton = Instance.new("TextButton", farmingFrame)
bonesButton.Size = UDim2.new(0, 200, 0, 40)
bonesButton.Position = UDim2.new(0, 20, 0, 20)
bonesButton.Text = "Farmar Bones"
bonesButton.TextColor3 = theme.text
bonesButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bonesButton.BorderColor3 = theme.accent
bonesButton.Font = Enum.Font.Gotham
bonesButton.TextScaled = true

local playerFrame = tabFrames["Player"]

local statDropdown = Instance.new("TextBox", playerFrame)
statDropdown.Size = UDim2.new(0, 200, 0, 40)
statDropdown.Position = UDim2.new(0, 20, 0, 20)
statDropdown.PlaceholderText = "Stat: Melee, Defense, etc"
statDropdown.TextColor3 = theme.text
statDropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statDropdown.BorderColor3 = theme.accent
statDropdown.Font = Enum.Font.Gotham
statDropdown.TextScaled = true

local statAmount = Instance.new("TextBox", playerFrame)
statAmount.Size = UDim2.new(0, 200, 0, 40)
statAmount.Position = UDim2.new(0, 20, 0, 70)
statAmount.PlaceholderText = "Quantidade"
statAmount.TextColor3 = theme.text
statAmount.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statAmount.BorderColor3 = theme.accent
statAmount.Font = Enum.Font.Gotham
statAmount.TextScaled = true

local applyStats = Instance.new("TextButton", playerFrame)
applyStats.Size = UDim2.new(0, 200, 0, 40)
applyStats.Position = UDim2.new(0, 20, 0, 120)
applyStats.Text = "Aplicar"
applyStats.TextColor3 = theme.text
applyStats.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
applyStats.BorderColor3 = theme.accent
applyStats.Font = Enum.Font.Gotham
applyStats.TextScaled = true

local teleportFrame = tabFrames["Teleport"]
local seas = {"Sea 1", "Sea 2", "Sea 3"}

for i, sea in ipairs(seas) do
    local btn = Instance.new("TextButton", teleportFrame)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0, 20, 0, 20 + (i - 1) * 50)
    btn.Text = sea
    btn.TextColor3 = theme.text
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BorderColor3 = theme.accent
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
end

local configFrame = tabFrames["Configs"]

local toggleFPS = Instance.new("TextButton", configFrame)
toggleFPS.Size = UDim2.new(0, 200, 0, 40)
toggleFPS.Position = UDim2.new(0, 20, 0, 20)
toggleFPS.Text = "Mostrar FPS"
toggleFPS.TextColor3 = theme.text
toggleFPS.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleFPS.BorderColor3 = theme.accent
toggleFPS.Font = Enum.Font.Gotham
toggleFPS.TextScaled = true

local raidFrame = tabFrames["Raids"]

local startRaid = Instance.new("TextButton", raidFrame)
startRaid.Size = UDim2.new(0, 200, 0, 40)
startRaid.Position = UDim2.new(0, 20, 0, 20)
startRaid.Text = "Iniciar Raid"
startRaid.TextColor3 = theme.text
startRaid.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
startRaid.BorderColor3 = theme.accent
startRaid.Font = Enum.Font.Gotham
startRaid.TextScaled = true


local UIS = game:GetService("UserInputService")

-- Botão de minimizar
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 5)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = theme.text
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minimizeButton.BorderColor3 = theme.accent
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true
minimizeButton.Name = "MinimizeButton"

-- Minimizar ao clicar
minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Reabrir com RightShift
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

OrionLib:Init()
OrionLib:MakeNotification({
    Name = "Kize Hub | Blox Fruits [ BETA ]  By yKizera",
    Content = "Loading Config Complete!",
    Image = "rbxassetid://109409871245462",
    Time = 5

})






