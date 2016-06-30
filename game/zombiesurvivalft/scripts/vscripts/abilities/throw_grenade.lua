
function OnSpellStart(data)
	--print("throw_grenade OnSpellStart")
	local caster = data.caster
	caster:AddAbility("throw_grenade")
	local ability = caster:FindAbilityByName("throw_grenade")
	ability:SetLevel(1)
	ability:CastAbility()
	StartSoundEvent("Hero_Alchemist.UnstableConcoction.Fuse", caster)
	
	
	Timers:CreateTimer(2,function()	
		caster:RemoveAbility("throw_grenade")
		return nil
	end)
	
	
	Timers:CreateTimer(1,function()	
		StartSoundEvent("Hero_Techies.Suicide", caster)
		StopSoundEvent("Hero_Alchemist.UnstableConcoction.Fuse", caster)
		return nil		
	end)

	local charges = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == "item_grenade" then
				if item:GetCurrentCharges() > 1 then
					charges = item:GetCurrentCharges()
					item:SetCurrentCharges(charges-1)
				else
					caster:RemoveItem(item)
				end
			end
		end
	end	
	
	
	
end

