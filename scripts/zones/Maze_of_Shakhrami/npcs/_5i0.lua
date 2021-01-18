-----------------------------------
-- Area: Maze of Shakhrami
-- Quest: Corsair Af1 "Equipped for All Occasions"
--  NPC: Iron Door (Spawn Lost Soul)
-- !pos 247.735 18.499 -142.267 198
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:getGil() == 0 and trade:hasItemQty(543, 1) == true and player:getCharVar("irondoor") == 0) then -- trade rusty key to enter room
        player:startEvent(41)
        player:setCharVar("irondoor", 1)    
    end
end

function onTrigger(player, npc)
    local efao = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS)
    local efaoStat = player:getCharVar("EquippedforAllOccasions")

    if efao == QUEST_ACCEPTED and efaoStat == 1 and npcUtil.popFromQM(player, npc, ID.mob.LOST_SOUL, {hide = 0}) then
        -- no further action
    elseif efao == QUEST_ACCEPTED and efaoStat == 2 then
        player:startEvent(66)
    elseif (player:getCharVar("irondoor") == 1) then -- to exit room behind iron door
        player:startEvent(42)
        player:setCharVar("irondoor", 0)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 66 then
        npcUtil.giveKeyItem(player, tpz.ki.WHEEL_LOCK_TRIGGER)
        player:setCharVar("EquippedforAllOccasions", 3)
    end
end
