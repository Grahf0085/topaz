-----------------------------------
-- Area: Maze of Shakhrami
-- Quest: Heaven Cent
--  NPC: Chest
-- !pos ????
-----------------------------------
local ID = require("scripts/zones/Maze_of_Shakhrami/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local avatarNumber = math.random(1,8)
    local avatarName
    local direction
    local direction_list = {"North-East", "South-East", "North-West", "West", "North", "South-West", "East", "South"}
    
    if (player:getCharVar("QuestHeavenCent_1") == 2) then
        if (avatarNumber == 1) then 
            avatarName = "Alexander"
            direction = "North-East"
        elseif (avatarNumber == 2) then 
            avatarName = "Garuda"
            direction = "South-East"
        elseif (avatarNumber == 3) then 
            avatarName = "Ifrit"
            direction = "North-West"
        elseif (avatarNumber == 4) then 
            avatarName = "Leviathan"
            direction = "West"
        elseif (avatarNumber == 5) then 
            avatarName = "Odin"
            direction = "North"
        elseif (avatarNumber == 6) then 
            avatarName = "Ramuh"
            direction = "South-West"
        elseif (avatarNumber == 7) then 
            avatarName = "Shiva"
            direction = "East"
        elseif (avatarNumber == 8) then 
            avatarName = "Titan"
            direction = "South"
        end
        player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
        player:startEvent(46)
        player:setCharVar("QuestHeavenCent_RightChest", 1)
    elseif (player:getCharVar("QuestHeavenCent_2") == 2 or player:getCharVar("QuestHeavenCent_3") == 2) then
        direction = direction_list[math.random(1,8)]
        if (avatarNumber == 1) then
            while (direction == "North-East")
            do
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Alexander"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 2) then
            while (direction == "South-East")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Garuda"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 3) then
            while (direction == "North-West")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Ifrit"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 4) then
            while (direction == "West")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Leviathan"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 5) then
            while (direction == "North")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Odin"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 6) then
            while (direction == "South-West")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Ramuh"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 7) then
            while (direction == "East")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Shiva"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        elseif (avatarNumber == 8) then
            while (direction == "South")
            do   
                direction = direction_list[math.random(1,8)]
            end
            avatarName = "Titan"
            player:PrintToPlayer(string.format("You picked up a coin with %s drawn to the %s", avatarName, direction),0,"Chest")
            player:startEvent(46)
        end    
    else
        rand = math.random(1, 3)
        if (rand == 1) then
            player:PrintToPlayer(string.format("The chest is too heavy to open."),0," ")
        elseif (rand == 2) then
            player:PrintToPlayer(string.format("The chest is too dirty to touch."),0," ")
        elseif (rand == 3) then
            player:PrintToPlayer(string.format("The chest has a spider on it."),0," ")
        end 
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 46 and option == 1 and player:getFreeSlotsCount() > 0 and player:getCharVar("QuestHeavenCent_RightChest") == 1) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 545)
        player:addItem(545)
        player:setCharVar("QuestHeavenCent_RightChest", 2)
    elseif (csid == 46 and option == 1 and player:getFreeSlotsCount() > 0 and player:getCharVar("QuestHeavenCent_RightChest") == 0) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 545)
        player:addItem(545)
        player:setCharVar("QuestHeavenCent_RightChest", 0)
    end
end
