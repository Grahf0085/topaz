-----------------------------------
-- Area: Windurst Waters
--  NPC: Akkeke
-- Involved in Quest: Making the Grade
-- !pos 135 -6 165 238
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.MAKING_THE_GRADE) == QUEST_ACCEPTED) then
        player:startEvent(453) -- During Making the GRADE
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED and player:getCharVar("QuestSleepLie_var") > 5) then
        player:startEvent(484) -- During Let Sleeping Dogs Lie
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED and player:getCharVar("QuestSleepLie_var") == 5) then
        player: startEvent(502) -- Let Sleeping Dogs Lie after choosing automation butlet did it
    else
        player:startEvent(427)  -- Standard conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
