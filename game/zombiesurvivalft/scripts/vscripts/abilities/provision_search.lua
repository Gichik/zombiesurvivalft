
if provision_search == nil then
	provision_search = class({})
end


function provision_search:GetChannelAnimation()
    return ACT_DOTA_ATTACK2
end

function provision_search:GetCastAnimation()
    return ACT_DOTA_ATTACK2
end

function provision_search:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

	end
end

function provision_search:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

	end
end

function provision_search:OnChannelFinish(interrupted)
	if IsServer() then
		if interrupted == false then
			print("ChannelSucceeded")
			local target = self:GetCursorTarget()
			if target and target:HasAbility("provision_status") then
				target:ForceKill(false)
			end

		else
			print("ChannelInterrupted")
		end
	end
end