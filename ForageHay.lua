ForageHay = {}
ForageHay.xmlFileId = loadXMLFile("FS22_ForageHay", g_currentModDirectory .. "ForageHay.xml")

function ForageHay:loadMap(name)
    -- Load Fill Type Alterations
    if not g_fillTypeManager:loadFillTypes(ForageHay.xmlFileId) then
        print("Failed to load additional FillTypes")
    end

    -- Load Fruit Type Alterations
    if not g_fruitTypeManager:loadFruitTypes(ForageHay.xmlFileId) then

        print("Failed to load additional FruitTypes")
    end
end

addModEventListener(ForageHay)