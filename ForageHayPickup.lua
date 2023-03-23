ForageHayPickup = {}
ForageHayPickup.modDir = g_currentModDirectory


function ForageHayPickup:addFruitType(fruitType)
    table.insert(g_fruitTypeManager.fruitTypes, fruitType)

    g_fruitTypeManager.nameToFruitType[fruitType.name] = fruitType
    g_fruitTypeManager.nameToIndex[fruitType.name] = fruitType.index
    g_fruitTypeManager.indexToFruitType[fruitType.index] = fruitType
    g_fruitTypeManager.fillTypeIndexToFruitTypeIndex[fruitType.fillType.index] = fruitType.index
    g_fruitTypeManager.fruitTypeIndexToFillType[fruitType.index] = fruitType.fillType

    local windrowFillType = g_fillTypeManager:getFillTypeByName(fruitType.windrowName)
    g_fruitTypeManager.windrowFillTypes[windrowFillType.index] = true
    g_fruitTypeManager.fruitTypeIndexToWindrowFillTypeIndex[fruitType.index] = windrowFillType.index
    g_fruitTypeManager.fillTypeIndexToFruitTypeIndex[windrowFillType.index] = fruitType.index
end

function ForageHayPickup:loadMap(name)
	-- Add Hay to Forage Harvester Fill Type Category
	local dryGrassWindrowFillType = g_fillTypeManager:getFillTypeByName("DRYGRASS_WINDROW")
	if dryGrassWindrowFillType ~= nil then
		local fillTypeCategoryForageHarvester = g_fillTypeManager.nameToCategoryIndex.FORAGEHARVESTER
		if fillTypeCategoryForageHarvester ~= nil then
			g_fillTypeManager:addFillTypeToCategory(dryGrassWindrowFillType.index, fillTypeCategoryForageHarvester)
            print("FillType 'DRYGRASS_WINDROW' added to FillTypeCategory 'FORAGEHARVESTER'")
		else
			print("FillTypeCategory 'FORAGEHARVESTER' not found")
		end
	else
		print("FillType 'DRYGRASS_WINDROW' not found")
	end
	
	-- Add Drygrass Fruit Type
	local dryGrassFruitType = g_fruitTypeManager:addFruitType("DRYGRASS", false, false)
    if dryGrassFruitType ~= nil then
        dryGrassFruitType.literPerSqm = 3.28
        dryGrassFruitType.hasWindrow = true
        dryGrassFruitType.windrowName = "DRYGRASS_WINDROW" -- Replace with ref to fill type?
        dryGrassFruitType.windrowLiterPerSqm = 4.37
        ForageHayPickup:addFruitType(dryGrassFruitType)
        print("FruitType 'DRYGRASS' added")
    else
        print("FruitType 'DRYGRASS' not added")
    end

	-- Add Drygrass to Pickup Fruit Type Category
	local pickupFruitTypeCategory = g_fruitTypeManager.categories.PICKUP
    if pickupFruitTypeCategory ~= nil then
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