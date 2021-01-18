-----------------------------------
-- Area: Windurst Waters
--  NPC: Ropunono
-- Starts and Finished Quest: Heaven Cent
-- Working 100%
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
-----------------------------------

function shuffle(tbl)  -- used to select 3/6 treasure chests to be opened in Maze of Shakhrami
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end


function onTrade(player, npc, trade)
    local heavenstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HEAVEN_CENT)
    if (heavenstatus == 1 and trade:getItemCount() == 1 and trade:getGil() == 0 and trade:hasItemQty(557, 1) == true) then -- trade Ahriman lens to NPC to proceed with quest
        player:startEvent(288, 0, 557, 545)
    elseif (heavenstatus == 1 and player:getCharVar("QuestHeavenCent_RightChest") == 0 and trade:getItemCount() == 1 and trade:getGil() == 0 and trade:hasItemQty(545, 1) == true) then -- got a fake shelling piece
        player:startEvent(296)
    elseif (heavenstatus == 1 and player:getCharVar("QuestHeavenCent_RightChest") == 2 and trade:getItemCount() == 1 and trade:getGil() == 0 and trade:hasItemQty(545, 1) == true) then -- got real shelling piece
        player:startEvent(292)
    end
end

function onTrigger(player, npc)
    local heavenstatus = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.HEAVEN_CENT)
    if (player:getFameLevel(WINDURST) >= 5 and heavenstatus == 0) then -- starts quest heaven cent
        player:startEvent(284)
    elseif (heavenstatus == 1 and player:getCharVar("QuestHeavenCent_1") == 0) then -- another conversation during heaven cent
        player:startEvent(285)
    elseif (heavenstatus == 1 and player:getCharVar("QuestHeavenCent_1") ~= 0) then -- after turning in Ahriman Lens
        rand = math.random(1, 2)
        if (rand == 1) then
            player:startEvent(289, 0, 545)
        else
            player:startEvent(297)
        end
    else
        player:startEvent(283) -- standard conversation
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 284) then
        player:addQuest(WINDURST, tpz.quest.id.windurst.HEAVEN_CENT)
    elseif (csid == 288) then
        player:tradeComplete(trade)
        local shuffled_list = shuffle{1, 2, 3, 4, 5, 6}  -- randomly select three numbers to be used to select chests in Maze of Shakhrami
        player:setCharVar("QuestHeavenCent_1", shuffled_list[1])
        player:setCharVar("QuestHeavenCent_2", shuffled_list[2])
        player:setCharVar("QuestHeavenCent_3", shuffled_list[3])
    elseif (csid == 292) then
        player:completeQuest(WINDURST, tpz.quest.id.windurst.HEAVEN_CENT)
        player:addFame(WINDURST, 85)
        player:addTitle(tpz.title.NIGHT_SKY_NAVIGATOR)
        player:addGil(GIL_RATE*4800)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*4800)
        player:tradeComplete(trade)
        player:setCharVar("QuestHeavenCent_1", 0)
        player:setCharVar("QuestHeavenCent_2", 0)
        player:setCharVar("QuestHeavenCent_3", 0)
        player:setCharVar("QuestHeavenCent_RightChest", 0)
    end 
end
