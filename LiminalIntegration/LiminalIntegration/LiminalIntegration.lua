-- Aetheris Devs --
-- CONFIG --
local Debugging = false -- Currently breaks API
local EZAnims = require("EZAnims")

-- Get Anim Poses --
local AttackR = EZAnims.controller:getState("attackR")
local AttackL = EZAnims.controller:getState("attackL")

-- INIT --
nameplate.ENTITY:setBackgroundColor(0,0,0,0)
nameplate.ENTITY:setOutline(true):setOutlineColor(vectors.hexToRGB(avatar:getColor()) / 1.25)
models.LiminalIntegration.LiminalTools.Skull:setScale(5, 100, 5)
models.LiminalIntegration.LiminalTools.ItemFaelithKatana:setScale(1.6)
models.LiminalIntegration.LiminalTools.ItemKatanaRUNES:setScale(1.6)
models.LiminalIntegration.LiminalTools.ItemFaelithCleaver:setScale(0.8, 1.2, 0.8)

--       /--------------\       --
--       | CUSTOM ITEMS |       --
--       \--------------/       --
function events.item_render(item)
    if item:getName() == "Faelith's Katana" and item.id == "minecraft:netherite_sword" then
        if IsFaelith then return models.LiminalIntegration.LiminalTools.ItemKatanaRUNES end
        return models.LiminalIntegration.LiminalTools.ItemFaelithKatana
    end
    if item:getName() == "Faelith's Cleaver" and item.id == "minecraft:mace" then
        return models.LiminalIntegration.LiminalTools.ItemFaelithCleaver
    end
    --[[
    if item:getName() == "Divine Fate" and item.id == "minecraft:player_head" then
        return models.LiminalTools.ItemDivineFate
    end
    ]]
end


--       /-------------\       --
--       | FEALITH HUD |       --
--       \-------------/       --
local HudOn = true
function events.render()
    local size = -client.getScaledWindowSize()
    models.LiminalIntegration.Hud.HUD:setPos(size.x/2,0,size.y/2)
end
-- Is it Faelith? (Kitzuki/Liminal's Mouthpiece) --
IsFaelith = false
local currentPlayer = "mepMep"
function events.tick()
    player:isLoaded()
    currentPlayer = player:getName()
    if currentPlayer == "Ktzukii" and host:isHost() then
        IsFaelith = true
    else
        IsFaelith = false
    end    
end

-- !!DASHING!! --
-- !!DASHING!! --
local canBoost = true -- do not touch
local boostsLeft = 4 -- do not touch
local onGround = true -- do not touch
local boostTimer = 10 -- In Ticks!
function events.tick()
    -- Dash Timer
    player:isLoaded()
    if host:isHost() then -- do not touch
        -- On Ground check
        onGround = player:isOnGround() or world.getBlockState(player:getPos():add(0, -0.05, 0)):hasCollision()
        if onGround then
            if IsFaelith then
                boostsLeft = 6
            else
                boostsLeft = 4
            end
        end
        -- Boost Timer
        if boostTimer > 0 then
            boostTimer = boostTimer - 1
        end
    end
end
function events.render()
    -- Boost Textures
    local HudModel = models.LiminalIntegration.Hud.HUD
    local texDirectory = LiminalIntegration.BoostTextures
    models.LiminalTools.Hud:setVisible(true)
    if boostsLeft == 0 then
      HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.NoneLeft"])
      HudModel:setOpacity(0.3)
    elseif boostsLeft == 1 then
      HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.OneLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 2 then
      HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.TwoLeft"])
      HudModel:setOpacity( 1)
    elseif boostsLeft == 3 then
      HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.ThreeLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 4 then
      HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.FourLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 5 then
        HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.FiveLeft"])
        HudModel:setOpacity(1)
    elseif boostsLeft == 6 then
        HudModel:setPrimaryTexture("CUSTOM", textures["texDirectory.SixLeft"])
        HudModel:setOpacity(1)
    end
    HudModel:setVisible(renderer:isFirstPerson())
end
function events.KEY_PRESS(key)
    player:isLoaded()
    -- 67 = C
    -- 88 = X
    -- 90 = Z
    if key == 88 and boostsLeft > 0 and boostTimer <= 0 and host:isHost() then
        goofy:setVelocity(player:getLookDir() * 1.25)
        boostsLeft = boostsLeft - 1
        --host:actionbar("Boosts Left: " .. tostring(boostsLeft)) REMOVED BECAUSE HUD IS INSTALLED
        boostTimer = 10
    end
end

-- !!DASHING!! --
-- !!DASHING!! --





-- stuff