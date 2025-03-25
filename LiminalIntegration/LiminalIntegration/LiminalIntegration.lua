-- Aetheris Devs --
-- CONFIG --
local Debugging = false -- Currently breaks API




-- INIT --
avatar:store("liminalCompatInstalled", true)
nameplate.ENTITY:setBackgroundColor(0,0,0,0)
nameplate.ENTITY:setOutline(true):setOutlineColor(vectors.hexToRGB(avatar:getColor()) / 1.25)
models.LiminalTools.ItemKatana:setScale(1.6)
models.LiminalTools.ItemKatana.Runes.Fire.smallFlame:setScale(0.5)
models.LiminalTools.ItemFaelithCleaver:setScale(0.8, 1.2, 0.8)

--       /--------------\       --
--       | CUSTOM ITEMS |       --
--       \--------------/       --
function events.item_render(item)
    if item:getName() == "Faelith's Katana" and item.id == "minecraft:netherite_sword" then
        return models.LiminalTools.ItemKatana
    end
    if item:getName() == "Faelith's Cleaver" and item.id == "minecraft:mace" then
        return models.LiminalTools.ItemFaelithCleaver
    end
end


--       /-------------\       --
--       | FEALITH HUD |       --
--       \-------------/       --
local HudOn = true
function events.render()
    local size = -client.getScaledWindowSize()
    models.Hud.HUD:setPos(size.x/2,0,size.y/2)
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
    local HudModel = models.Hud.HUD
    models.Hud:setVisible(true)
    if boostsLeft == 0 then
      HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.NoneLeft"])
      HudModel:setOpacity(0.3)
    elseif boostsLeft == 1 then
      HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.OneLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 2 then
      HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.TwoLeft"])
      HudModel:setOpacity( 1)
    elseif boostsLeft == 3 then
      HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.ThreeLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 4 then
      HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.FourLeft"])
      HudModel:setOpacity(1)
    elseif boostsLeft == 5 then
        HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.FiveLeft"])
        HudModel:setOpacity(1)
    elseif boostsLeft == 6 then
        HudModel:setPrimaryTexture("CUSTOM", textures["LiminalIntegration.BoostTextures.SixLeft"])
        HudModel:setOpacity(1)
    end
    HudModel:setVisible(renderer:isFirstPerson())
end
function events.KEY_PRESS(key)
    player:isLoaded()
    -- 67 = C
    if key == 88 and boostsLeft > 0 and boostTimer <= 0 then
        goofy:setVelocity(player:getLookDir() * 1.25)
        boostsLeft = boostsLeft - 1
        --host:actionbar("Boosts Left: " .. tostring(boostsLeft)) REMOVED BECAUSE HUD IS INSTALLED
        boostTimer = 10
    end
end

-- !!DASHING!! --
-- !!DASHING!! --





-- stuff