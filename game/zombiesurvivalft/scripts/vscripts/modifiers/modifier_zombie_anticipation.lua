modifier_zombie_anticipation = class({})


function modifier_zombie_anticipation:IsHidden()
	return false
end


function modifier_zombie_anticipation:GetTexture()
    return "custom_folder/zombie_anticipation"
end


function modifier_zombie_anticipation:OnCreated( data )
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local time = 2

		if time > ability:GetSpecialValueFor("cooldown") then
			time = ability:GetSpecialValueFor("cooldown")
		end 

		StartSoundEvent(TABLE_ZOMBIE_GROWL[RandomInt(1,#TABLE_ZOMBIE_GROWL)], caster)
		GameRules:GetGameModeEntity():SetContextThink(string.format("AnticipationThink_%d",caster:GetEntityIndex()), 
			function()
				caster:SetBaseMoveSpeed(caster:GetBaseMoveSpeed() - ability:GetSpecialValueFor("bonus_move_speed"))
			end,
			time)	
	end
end

function modifier_zombie_anticipation:RemoveOnDeath()
	return true
end