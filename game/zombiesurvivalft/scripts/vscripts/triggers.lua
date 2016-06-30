firstHospital = 1
firstPoliceStation = 1
firstLibrary = 1
firstScienceCenter = 1



function GiveInvisible(data)
--print("giveInvisible")
local hero = data.activator
if hero:FindAbilityByName("hide") == nil then
	hero:AddAbility("hide")
	local ability = hero:FindAbilityByName("hide")
	ability:SetLevel(1)
	ability:CastAbility()
	StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
end


end

function RemoveInvisible(data)
local hero = data.activator
local ability = hero:FindAbilityByName("hide")
if ability ~= nil then
hero:RemoveAbility("hide")
hero:RemoveModifierByName("modifier_bounty_hunter_wind_walk")
end
end


function GivePoliceStationScrapAbility(data)
--print("GiveScrapAbility")
local hero = data.activator
if PolicemanLock == 1 then
	if hero:HasItemInInventory("item_scrap") then

		if hero:FindAbilityByName("use_scrap_on_police_station") == nil then
			hero:AddAbility("use_scrap_on_police_station")
			local ability = hero:FindAbilityByName("use_scrap_on_police_station")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end
	else
		if hero:FindAbilityByName("ability_lock") == nil then
			hero:AddAbility("ability_lock")
			local ability = hero:FindAbilityByName("ability_lock")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end	
	end
else

	local ent = Entities:FindByName( nil, "PoliceStation_point") 
	local entPoint = ent:GetAbsOrigin() 
	hero:SetAbsOrigin(entPoint) 
	FindClearSpaceForUnit(hero, entPoint, false) 
	hero:Stop()
	FocusCameraOnPlayer(hero)
	if firstPoliceStation == 1 then
		EmitGlobalSound("ZombieSurvivalFT.PoliceStation")
		firstPoliceStation = 0
	end
end

end

function GiveHospitalScrapAbility(data)
--print("GiveScrapAbility")
local hero = data.activator
if HospitalLock == 1 then
	if hero:HasItemInInventory("item_scrap") then

		if hero:FindAbilityByName("use_scrap_on_hospital") == nil then
			hero:AddAbility("use_scrap_on_hospital")
			local ability = hero:FindAbilityByName("use_scrap_on_hospital")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end
	else
		if hero:FindAbilityByName("ability_lock") == nil then
			hero:AddAbility("ability_lock")
			local ability = hero:FindAbilityByName("ability_lock")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end	
	end
else

	local ent = Entities:FindByName( nil, "hospital_point") 
	local entPoint = ent:GetAbsOrigin() 
	hero:SetAbsOrigin(entPoint) 
	FindClearSpaceForUnit(hero, entPoint, false) 
	hero:Stop()
	FocusCameraOnPlayer(hero)
	if firstHospital == 1 then
		EmitGlobalSound("ZombieSurvivalFT.Hospital")
		firstHospital = 0
	end

end

end



function GiveLibraryScrapAbility(data)
--print("GiveScrapAbility")
local hero = data.activator
if LibraryLock == 1 then
	if hero:HasItemInInventory("item_scrap") then

		if hero:FindAbilityByName("use_scrap_on_library") == nil then
			hero:AddAbility("use_scrap_on_library")
			local ability = hero:FindAbilityByName("use_scrap_on_library")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end
	else
		if hero:FindAbilityByName("ability_lock") == nil then
			hero:AddAbility("ability_lock")
			local ability = hero:FindAbilityByName("ability_lock")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end	
	end
else

	local ent = Entities:FindByName( nil, "library_point") 
	local entPoint = ent:GetAbsOrigin() 
	hero:SetAbsOrigin(entPoint) 
	FindClearSpaceForUnit(hero, entPoint, false) 
	hero:Stop()
	FocusCameraOnPlayer(hero)
	if firstLibrary == 1 then
		EmitGlobalSound("ZombieSurvivalFT.Library")
		firstLibrary = 0
	end

end

end


function GiveScienceCenterScrapAbility(data)
--print("GiveScrapAbility")
local hero = data.activator
if ScienceCenterLock == 1 then
	if hero:HasItemInInventory("item_scrap") then

		if hero:FindAbilityByName("use_scrap_on_science_center") == nil then
			hero:AddAbility("use_scrap_on_science_center")
			local ability = hero:FindAbilityByName("use_scrap_on_science_center")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end
	else
		if hero:FindAbilityByName("ability_lock") == nil then
			hero:AddAbility("ability_lock")
			local ability = hero:FindAbilityByName("ability_lock")
			ability:SetLevel(1)
			--StartSoundEvent("DOTA_Item.InvisibilitySword.Activate", hero)
		end	
	end
else

	local ent = Entities:FindByName( nil, "ScienceCenter_point") 
	local entPoint = ent:GetAbsOrigin() 
	hero:SetAbsOrigin(entPoint) 
	FindClearSpaceForUnit(hero, entPoint, false) 
	hero:Stop()
	FocusCameraOnPlayer(hero)
	if firstScienceCenter == 1 then
		EmitGlobalSound("ZombieSurvivalFT.Horror2")
		firstScienceCenter = 0
	end

end

end


function RemoveScrapAbility(data)
local hero = data.activator
local ability = hero:FindAbilityByName("use_scrap_on_police_station")
if ability ~= nil then
	hero:RemoveAbility("use_scrap_on_police_station")
end

ability = hero:FindAbilityByName("use_scrap_on_hospital")
if ability ~= nil then
	hero:RemoveAbility("use_scrap_on_hospital")
end

ability = hero:FindAbilityByName("use_scrap_on_library")
if ability ~= nil then
	hero:RemoveAbility("use_scrap_on_library")
end

local ability = hero:FindAbilityByName("use_scrap_on_science_center")
if ability ~= nil then
	hero:RemoveAbility("use_scrap_on_science_center")
end


ability = hero:FindAbilityByName("ability_lock")
if ability ~= nil then
	hero:RemoveAbility("ability_lock")
end
end



function BackToPoliceStation(data)
local hero = data.activator
local ent = Entities:FindByName( nil, "PoliceStation_point_2") 
local entPoint = ent:GetAbsOrigin() 
hero:SetAbsOrigin(entPoint) 
FindClearSpaceForUnit(hero, entPoint, false) 
hero:Stop()
FocusCameraOnPlayer(hero)
end


function BackToHospital(data)
local hero = data.activator
local ent = Entities:FindByName( nil, "hospital_point_2") 
local entPoint = ent:GetAbsOrigin() 
hero:SetAbsOrigin(entPoint) 
FindClearSpaceForUnit(hero, entPoint, false) 
hero:Stop()
FocusCameraOnPlayer(hero)
end


function BackToLibrary(data)
local hero = data.activator
local ent = Entities:FindByName( nil, "library_point_2") 
local entPoint = ent:GetAbsOrigin() 
hero:SetAbsOrigin(entPoint) 
FindClearSpaceForUnit(hero, entPoint, false) 
hero:Stop()
FocusCameraOnPlayer(hero)
end

function BackToScienceCenter(data)
local hero = data.activator
local ent = Entities:FindByName( nil, "ScienceCenter_point_2") 
local entPoint = ent:GetAbsOrigin() 
hero:SetAbsOrigin(entPoint) 
FindClearSpaceForUnit(hero, entPoint, false) 
hero:Stop()
FocusCameraOnPlayer(hero)
end


function GiveDevelopmentAbility(data)
--print("AddDevelopmentAbility")
local hero = data.activator
if hero:FindAbilityByName("development") == nil then
	hero:AddAbility("development")
	local ability = hero:FindAbilityByName("development")
	ability:SetLevel(1)
end
end


function RemoveDevelopmentAbility(data)
--print("RemoveDevelopmentAbility")
data.activator:RemoveAbility("development")
end

function MessageRadiation(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_MRadiation", "#popup_body_MRadiation", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end

function MessageScrapWay(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_ScrapWay", "#popup_body_ScrapWay", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end

function MessageHospitalWay(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_HospitalWay", "#popup_body_HospitalWay", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end

function MessageLibraryWay(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_LibraryWay", "#popup_body_LibraryWay", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end

function MessageScienceCenterWay(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_ScienceCenterWay", "#popup_body_ScienceCenterWay", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end

function MessagePoliceStation(data)
ShowGenericPopupToPlayer( data.activator:GetPlayerOwner(), "#popup_title_MPoliceStation", "#popup_body_MPoliceStation", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
end



function GiveParkInformation(data)
local hero = data.activator
if hero:FindAbilityByName("park_information") == nil then
	hero:AddAbility("park_information")
	local ability = hero:FindAbilityByName("park_information")
	ability:SetLevel(1)
end
end

function GiveForestInformation(data)
local hero = data.activator
if hero:FindAbilityByName("forest_information") == nil then
	hero:AddAbility("forest_information")
	local ability = hero:FindAbilityByName("forest_information")
	ability:SetLevel(1)
end
end

function GivePoliceStationInformation(data)
local hero = data.activator
if hero:FindAbilityByName("police_station_information") == nil then
	hero:AddAbility("police_station_information")
	local ability = hero:FindAbilityByName("police_station_information")
	ability:SetLevel(1)
end
end

function GiveLibraryInformation(data)
local hero = data.activator
if hero:FindAbilityByName("library_information") == nil then
	hero:AddAbility("library_information")
	local ability = hero:FindAbilityByName("library_information")
	ability:SetLevel(1)
end
end

function GiveScienceCenterInformation(data)
local hero = data.activator
if hero:FindAbilityByName("science_center_information") == nil then
	hero:AddAbility("science_center_information")
	local ability = hero:FindAbilityByName("science_center_information")
	ability:SetLevel(1)
end
end


function GiveHospitalInformation(data)
local hero = data.activator
if hero:FindAbilityByName("hospital_information") == nil then
	hero:AddAbility("hospital_information")
	local ability = hero:FindAbilityByName("hospital_information")
	ability:SetLevel(1)
end
end



function GiveRadiationInformation(data)
local hero = data.activator
if hero:FindAbilityByName("radiation_information") == nil then
	hero:AddAbility("radiation_information")
	local ability = hero:FindAbilityByName("radiation_information")
	ability:SetLevel(1)
end
end




function GiveHideInformation(data)
local hero = data.activator
if hero:FindAbilityByName("hide_information") == nil then
	hero:AddAbility("hide_information")
	local ability = hero:FindAbilityByName("hide_information")
	ability:SetLevel(1)
end
end

function RemoveInformation(data)
local hero = data.activator

	if hero:FindAbilityByName("park_information") ~= nil then
		hero:RemoveAbility("park_information")
	end

	if hero:FindAbilityByName("forest_information") ~= nil then
		hero:RemoveAbility("forest_information")
	end

	if hero:FindAbilityByName("police_station_information") ~= nil then
		hero:RemoveAbility("police_station_information")
	end

	if hero:FindAbilityByName("library_information") ~= nil then
		hero:RemoveAbility("library_information")
	end

	if hero:FindAbilityByName("science_center_information") ~= nil then
		hero:RemoveAbility("science_center_information")
	end

	if hero:FindAbilityByName("hospital_information") ~= nil then
		hero:RemoveAbility("hospital_information")
	end

	if hero:FindAbilityByName("radiation_information") ~= nil then
		hero:RemoveAbility("radiation_information")
	end

	if hero:FindAbilityByName("hide_information") ~= nil then
		hero:RemoveAbility("hide_information")
	end

end

function FocusCameraOnPlayer(player)
	PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
	GameRules:GetGameModeEntity():SetContextThink(string.format("PlayerTP_%d", player:GetPlayerOwnerID()), 
	function()
		PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)	
	return nil
	end,
	1)
end