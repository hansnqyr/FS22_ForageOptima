ForageHayPickup = {}
ForageHayPickup.modDir = g_currentModDirectory
ForageHayPickup.xmlFileId = loadXMLFile("FS22_ForageHay", ForageHayPickup.modDir .. "ForageHay.xml")

function ForageHayPickup:loadMap(name)

    -- Add Hay to Forage Harvester Fill Type Category
    local dryGrassWindrowFillType = g_fillTypeManager:getFillTypeByName("DRYGRASS_WINDROW")
    local fillTypeCategoryForageHarvester = g_fillTypeManager.nameToCategoryIndex.FORAGEHARVESTER
    if dryGrassWindrowFillType ~= nil and fillTypeCategoryForageHarvester ~= nil then
        g_fillTypeManager:addFillTypeToCategory(dryGrassWindrowFillType.index, fillTypeCategoryForageHarvester)
        print("FillType 'DRYGRASS_WINDROW' added to FillTypeCategory 'FORAGEHARVESTER'")
    else
        print("FillType 'DRYGRASS_WINDROW' not found")
    end




    -- Add Drygrass Fruit Type
    if g_fruitTypeManager:loadFruitTypes(ForageHayPickup.xmlFileId) then
        print("Additional FruitTypes loaded")
    else
        print("Failed to load additional FruitTypes")
    end

    -- Add Drygrass to Pickup Fruit Type Category
    local pickupFruitTypeCategory = g_fruitTypeManager.categories.PICKUP
    local dryGrassFruitType = g_fruitTypeManager:getFruitTypeByName("DRYGRASS")
    if pickupFruitTypeCategory ~= nil and dryGrassFruitType ~= nil then
        g_fruitTypeManager:addFruitTypeToCategory(dryGrassFruitType.index, pickupFruitTypeCategory)
        print("FruitType 'DRYGRASS' added to FruitTypeCategory 'PICKUP'")
    else
        print("FruitTypeCategory 'PICKUP' not found")
    end

    -- Add Drygrass converter
    local conversionFactor = 1.0
    local windrowConversionFactor = 1.0

    local forageHarvesterConverter = g_fruitTypeManager.converterNameToIndex.FORAGEHARVESTER

    if dryGrassWindrowFillType ~= nil then
        if forageHarvesterConverter ~= nil then
            g_fruitTypeManager:addFruitTypeConversion(forageHarvesterConverter, dryGrassFruitType.index, dryGrassWindrowFillType.index, conversionFactor, windrowConversionFactor)
            print("FruitTypeConversion 'DRYGRASS' added to FruitTypeConverter 'FORAGEHARVESTER'")
        else
            print("Converter 'FORAGEHARVESTER' not found")
        end
    else
        print("FillType 'DRYGRASS_WINDROW' not found")
    end
end

addModEventListener(ForageHayPickup)