
if item_camp_misc == nil then
    item_camp_misc = class({})
end


function item_camp_misc:GetBehavior() 
    local behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behavior
end

function item_camp_misc:GetAbilityTextureName(brokenAPI)
  return self.BaseClass.GetAbilityTextureName( self )
end

--[[
function item_camp_misc:OnSpellStart()
	--print("OnSpellStart")
	local caster = self:GetCaster()
	local entity = nil
	entity = Entities:FindInSphere(caster,caster:GetAbsOrigin(),300)

	if entity then
		if entity:GetName():match("spawn_campfire") == "spawn_campfire" then

			local unit = CreateUnitByName("npc_campfire", entity:GetAbsOrigin(), false, nil, nil, DOTA_TEAM_NEUTRALS)

			GameRules:GetGameModeEntity():SetContextThink(string.format("ForceKillThink_%d",unit:GetEntityIndex()), 
				function()
					unit:ForceKill(true)
				end,
				20)

			RemoveCMFromHero(self)
		end 
	end
end]]

function item_camp_misc:OnSpellStart()
	--print("OnSpellStart")
	local caster = self:GetCaster()

	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 300,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	for i = 0, #units do	
		if units[i] and units[i]:GetUnitName() == "npc_campfire" then

			local pID1 = ParticleManager:CreateParticle("particles/dev/library/base_fire.vpcf", PATTACH_ABSORIGIN, units[i])
			local team = units[i]:GetTeamNumber()

			units[i]:SetTeam(caster:GetTeamNumber())

			GameRules:GetGameModeEntity():SetContextThink(string.format("DeleteAbilityThink_%d",units[i]:GetEntityIndex()), 
				function()
					units[i]:SetTeam(team)
					ParticleManager:DestroyParticle(pID1,true)
				end,
				self:GetSpecialValueFor("duration"))
			RemoveCMFromHero(self)
		end
	end
end


function RemoveCMFromHero(ability)
	local caster = ability:GetCaster()
	local item = nil
	local charges = 0
	local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == ability:GetName() then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
						return nil
					else
						caster:RemoveItem(item)
						return nil
					end
				else
					caster:RemoveItem(item)	
					return nil		
				end
			end
		end
	end	
end