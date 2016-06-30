function PudgeCastAcidSlime(data)
local ability = data.caster:FindAbilityByName("acid_slime")
local point = data.caster:GetOrigin()
data.caster:CastAbilityOnPosition(point, ability, -1 )
data.caster:ForceKill(false)
StartSoundEvent("Hero_LifeStealer.Assimilate.Destroy", data.caster)
end

function Respawn(data)
local name = data.caster:GetUnitName()
local ability = data.caster:FindAbilityByName("respawn")
local IDspawn = ability:GetCastPoint()
local way = nil

Timers:CreateTimer(60,function()
	local point = Entities:FindByName( nil, "spawn_" .. IDspawn ):GetAbsOrigin()
	local unit = CreateUnitByName(name, point + RandomVector( RandomFloat( 0, 100 ) ), true, nil, nil, DOTA_TEAM_BADGUYS )
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(IDspawn)
	if IDspawn > 100 then
		way = Entities:FindByName( nil, "way_" .. IDspawn) 
		unit:SetInitialGoalEntity( way )
	end
return nil
end)
end



function BleedingDamage(data)
--print("BleedingDamage")
	local health = data.target:GetHealth()-1
	if health > 1 then
		data.target:SetHealth(health)
	else
		data.target:ForceKill(true)
		FireGameEvent("dota_player_killed", {PlayerID = data.target:GetPlayerID(), HeroKill = true, TowerKill = false})
	end

end

function ZombieAttack(data)
--print("ZombieAttack")
	local caster = data.caster
	local sound = {}
	sound["fat_zombie"] = "ZombieSurvivalFT.zombie_fat"
	sound["zombie"] = "ZombieSurvivalFT.zombie"
	sound["half_zombie"] = "ZombieSurvivalFT.zombie_girl"
	sound["fast_zombie"] = "ZombieSurvivalFT.zombie_dog"
	sound["fat_zombie_one"] = "ZombieSurvivalFT.zombie_fat"
	sound["fat_zombie_two"] = "ZombieSurvivalFT.zombie_fat"
	sound["fat_zombie_three"] = "ZombieSurvivalFT.zombie_fat"
	sound["fat_zombie_four"] = "ZombieSurvivalFT.zombie_fat"
	sound["fat_zombie_five"] = "ZombieSurvivalFT.zombie_fat"
	
	local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, 800,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then  
		EmitSoundOn(sound[caster:GetUnitName()], data.caster)
	end

end