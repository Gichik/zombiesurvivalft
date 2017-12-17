forward_vision = class({})

function GetForwardVision(data)
    local caster = data.caster
    local pointShort = caster:GetAbsOrigin() + caster:GetForwardVector()*100
    local pointLong = caster:GetAbsOrigin() + caster:GetForwardVector()*350
    local ability = data.ability
    local maxRadius =  ability:GetSpecialValueFor("max_radius")
	local minRadius =  maxRadius/4

    --if not HasEntity(pointShort,10) then
    	ability:CreateVisibilityNode(pointShort, minRadius, 0.1)
    	--print("hmm")
		--AddFOWViewer(caster:GetTeam(),pointShort,10,0.1,false)
	--end
    if not HasEntity(pointLong,maxRadius/2) and not HasEntity(pointShort, minRadius/2) then
		--AddFOWViewer(caster:GetTeam(),pointLong,ability:GetSpecialValueFor("max_radius")+100,0.1,true)
    	ability:CreateVisibilityNode(pointLong, maxRadius, 0.1)
	end
end

function HasEntity(point, radius)

	for _, ent in pairs(Entities:FindAllInSphere(point, radius)) do
		if ent:GetName():match("block_vision") then
			return true
		end
	end

	return false
end

