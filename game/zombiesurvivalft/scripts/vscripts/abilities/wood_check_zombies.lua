
function Check(data)
	--print("Check")
	local caster = data.caster
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 100,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then 
		if units[ 1 ]:GetUnitName() == "zombie" or units[ 1 ]:GetUnitName() == "fat_zombie" or units[ 1 ]:GetUnitName() == "half_zombie" or units[ 1 ]:GetUnitName() == "fast_zombie" then
			local health = caster:GetHealth()-100
			if caster:GetHealth() <= 100 then
				caster:ForceKill(true)
			else
				caster:SetHealth(health)
			end
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			StartSoundEvent("DOTA_Item.Maim", data.caster)
		end

	end
	
end
