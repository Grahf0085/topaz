-----------------------------------
-- Area: Windurst Waters
--  NPC: Paku-Nakku
--  Involved in Quest: Making the Grade
-- !pos 127 -6 165 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local sleepingStatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
    if (sleepingStatus == 1 and player:getCharVar("QuestSleepLie_var") == 2 and trade:getItemCount() == 1 and trade:getGil() == 0) and trade:hasItemQty(1102, 1) == true then -- Let Sleeping Dogs Lie: Quest Turn In: Blazing Peppers turned in
        player:startEvent(494, 565661232, 1, 1752, 0, 54796242, 5915088, 4095, 0)
    end
end

function onTrigger(player, npc)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(452) -- During Making the GRADE
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED) and player:getCharVar("QuestSleepLie_var") == 4 then
        player:startEvent(499) 
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED) then
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(481) -- During Let Sleeping Dogs Lie
        else
            player:startEvent(482) -- Another conversation during Let Sleeping Dogs Lie
        end   
    else
        player:startEvent(431)  -- Standard conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 481 or csid == 482) then -- track Let Sleeping Dogs Lie Progress
        if (player:getCharVar("QuestSleepLie_var") <= 1) then
            player:setCharVar("QuestSleepLie_var", 1)
        end
    elseif (csid == 494) then -- Let Sleeping Dogs Lie: trading blazing peppers to advance quest
        player:tradeComplete(trade)
        player:setCharVar("QuestSleepLie_var", 3)
    elseif (csid == 499 and option == 2) then -- Let Sleeping Dogs Lie: chose correct dialogue to advance quest
        player:setCharVar("QuestSleepLie_var", 5)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE)
        player:addTitle(tpz.title.SPOILSPORT)
        player:addFame(WINDURST, 75)
    end
end
