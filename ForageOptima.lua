-- ForageOptima.lua
-- FS22_ForageOptima
--
-- Author: Luke Bradbury
-- Version: 1.0.0
-- Date: 2023-03-25
--
-- Description:
-- LFHA Forage Optima is a standard that improves Forage Harvester operations

ForageHay = {}
ForageHay.xmlFileId = loadXMLFile("FS22_ForageHay", g_currentModDirectory .. "ForageOptima.xml")

-- Function to load map and alterations for the ForageHay mod
function ForageHay:loadMap(name)
    -- Load Fill Type Alterations from the ForageOptima.xml file
    if not g_fillTypeManager:loadFillTypes(ForageHay.xmlFileId) then
        print("Failed to load additional FillTypes")
    end

    -- Load Fruit Type Alterations from the ForageOptima.xml file
    if not g_fruitTypeManager:loadFruitTypes(ForageHay.xmlFileId) then
        print("Failed to load additional FruitTypes")
    end
end

-- Add the ForageHay mod as an event listener to execute the loadMap function when the map is loaded
addModEventListener(ForageHay)
