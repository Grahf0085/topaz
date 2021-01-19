-----------------------------------
-- Area: Port Windurst
--  NPC: Maabu-Sonbu
-- Working 100%
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED and player:getCharVar("QuestSleepLie_var") == 1) then
        player:startEvent(319, 0, 4155, 1102, 1020) -- During Let Sleeping Dogs Lie: Remedy, Blazing Peppers, sickle
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED and player:getCharVar("QuestSleepLie_var") == 2) then
        player:startEvent(320, 565661072, 4155, 1102, 1020, 0, 0, 0, 0)  -- Another conversation during Let Sleeping Dogs Lie
    elseif (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.LET_SLEEPING_DOGS_LIE) == QUEST_ACCEPTED and player:getCharVar("QuestSleepLie_var") == 3) then
        player:startEvent(321, 0, 1102) -- Let Sleeping Dogs Lie: optional dialogue: blazing peppers
    else
        player:startEvent(227)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 319) then
        player:setCharVar("QuestSleepLie_var", 2)
    end
end
