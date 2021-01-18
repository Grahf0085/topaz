-----------------------------------
-- Area: Windurst Waters
--  NPC: Pechiru-Mashiru
-- Involved in Quests: Hat in Hand
-- Finished Quest: Let Sleeping Dogs Lie
-- !pos 162 -2 159 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    function testflag(set, flag)
        return (set % (2*flag) >= flag)
    end
    hatstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HAT_IN_HAND)
    sleepingStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
    if ((hatstatus == 1  or player:getCharVar("QuestHatInHand_var2") == 1) and testflag(tonumber(player:getCharVar("QuestHatInHand_var")), 64) == false) then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, tpz.ki.NEW_MODEL_HAT)
        player:startEvent(54) -- Show Off Hat
    elseif (sleepingStatus == 1 and player:getCharVar("QuestSleepLie_var") == 3) then -- advance quest
        player:startEvent(495, 565661677, 4155, 1102, 1, 54796242, 5915088, 4095, 0)
    elseif (sleepingStatus == 1 and player:getCharVar("QuestSleepLie_var") == 4) then -- advance quest
        player:startEvent(496) 
    elseif (sleepingStatus == 1 and player:getCharVar("QuestSleepLie_var") == 5) then -- finish quest
        player:startEvent(497)
    else
        player:startEvent(421) -- Standard Conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 54) then  -- Show Off Hat
        player:addCharVar("QuestHatInHand_var", 64)
        player:addCharVar("QuestHatInHand_count", 1)
    elseif (csid == 495) then -- Let Sleeping Dogs Lie advance quest
        player:setCharVar("QuestSleepLie_var", 4)
    elseif (csid == 497) then -- Let Sleeping Dogs Lie: Quest Finish.  Get Hypno Staff
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 17117) -- hypno staff
        else
            player:addItem(17117, 1)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 17117) -- hypno staff
            player:setCharVar("QuestSleepLie_var", 0)

        end
    end
end
