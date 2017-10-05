forward_vision = class({})

function GetForwardVision(data)
    local caster = data.caster
    local pointShort = caster:GetAbsOrigin() + caster:GetForwardVector()*150
    local pointMiddle = caster:GetAbsOrigin() + caster:GetForwardVector()*350
    local pointLong = caster:GetAbsOrigin() + caster:GetForwardVector()*550    
    local ability = data.ability
    ability:CreateVisibilityNode(pointShort, ability:GetSpecialValueFor("max_radius")/2, 0.1)
    ability:CreateVisibilityNode(pointMiddle, ability:GetSpecialValueFor("max_radius"), 0.1)
    ability:CreateVisibilityNode(pointLong, ability:GetSpecialValueFor("max_radius")+100, 0.1)
end