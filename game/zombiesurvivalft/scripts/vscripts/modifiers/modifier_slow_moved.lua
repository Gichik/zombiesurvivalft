modifier_slow_moved = class({})


function modifier_slow_moved:GetModifierMoveSpeedOverride()
	return 5;
end


function modifier_slow_moved:IsDebuff()
	return true
end

 
function modifier_slow_moved:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
	}
 
	return funcs
end



--modifier_mage_polymorph


 