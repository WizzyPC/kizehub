-- Identificação do mundo
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
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Tela principal
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "Kize Hub | v0.1"
screenGui.ResetOnSpawn = false

-- Tema refinado
local theme = {
    background = Color3.fromRGB(20, 20, 20),
    accent = Color3.fromRGB(255, 165, 80),
    text = Color3.fromRGB(255, 255, 255),
    textSecondary = Color3.fromRGB(200, 200, 200),
    border = 5
}

-- Função para criar frames com borda moderna
local function createFrame(parent, size, position)
    local frame = Instance.new("Frame", parent)
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = theme.background
    frame.BorderSizePixel = 0

    local border = Instance.new("UIStroke", frame)
    border.Thickness = 2
    border.Color = theme.accent
    border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    return frame
end

-- Hub principal
local mainFrame = createFrame(screenGui, UDim2.new(0, 800, 0, 500), UDim2.new(0.5, -400, 0.5, -250))
mainFrame.Name = "MainFrame"
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Selectable = true

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
local tabs = {"Farming", "Player", "Teleport", "Raids", "Configs", "Admin"}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, -40, 0, 45)
    button.Position = UDim2.new(0, 20, 0, 70 + (i - 1) * 55)
    button.Text = tabName
    button.TextColor3 = theme.text
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.Font = Enum.Font.Gotham
    button.TextScaled = true

    local stroke = Instance.new("UIStroke", button)
    stroke.Thickness = 2
    stroke.Color = theme.accent
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local tabFrame = createFrame(mainFrame, UDim2.new(1, -150, 1, -20), UDim2.new(0, 150, 0, 10))
    tabFrame.Visible = i == 1
    tabFrames[tabName] = tabFrame

    button.MouseButton1Click:Connect(function()
        for _, frame in pairs(tabFrames) do frame.Visible = false end
        tabFrame.Visible = true
    end)
end

-- FARMING: Auto Farm Level
local autoFarmEnabled = false

local autoFarmToggle = Instance.new("TextButton", tabFrames["Farming"])
autoFarmToggle.Size = UDim2.new(0, 200, 0, 40)
autoFarmToggle.Position = UDim2.new(0, 20, 0, 80)
autoFarmToggle.Text = "Auto Farm: OFF"
autoFarmToggle.TextColor3 = theme.text
autoFarmToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoFarmToggle.Font = Enum.Font.Gotham
autoFarmToggle.TextScaled = true

local strokeAF = Instance.new("UIStroke", autoFarmToggle)
strokeAF.Thickness = 2
strokeAF.Color = theme.accent
strokeAF.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

autoFarmToggle.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmToggle.Text = autoFarmEnabled and "Auto Farm: ON" or "Auto Farm: OFF"
end)

-- FARMING: Auto Boss Farm
local bossFarmEnabled = false

local bossFarmToggle = Instance.new("TextButton", tabFrames["Farming"])
bossFarmToggle.Size = UDim2.new(0, 200, 0, 40)
bossFarmToggle.Position = UDim2.new(0, 20, 0, 140)
bossFarmToggle.Text = "Boss Farm: OFF"
bossFarmToggle.TextColor3 = theme.text
bossFarmToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bossFarmToggle.Font = Enum.Font.Gotham
bossFarmToggle.TextScaled = true

local strokeBF = Instance.new("UIStroke", bossFarmToggle)
strokeBF.Thickness = 2
strokeBF.Color = theme.accent
strokeBF.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

bossFarmToggle.MouseButton1Click:Connect(function()
    bossFarmEnabled = not bossFarmEnabled
    bossFarmToggle.Text = bossFarmEnabled and "Boss Farm: ON" or "Boss Farm: OFF"
end)

-- STATS: Auto Stats
local autoStatsEnabled = false

local autoStatsToggle = Instance.new("TextButton", tabFrames["Player"])
autoStatsToggle.Size = UDim2.new(0, 200, 0, 40)
autoStatsToggle.Position = UDim2.new(0, 20, 0, 180)
autoStatsToggle.Text = "Auto Stats: OFF"
autoStatsToggle.TextColor3 = theme.text
autoStatsToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoStatsToggle.Font = Enum.Font.Gotham
autoStatsToggle.TextScaled = true

local strokeAS = Instance.new("UIStroke", autoStatsToggle)
strokeAS.Thickness = 2
strokeAS.Color = theme.accent
strokeAS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

autoStatsToggle.MouseButton1Click:Connect(function()
    autoStatsEnabled = not autoStatsEnabled
    autoStatsToggle.Text = autoStatsEnabled and "Auto Stats: ON" or "Auto Stats: OFF"
end)

-- RAID: Auto Raid
local autoRaidEnabled = false

local autoRaidToggle = Instance.new("TextButton", tabFrames["Raids"])
autoRaidToggle.Size = UDim2.new(0, 200, 0, 40)
autoRaidToggle.Position = UDim2.new(0, 20, 0, 80)
autoRaidToggle.Text = "Auto Raid: OFF"
autoRaidToggle.TextColor3 = theme.text
autoRaidToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoRaidToggle.Font = Enum.Font.Gotham
autoRaidToggle.TextScaled = true

local strokeAR = Instance.new("UIStroke", autoRaidToggle)
strokeAR.Thickness = 2
strokeAR.Color = theme.accent
strokeAR.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

autoRaidToggle.MouseButton1Click:Connect(function()
    autoRaidEnabled = not autoRaidEnabled
    autoRaidToggle.Text = autoRaidEnabled and "Auto Raid: ON" or "Auto Raid: OFF"
end)

-- ESP: Frutas e Mobs
local espEnabled = false

local espToggle = Instance.new("TextButton", tabFrames["Configs"])
espToggle.Size = UDim2.new(0, 200, 0, 40)
espToggle.Position = UDim2.new(0, 20, 0, 80)
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = theme.text
espToggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espToggle.Font = Enum.Font.Gotham
espToggle.TextScaled = true

local strokeESP = Instance.new("UIStroke", espToggle)
strokeESP.Thickness = 2
strokeESP.Color = theme.accent
strokeESP.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = espEnabled and "ESP: ON" or "ESP: OFF"
end)

-- 🔐 Webhook para envio de keys
local WebhookURL = "https://discord.com/api/webhooks/1424429444327674100/1AHbpGgWxHkcr1_2s7AP2-QTMfSudk3dUi26xKLl_jO5qjzOFEKv-Jl7fONhWZa3_7bJ" 

local function sendKeyToDiscord(key, duration)
    local data = {
        ["content"] = "**Nova Key Gerada**\n🔑 Key: `" .. key .. "`\n⏳ Validade: " .. duration
    }
    HttpService:PostAsync(WebhookURL, HttpService:JSONEncode(data))
end

local function generateKey(permanent)
    local key = "KIZE-" .. math.random(100000,999999)
    local duration = permanent and "Permanente" or "1 Dia"
    sendKeyToDiscord(key, duration)
end

-- 👑 Aba Admin (visível apenas para o dono)
local ownerId = 2966646294 -- substitua pelo seu ID real
if player.UserId == ownerId then
    local adminFrame = tabFrames["Admin"]
    adminFrame.Visible = false -- só aparece se clicar

    local key1Day = Instance.new("TextButton", adminFrame)
    key1Day.Size = UDim2.new(0, 200, 0, 40)
    key1Day.Position = UDim2.new(0, 20, 0, 20)
    key1Day.Text = "Gerar Key (1 Dia)"
    key1Day.TextColor3 = theme.text
    key1Day.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    key1Day.Font = Enum.Font.Gotham
    key1Day.TextScaled = true

    local strokeK1 = Instance.new("UIStroke", key1Day)
    strokeK1.Thickness = 2
    strokeK1.Color = theme.accent
    strokeK1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    key1Day.MouseButton1Click:Connect(function()
        generateKey(false)
    end)

    local keyPermanent = Instance.new("TextButton", adminFrame)
    keyPermanent.Size = UDim2.new(0, 200, 0, 40)
    keyPermanent.Position = UDim2.new(0, 20, 0, 80)
    keyPermanent.Text = "Gerar Key (Permanente)"
    keyPermanent.TextColor3 = theme.text
    keyPermanent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    keyPermanent.Font = Enum.Font.Gotham
    keyPermanent.TextScaled = true

    local strokeKP = Instance.new("UIStroke", keyPermanent)
    strokeKP.Thickness = 2
    strokeKP.Color = theme.accent
    strokeKP.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    keyPermanent.MouseButton1Click:Connect(function()
        generateKey(true)
    end)
else
    tabFrames["Admin"].Visible = false
end

-- 🔽 Minimizar e reabrir com RightShift
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 5)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = theme.text
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextScaled = true

local strokeMin = Instance.new("UIStroke", minimizeButton)
strokeMin.Thickness = 2
strokeMin.Color = theme.accent
strokeMin.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- ✅ Dica: substitua pelo seu ID real para ativar a aba Admin
-- local ownerId = 123456789

-- ✅ Dica: substitua pelo seu Webhook real do Discord
-- local WebhookURL = "https://discord.com/api/webhooks/SEU_WEBHOOK_AQUI"

-- ✅ Dica: para adicionar mais funções, siga o padrão:
-- 1. Crie um botão na aba desejada
-- 2. Adicione UIStroke para borda
-- 3. Conecte a função com MouseButton1Click
-- 4. Use spawn(function() ... end) para loops

-- ✅ Dica: para proteger o Hub com sistema de key, você pode:
-- - Criar uma tela de login inicial
-- - Validar a key digitada com HttpService:GetAsync() em um servidor
-- - Liberar o Hub apenas se a key for válida

-- ✅ Dica: para deixar o Hub ainda mais bonito:
-- - Adicione UIGradient nos botões
-- - Use imagens com ImageLabel para ícones
-- - Adicione animações com TweenService

-- ✅ Dica: para empacotar como loader:
-- - Hospede o script no GitHub ou Pastebin
-- - Use loadstring(game:HttpGet("URL"))() no Xeno

-- ✅ Finalização
print("Kize Hub v0.1 carregado com sucesso!")

