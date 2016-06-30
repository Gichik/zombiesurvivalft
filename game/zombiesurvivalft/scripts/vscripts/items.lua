defoultModel = nil
defoultMoveSpeed = 0

function CreateWoodWall(data)
--print("CreatWoodWall")
data.target:SetHullRadius(30.0)
data.target:SetForwardVector(data.caster:GetForwardVector())
end


function DestroyWoodWall(data)
--print("DestroyWoodWall")
data.caster:ForceKill(false)
--StartSoundEvent("Hero_Furion.Sprout", data.caster)
end

function AddAbilityToHero(data)
--print("AddAbilityToActivator")
--print(data.ability_name)
local hero = data.caster
if hero:FindAbilityByName(data.ability_name) == nil then
	hero:AddAbility(data.ability_name)
	local ability = hero:FindAbilityByName(data.ability_name)
	ability:SetLevel(1)
end
end


function RemoveAbilityFromHero(data)
--print("RemoveAbilityToActivator")
local hero = data.caster

if hero:HasItemInInventory(data.item_name) == false then
	local ability = hero:FindAbilityByName(data.ability_name)
	hero:RemoveAbility(data.ability_name)
end

end


function GiveMana(data)
--print("give mana")
data.caster:GiveMana(100)
StartSoundEvent("Item.MoonShard.Consume", data.caster)
end



function GiveHealth(data)
--print("give heal")
local health = data.caster:GetHealth()+100
data.caster:SetHealth(health)
StartSoundEvent("DOTA_Item.Cheese.Activate", data.caster)
end

function GiveBloodTube(data)
--print("GiveBloodTube")
local caster = data.caster
local health = data.caster:GetHealth()-10
local info = 
	{
	caster = data.caster,
	item_name = "item_syringe"
	}
RemoveItemFromHero(info)

local position = caster:GetAbsOrigin()		
CreateDrop("item_blood_tube", position)


if data.caster:GetHealth() <= 10 then
	data.caster:ForceKill(true)
else
	data.caster:SetHealth(health)
end

StartSoundEvent("DOTA_Item.Maim", data.caster)

end


function RemoveItemFromHero(data)
local caster = data.caster
local item = nil
local charges = 0
local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name and first == 0 then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
					else
						caster:RemoveItem(item)
					end
				else
					caster:RemoveItem(item)			
				end
				first = 1
			end
		end
	end	
end


function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end 


function EquipSuit(data)

local hero = data.caster
defoultModel = hero:GetModelName()
defoultMoveSpeed = hero:GetBaseMoveSpeed()
hero:SetModel("models/heroes/elder_titan/ancestral_spirit.vmdl")
hero:SetOriginalModel("models/heroes/elder_titan/ancestral_spirit.vmdl")
hero:SetBaseMoveSpeed(200)

end



function UnEquipSuit(data)

local hero = data.caster
local name = hero:GetName()
hero:SetModel(defoultModel)
hero:SetOriginalModel(defoultModel)
hero:SetBaseMoveSpeed(defoultMoveSpeed)

end

function GiveWin(data)
--print("give Win")
StartSoundEvent("Item.MoonShard.Consume", data.caster)
ShowGenericPopup( "#popup_title_win", "#popup_body_win", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
end

function GiveDefeat(data)
--print("give Defeat")
data.caster:ForceKill(true)
StartSoundEvent("DOTA_Item.Maim", data.caster)
ShowGenericPopup( "#popup_title_defeat", "#popup_body_defeat", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
end